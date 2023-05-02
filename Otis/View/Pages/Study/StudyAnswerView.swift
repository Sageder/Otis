import SwiftUI

struct StudyAnswerView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @Binding var studyStyle: StudyStyle
    @State private var vocabulary: [VocabularyDefinition]
    @State private var vocable: VocabularyDefinition
    @State private var progress: Int = 0
    @State private var percent: CGFloat = 0
    @State private var answerQuery: String = ""
    @State private var showHelp: Bool = false
    @State private var animateButton: Bool = false
    @State private var lock: Bool = false
    @State private var answerColor: Color = Color("Main")
    @State private var showAnswer: Bool = false
    
    init(env: EnvironmentObject<GlobalEnvironment>, studyStyle: Binding<StudyStyle>, index: Int){
        _env = env
        _studyStyle = studyStyle
        let tempVocabulary = env.wrappedValue.courses[env.wrappedValue.currentCourse].vocabulary[index].vocabulary.shuffled()
        vocabulary = tempVocabulary
        vocable = tempVocabulary[0]
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
                AnswerCard(width: isMacOS() || isBigDevice() ? cardWidth - 55 : cardWidth - 30, height: isMacOS() || isBigDevice() ? cardHeight - 200 : cardHeight - 200 < cardWidth ? cardWidth + 180 : cardHeight - 200)
                
                Spacer()
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func AnswerCard(width: CGFloat, height: CGFloat)->some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color("Blue"))
            
            VStack {
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
                
                Text(showAnswer ? env.settings.studyType == .VocableToTranslation ? vocable.translation : vocable.vocable : "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Green"))
                    .padding(.bottom, 20)
                
                Divider()
                    .frame(width: width)
                
                TextField("", text: $answerQuery)
                    .disableAutocorrection(env.settings.autoCorrection)
                    .font(.title2.bold())
                    .foregroundColor(answerColor)
                    .multilineTextAlignment(.leading)
                    .frame(width: isMacOS() ? width / 2 : width - 15, alignment: .center)
                #if os(iOS)
                    .onSubmit {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            animateButton.toggle()
                            check()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            withAnimation(.spring()){
                                animateButton.toggle()
                            }
                        }
                    }
                #endif
                
                Rectangle()
                    .frame(width: isMacOS() ? width / 2 : width - 15, height: 2, alignment: .top)
                
                Button{
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                        animateButton.toggle()
                        check()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        withAnimation(.spring()){
                            animateButton.toggle()
                        }
                    }
                }label: {
                    ZStack {
                        Rectangle()
                            .frame(width: isMacOS() || isBigDevice() ? 150 :  width - 100, height: isMacOS() || isBigDevice() ? 30 : 40, alignment: .bottom)
                            .foregroundColor(.gray.opacity(0.5))
                            .cornerRadius(12)
                        
                        Text("Antwort")
                            .foregroundColor(answerColor)
                            .font(.title3)
                    }
                    .scaleEffect(animateButton ? 1.1 : 1)
                }
                .padding(.top, 40)
                .padding(.bottom, 20)
                
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
                
            }
            .padding()
        }
    }
    
    func check(){
        if lock || answerQuery == "" {
            return
        }
        
        lock = true
        showHelp = true
        showAnswer = true
        
        if (queryCheck()){
            if (progress == vocabulary.count - 1) {
                withAnimation(.easeOut){
                    studyStyle = .None
                }
            } else {
                answerColor = Color("Green")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation(.spring()){
                        answerColor = Color("Main")
                        showHelp = false
                        showAnswer = false
                        answerQuery = ""
                        progress += 1
                        vocable = vocabulary[progress]
                        let per: CGFloat = CGFloat(progress) / CGFloat(vocabulary.count) * 100
                        percent = per
                        lock = false
                    }
                }
            }
        } else {
            answerColor = Color.red
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                withAnimation(.spring()){
                    answerColor = Color("Main")
                    showHelp = false
                    showAnswer = false
                    answerQuery = ""
                    progress += 1
                    vocabulary.append(vocable)
                    vocable = vocabulary[progress]
                    let per: CGFloat = CGFloat(progress) / CGFloat(vocabulary.count) * 100
                    percent = per
                    lock = false
                }
            }
        }
    }
    
    func queryCheck()->Bool {
        let otherString = env.settings.studyType == .VocableToTranslation ? vocable.translation : vocable.vocable
        
        if otherString.count == 0 {
            return false
        }
        
        //TODO: impliment properly
        return otherString == answerQuery
//
//        assert(false)
//        return false
    }
}
