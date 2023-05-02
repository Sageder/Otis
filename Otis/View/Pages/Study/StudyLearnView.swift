import SwiftUI

struct StudyLearnView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @Binding var studyStyle: StudyStyle
    @State private var vocabulary: [VocabularyDefinition]
    @State private var vocable: VocabularyDefinition
    @State private var otherWords: [String]
    @State private var buttonIndex: Int
    @State private var progress: Int = 0
    @State private var percent: CGFloat = 0
    @State private var showHelp: Bool = false
    @State private var animateButton: Int = -1
    @State private var lock: Bool = false
    @State private var textColor: [Color] = [Color("Main"), Color("Main"), Color("Main"), Color("Main")]
    
    init(env: EnvironmentObject<GlobalEnvironment>, studyStyle: Binding<StudyStyle>, index: Int){
        _env = env
        _studyStyle = studyStyle
        let tempVocabulary = env.wrappedValue.courses[env.wrappedValue.currentCourse].vocabulary[index].vocabulary.shuffled()
        vocabulary = tempVocabulary
        vocable = tempVocabulary[0]
        buttonIndex = Int.random(in: 0...3)
        
        var tempOtherWords: [String] = [env.wrappedValue.settings.studyType == .VocableToTranslation ? tempVocabulary[0].translation : tempVocabulary[0].vocable]
        var randomWords: [String] = []
        for _ in 0...3{
            var pass = false
            while !pass {
                var tempWord: String
                if env.wrappedValue.settings.studyType == .VocableToTranslation {
                    tempWord = tempVocabulary[Int.random(in: 0...(tempVocabulary.count - 1))].translation
                } else {
                    tempWord = tempVocabulary[Int.random(in: 0...(tempVocabulary.count - 1))].vocable
                }
                
                if !tempOtherWords.contains(tempWord) {
                    randomWords.append(tempWord)
                    tempOtherWords.append(tempWord)
                    pass = true
                }
            }
        }
        otherWords = randomWords
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    Button{
                        withAnimation(.easeOut){
                            studyStyle = .None
                        }
                    }label: {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(Color("Main"))
                    }
                    .padding()
                    
                    ProgressBarView(width: proxy.frame(in: .global).width - 80, height: 20, percent: percent, color1: Color("Blue"), color2: Color("Blue"))
                        .animation(.linear, value: percent)
                }
                
                Spacer(minLength: 0)
                
                let cardWidth = proxy.frame(in: .global).width
                let cardHeight = proxy.frame(in: .global).height
                LearnCard(width: isMacOS() || isBigDevice() ? cardWidth - 55 : cardWidth - 25, height: isMacOS() || isBigDevice() ? cardHeight - 200 : cardHeight - 200 < cardWidth ? cardWidth + 180 : cardHeight - 200)
                
                Spacer()
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func LearnCard(width: CGFloat, height: CGFloat)->some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color("Blue"))
            
            VStack(spacing: 10){
                Text(env.settings.studyType == .VocableToTranslation ? vocable.vocable : vocable.translation)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Main"))
                    .padding(.bottom, 20)
                
                Text(showHelp ? vocable.extra == "" ? "-" : vocable.extra : "")
                    .font(.title2)
                    .fontWeight(isMacOS() ? .bold : .regular)
                    .foregroundColor(Color("Main"))
                    .padding(.bottom, 20)
                
                Divider()
                    .frame(width: width)
                
                VStack {
                    let mainWord = env.settings.studyType == .VocableToTranslation ? vocable.translation : vocable.vocable
                    
                    if isMacOS() || isBigDevice() {
                        HStack {
                            TranslationButton(text: buttonIndex == 0 ? mainWord : otherWords[0], index: 0, color: textColor[0])
                            TranslationButton(text: buttonIndex == 1 ? mainWord : otherWords[1], index: 1, color: textColor[1])
                        }
                        
                        HStack {
                            TranslationButton(text: buttonIndex == 2 ? mainWord : otherWords[2], index: 2, color: textColor[2])
                            TranslationButton(text: buttonIndex == 3 ? mainWord : otherWords[3], index: 3, color: textColor[3])
                        }
                    } else {
                        TranslationButton(text: buttonIndex == 0 ? mainWord : otherWords[0], index: 0, color: textColor[0])
                        TranslationButton(text: buttonIndex == 1 ? mainWord : otherWords[1], index: 1, color: textColor[1])
                        TranslationButton(text: buttonIndex == 2 ? mainWord : otherWords[2], index: 2, color: textColor[2])
                        TranslationButton(text: buttonIndex == 3 ? mainWord : otherWords[3], index: 3, color: textColor[3])
                    }
                }
                
                Button {
                    withAnimation(.easeInOut){
                        showHelp.toggle()
                    }
                }label: {
                    Image(systemName: "questionmark")
                        .font(.title3)
                        .foregroundColor(Color("Main1"))
                        .padding(isMacOS() ? 5 : 7)
                        .background(Color("Main"))
                        .clipShape(Circle())
                }
            }
        }
    }
    
    @ViewBuilder
    func TranslationButton(text: String, index: Int, color: Color)->some View {
        Button{
            withAnimation(.spring()){
                animateButton = index
                check(index: index)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.spring()){
                    animateButton = -1
                }
            }
        }label: {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: isMacOS() || isBigDevice() ? 250 : 280, height: isMacOS() || isBigDevice() ? 100 : 50, alignment: .top)
                    .foregroundColor(.gray.opacity(0.5))
                
                Text(text)
                    .font(.title3)
                    .fontWeight(isMacOS() ? .bold : .regular)
                    .foregroundColor(color)
            }
            .scaleEffect(animateButton == index ? 1.1 : 1)
        }
    }
    
    func check(index: Int){
        if lock {
            return
        }
        
        lock = true
        showHelp = true
        
        if (index == buttonIndex){
            if (progress == (vocabulary.count - 1)){
                withAnimation(.easeOut){
                    studyStyle = .None
                }
            } else {
                textColor[index] = Color("Green")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation(.spring()){
                        for i in 0...(textColor.count - 1) {
                            textColor[i] = Color("Main")
                        }
                        showHelp = false
                        progress += 1
                        vocable = vocabulary[progress]
                        generateRandomWords()
                        let per: CGFloat = CGFloat(progress) / CGFloat(vocabulary.count) * 100
                        percent = per
                        lock = false
                    }
                }
            }
        } else {
            textColor[index] = Color.red
            textColor[buttonIndex] = Color("Green")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                withAnimation(.spring()){
                    for i in 0...(textColor.count - 1) {
                        textColor[i] = Color("Main")
                    }
                    showHelp = false
                    progress += 1
                    vocabulary.append(vocable)
                    vocable = vocabulary[progress]
                    generateRandomWords()
                    let per: CGFloat = CGFloat(progress) / CGFloat(vocabulary.count) * 100
                    percent = per
                    lock = false
                }
            }
        }
    }
    
    func generateRandomWords(){
        buttonIndex = Int.random(in: 0...3)
        
        var tempOtherWords: [String] = [env.settings.studyType == .VocableToTranslation ? vocabulary[progress].translation : vocabulary[progress].vocable]
        var randomWords: [String] = []
        
        for _ in 0...3{
            var pass = false
            while !pass {
                var tempWord: String
                if env.settings.studyType == .VocableToTranslation {
                    tempWord = vocabulary[Int.random(in: 0...(vocabulary.count - 1))].translation
                } else {
                    tempWord = vocabulary[Int.random(in: 0...(vocabulary.count - 1))].vocable
                }
                
                if !tempOtherWords.contains(tempWord) {
                    randomWords.append(tempWord)
                    tempOtherWords.append(tempWord)
                    pass = true
                }
            }
        }
        
        otherWords = randomWords
    }
}
