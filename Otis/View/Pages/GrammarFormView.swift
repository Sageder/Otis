import SwiftUI

struct GrammarFormView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @State private var study: Bool =  false
    @State private var showForm: Bool = false
    @State private var activeForm: GrammarFormModel = GrammarFormModel(title: "", description: "", types: [])
    
    init(env: EnvironmentObject<GlobalEnvironment>){
        _env = env
    }
    
    var body: some View {
        if study {
            GrammarFormStudy(study: $study, activeForm: activeForm)
        } else {
            GrammarFormBrowser()
        }
    }
    
    @ViewBuilder
    func GrammarFormBrowser()-> some View {
        VStack(spacing: 15){
            Text("Grammatik - Formen")
                .font(isMacOS() ? . system(size: 33, weight: .bold) : .largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15){
                    let columns = Array(repeating: GridItem(.flexible(), spacing: isMacOS() || isBigDevice() ? 25 : 15), count: isMacOS() || isBigDevice() ? 3 : 1)
                    
                    LazyVGrid(columns: columns, spacing: 15){
                        ForEach(env.GetCourse().grammarForms){form in
                            FormCard(form: form)
                        }
                    }
                }
            }
            
            if showForm {
                FormDescription()
            }
        }
        .padding(.top, isMacOS() ? 45 : 30)
    }
    
    @ViewBuilder
    func FormCard(form: GrammarFormModel)->some View {
        Button {
            activeForm = form
            showForm.toggle()
        } label: {
            HStack {
                Text(form.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if form.bookmarked {
                    Image(systemName: "bookmark.fill")
                        .font(.title3)
                }
            }
            .padding()
            .background(Color("Blue"))
            .cornerRadius(12)
            #if os(iOS)
                .foregroundColor(Color("Main"))
            #endif
        }
    }
    
    @ViewBuilder
    func FormDescription()->some View {
        VStack {
            Divider()
            
            HStack {
                Button{
                    withAnimation(.default){
                        showForm = false
                    }
                }label: {
                    Image(systemName: "xmark")
                        .font(.title3)
#if os(iOS)
                        .foregroundColor(Color("Main"))
#endif
                }
                .padding()
                
                Spacer()
                
                Text(activeForm.title)
                    .font(.title3.bold())
                    .foregroundColor(Color("Main"))
                    .padding()
                
                Spacer()
                
                Button{
                    withAnimation(.default){
                        activeForm.bookmarked.toggle()
                        
                        for i in env.GetCourse().grammarForms.indices {
                            if env.GetCourse().grammarForms[i].id == activeForm.id {
                                env.courses[env.currentCourse].grammarForms[i].bookmarked = activeForm.bookmarked
                                
                                env.saveBookmark(search: SearchItem(type: .GrammarForms, index: i, index2: -1, index3: -1), activeForm.bookmarked)
                            }
                        }
                    }
                }label: {
                    Image(systemName: activeForm.bookmarked ? "bookmark.fill" : "bookmark")
                        .font(.title3)
#if os(iOS)
                        .foregroundColor(Color("Main"))
#endif
                }
                .padding()
            }
            
            ScrollView(.vertical, showsIndicators: false){
                HStack {
                    Text(activeForm.description)
                        .font(.title3)
                        .foregroundColor(Color("Main"))
                    
                    Spacer()
                    
                    Button {
                        if activeForm.types.count > 0 {
                            withAnimation(.linear){
                                study = true
                            }
                        }
                    } label: {
                        Image(systemName: "studentdesk")
    #if os(iOS)
                            .foregroundColor(Color("Main"))
    #endif
                    }
                    .padding()
                }
                
                ForEach(activeForm.types){ type in
                    Divider()
                    
                    Text(type.type)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Main"))
                    
                    Text(type.example)
                        .font(.title3)
                        .foregroundColor(Color("Main").opacity(0.6))
                        .padding(.bottom, 20)
                    
                    Text(type.wordsToString())
                        .font(.title3)
                        .foregroundColor(Color("Main"))
                }
            }
        }
    }
}

struct GrammarFormStudy: View {
    @Binding var study: Bool
    @State var activeForm: GrammarFormModel
    @State private var copyOfFormType: GrammarFormTypeDefinition
    @State private var lock: Bool = false
    @State private var typeIndex: Int = 0
    @State private var percent: CGFloat = 0
    @State private var answerColor: Color = Color("Main")
    @State private var showAnswer: Bool = false
    @State private var showHelp: Bool = false
    @State private var tags: Tags
    
    init(study: Binding<Bool>, activeForm: GrammarFormModel){
        _study = study
        
        var tempForm = activeForm
        tempForm.types.shuffle()
        
        self.copyOfFormType = tempForm.types[0]
        
        tempForm.types[0].words.shuffle()
        
        self.activeForm = tempForm
        self.tags = Tags(bottomStrArr: tempForm.types[0].words, topStrArr: [], size: 12)
    }
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    Button{
                        withAnimation(.easeOut){
                            study.toggle()
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
                
                Text(activeForm.types[typeIndex].type)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Main"))
                
                if showHelp {
                    Text(activeForm.types[typeIndex].example)
                        .font(.title3)
                        .foregroundColor(Color("Main").opacity(0.7))
                }
                
                TagView(tags: $tags, foregroundColor: answerColor)
                
                Button {
                    if lock || !canCheck() {
                        return
                    }
                    
                    lock = true
                    
                    if tags.getAllString(state: .Top) == copyOfFormType.words {
                        answerColor = Color.green
                        showAnswer = true
                        showHelp = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                            withAnimation(.spring()){
                                answerColor = Color("Main")
                                showAnswer = false
                                showHelp = false
                                
                                if typeIndex < activeForm.types.count - 1 {
                                    typeIndex += 1
                                    let per: CGFloat = CGFloat(typeIndex) / CGFloat(activeForm.types.count) * 100
                                    percent = per
                                    lock = false
                                    
                                    copyOfFormType = activeForm.types[typeIndex]
                                    activeForm.types[typeIndex].words.shuffle()
                                    
                                    tags.topTags.removeAll()
                                    tags.bottomTags.removeAll()
                                    tags.createTagsFormStringArray(strArr: activeForm.types[typeIndex].words, size: 12, state: .Bottom)
                                } else {
                                    study = false
                                }
                            }
                        }
                    } else {
                        answerColor = Color.red
                        showAnswer = true
                        showHelp = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                            withAnimation(.spring()){
                                answerColor = Color("Main")
                                showAnswer = false
                                showHelp = false
                                
                                activeForm.types.append(activeForm.types[typeIndex])
                                
                                typeIndex += 1
                                let per: CGFloat = CGFloat(typeIndex) / CGFloat(activeForm.types.count) * 100
                                percent = per
                                lock = false
                                
                                copyOfFormType = activeForm.types[typeIndex]
                                activeForm.types[typeIndex].words.shuffle()
                                
                                tags.topTags.removeAll()
                                tags.bottomTags.removeAll()
                                tags.createTagsFormStringArray(strArr: activeForm.types[typeIndex].words, size: 12, state: .Bottom)
                            }
                        }
                    }
                } label: {
                    let width = proxy.frame(in: .global).width
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("Blue").opacity(canCheck() ? 1 : 0.5))
                            .cornerRadius(12)
                            .frame(width: isMacOS() || isBigDevice() ? 150 : width - 130, height: isMacOS() || isBigDevice() ? 30 : 40, alignment: .center)
                            .padding()
                        
                        Text("Antwort")
                            .font(.title2)
                            .foregroundColor(answerColor.opacity(canCheck() ? 1 : 0.8))
                    }
                }
                
                Button{
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
                .padding(.bottom)
            }
        }
    }
    
    func canCheck()->Bool {
        return tags.bottomTags.isEmpty && !tags.topTags.isEmpty
    }
}

struct GrammarFormView_Previews: PreviewProvider {
    static var previews: some View {
        GrammarFormView(env: EnvironmentObject<GlobalEnvironment>())
            .environmentObject(GlobalEnvironment())
    }
}
