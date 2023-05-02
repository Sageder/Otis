import SwiftUI

enum StudyStyle {
    case None
    case FlashCard
    case Learn
    case Answer
}

struct StudyView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @State var studyStyle: StudyStyle = .None
    @State private var showPopup: Bool = false
    @State private var animateButton: Bool = false
    @State private var rows: [[Int]] = []
    @State private var selectedCardIndex: Int = -1
    @State private var showMenu: Bool = false
    @State private var index1: CGFloat = 2
    @State private var index2: CGFloat = 2
    @State private var vocabNumber: CGFloat = 25
    
    var body: some View {
        ZStack {
            if studyStyle == .None {
                StudyHomeView()
                
                if showPopup {
                    StudyPopupView()
                }
            } else if studyStyle == .FlashCard{
                StudyFlashCardView(env: _env, studyStyle: $studyStyle, index: selectedCardIndex)
            } else if studyStyle == .Answer {
                StudyAnswerView(env: _env, studyStyle: $studyStyle, index: selectedCardIndex)
            } else if studyStyle == .Learn {
                StudyLearnView(env: _env, studyStyle: $studyStyle, index: selectedCardIndex)
            } 
        }
        .onAppear(perform: {
            generateHexagonGrid()
            generateIndexForSpecial()
        })
        .onDisappear(perform: {
            rows = []
        })
    }
    
    @ViewBuilder
    func StudyHomeView()->some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15){
                    HStack {
                    Text("Lernsets")
                        .font(isMacOS() ? . system(size: 33, weight: .bold) : .largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                        
                        Spacer()
                        
                        Button{
                            showPopup = false
                            showMenu.toggle()
                        } label: {
                            Image(systemName: showMenu ? "xmark" : "slider.horizontal.3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(.title3)
                                .frame(width: showMenu ? 14 : 18, height: 18, alignment: .trailing)
                            #if os(iOS)
                                .foregroundColor(Color("Main"))
                            #endif
                        }
                    }
                    
                    if showMenu {
                        StudyMenuView()
                    }
                    
                    VStack(spacing: -10){
                        ForEach(rows.indices, id: \.self){index in
                            HStack(spacing: 10){
                                ForEach(rows[index], id: \.self){ value in
                                    Button(action: {
                                        if value == 0 {
                                            generateRandomVocabulary()
                                        } else if value == 1 {
                                            generateBookmarkVocabulary()
                                        }
                                        
                                        withAnimation {
                                            selectedCardIndex = value
                                            animateButton.toggle()
                                        }
                                        
                                        withAnimation(.spring()) {
                                            showPopup = true
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                            withAnimation(.spring()){
                                                animateButton.toggle()
                                            }
                                        }
                                    }, label: {
                                        ZStack {
                                            let width: CGFloat = CGFloat(proxy.size.width - 20)
                                            let isBig: Bool = isMacOS() ? width / 6 > 140 : width / 3 > 140
                                            let hexWidth: CGFloat = isMacOS() ? /* MacOS */ isBig ? 140 : width / 6 : /* iOS */ isBig ? 140 : width / 3
                                            let hexHeight: CGFloat = isMacOS() ? /* MacOS */ isBig ? (140 * 1.15) : ((width / 6) * 1.15) : /* IOS */ isBig ? (140 * 1.15) : ((width / 3) * 1.15)
                                            
                                            Hexagon()
                                                .fill(Color("Skin"))
                                                .frame(width: hexWidth, height: hexHeight)
                                            
                                            Text(env.GetCourse().vocabulary[value].title)
                                                .font(.title2)
                                                .foregroundColor(Color("Main"))
                                        }
                                        .scaleEffect(animateButton && selectedCardIndex == value ? 1.1 : 1)
                                    })
                                }
                            }
                        }
                    }
                }
                .padding(.top, isMacOS() ? 45 : 30)
            }
        }
    }
    
    @ViewBuilder
    func StudyMenuView()->some View {
        VStack(alignment: .center){
            if env.GetCourse().vocabulary.count - 2 > 0 {
                Divider()
                
                Text("Lernset - Zufällig")
                    .font(.title3)
                    .foregroundColor(Color("Main"))
                
                if isMacOS() {
                    HStack {
                        Text("Min. Lernset: \(env.GetCourse().vocabulary[Int(index1)].title)")
                            .foregroundColor(Color("Main"))
                        
                        Slider(value: $index1, in: 2...(index2))
                        
                        Text("Max. Lernset: \(env.GetCourse().vocabulary[Int(index2)].title)")
                            .foregroundColor(Color("Main"))
                        
                        Slider(value: $index2, in: index1...CGFloat(env.GetCourse().vocabulary.count - 1))
                    }
                } else {
                    VStack {
                        HStack {
                            Text("Min. Lernset: \(env.GetCourse().vocabulary[Int(index1)].title)")
                                .foregroundColor(Color("Main"))
                            
                            Slider(value: $index1, in: 2...(index2))
                        }
                        
                        HStack {
                            Text("Max. Lernset: \(env.GetCourse().vocabulary[Int(index2)].title)")
                                .foregroundColor(Color("Main"))
                            
                            Slider(value: $index2, in: index1...CGFloat(env.GetCourse().vocabulary.count - 1))
                        }
                    }
                }
                
                HStack {
                    Text("Max. Zufallsvokabeln: \(Int(vocabNumber))")
                        .foregroundColor(Color("Main"))
                    
                    Slider(value: $vocabNumber, in: 10...50)
                }
                
                Divider()
            }
        }
    }
    
    @ViewBuilder
    func StudyPopupView()->some View {
        VStack(alignment: .center, spacing: 15){
            PopupView(show: $showPopup, data: [
                PopupData(title: "Karteikarten", image: "rectangle.on.rectangle.angled", action: {
                    if env.GetCourse().vocabulary.count == 0 || env.GetCourse().vocabulary[selectedCardIndex].vocabulary.count == 0{
                        return
                    }
                    
                    showPopup = false
                    studyStyle = .FlashCard
                }),
                PopupData(title: "Lernen", image: "arrow.triangle.2.circlepath", action: {
                    if env.GetCourse().vocabulary.count == 0 || env.GetCourse().vocabulary[selectedCardIndex].vocabulary.count == 0{
                        return
                    }
                    
                    showPopup = false
                    studyStyle = .Learn
                }),
                PopupData(title: "Antworten", image: "rectangle.and.pencil.and.ellipsis", action: {
                    if env.GetCourse().vocabulary.count == 0 || env.GetCourse().vocabulary[selectedCardIndex].vocabulary.count == 0{
                        return
                    }
                    
                    showPopup = false
                    studyStyle = .Answer
                })
            ])
        }
    }
    
    func generateHexagonGrid(){
        var count = 0
        var generated: [Int] = []
        
        if env.GetCourse().vocabulary.count == 0{
            return
        }
        
        for i in 0...(env.GetCourse().vocabulary.count - 1) {
            generated.append(i)
            
            if generated.count == 2 {
                if let last = rows.last {
                    if last.count == 3 {
                        rows.append(generated)
                        generated.removeAll()
                    }
                }
                
                if rows.isEmpty {
                    rows.append(generated)
                    generated.removeAll()
                }
            }
            
            if generated.count == 3 {
                if let last = rows.last {
                    if last.count == 2 {
                        rows.append(generated)
                        generated.removeAll()
                    }
                }
            }
            
            count += 1
            
            if count == env.GetCourse().vocabulary.count {
                if generated.count == 1 {
                    rows.append(generated)
                    generated.removeAll()
                }
                
                if generated.count == 2 {
                    rows.append(generated)
                    generated.removeAll()
                }
            }
        }
    }
    
    func generateRandomVocabulary() {
        if env.GetCourse().vocabulary.count - 2 <= 0 {
            return
        }
        
        var randomModel = VocabularyModel(title: "Random", vocabulary: [])
        var randomLektionIndex: [Int] = []
        var randomVocabIndex: [Int] = []
        
        let minLektion = Int(index1)
        let maxLektion = Int(index2)
        
        for _ in 0...Int(vocabNumber - 1) {
            var pass = false
            var passes = 0
            
            while !pass {
                let randomLektion = minLektion < maxLektion ? Int.random(in: minLektion...maxLektion) : minLektion
                if env.GetCourse().vocabulary[randomLektion].vocabulary.count != 0 {
                    let randomVocab = Int.random(in: 0...(env.GetCourse().vocabulary[randomLektion].vocabulary.count - 1))
                    
                    if randomLektionIndex.isEmpty || !(randomVocabIndex.contains(randomLektion) && randomVocabIndex.contains(randomVocab)) {
                        randomLektionIndex.append(randomLektion)
                        randomVocabIndex.append(randomVocab)
                        randomModel.vocabulary.append(env.GetCourse().vocabulary[randomLektion].vocabulary[randomVocab])
                        pass = true
                    }
                }
                
                passes += 1
                if (passes == 30){
                    pass = true
                    print("Warning: generateRandomVocabulary, while loop passed \(passes)!")
                }
            }
        }
        
        env.courses[env.currentCourse].vocabulary.remove(at: 0);
        env.courses[env.currentCourse].vocabulary.insert(randomModel, at: 0)
    }
    
    func generateBookmarkVocabulary(){
        if env.GetCourse().vocabulary.count - 2 <= 0 {
            return
        }
        
        var bookmarkModel = VocabularyModel(title: "Saved", vocabulary: [])
        
        var bookmarkVocabulary: [VocabularyDefinition] = []
        
        for learnset in env.GetCourse().vocabulary {
            for vocable in learnset.vocabulary {
                if vocable.bookmarked {
                    bookmarkVocabulary.append(vocable)
                }
            }
        }
        
        if !bookmarkVocabulary.isEmpty {
            let amount = (bookmarkVocabulary.count - 1) > Int(vocabNumber - 1) ? Int(vocabNumber - 1): (bookmarkVocabulary.count - 1)
            
            for _ in 0...amount {
                var pass = false
                var passes = 0
                
                while !pass {
                    let randomVocab = bookmarkVocabulary[Int.random(in: 0...(bookmarkVocabulary.count - 1))]
                    
                    if !bookmarkModel.vocabulary.contains(randomVocab) {
                        bookmarkModel.vocabulary.append(randomVocab)
                        pass = true
                    }
                    
                    passes += 1
                    if (passes == 30){
                        pass = true
                        print("Warning: generateBookmarkVocabulary, while loop passed \(passes)!")
                    }
                }
            }
        }
        
        env.courses[env.currentCourse].vocabulary.remove(at: 1)
        env.courses[env.currentCourse].vocabulary.insert(bookmarkModel, at: 1)
    }
    
    func generateIndexForSpecial(){
        index2 = CGFloat(env.GetCourse().vocabulary.count - 1)
        index1 = CGFloat(2)
    }
}

struct FlashCardText {
    var mainText: String
    var otherText: String
}

struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView(env: EnvironmentObject<GlobalEnvironment>())
    }
}
