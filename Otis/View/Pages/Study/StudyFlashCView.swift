import SwiftUI

struct StudyFlashCardView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @Binding var studyStyle: StudyStyle
    @State private var vocabulary: [VocabularyDefinition]
    @State private var vocable: VocabularyDefinition
    @State private var progress: Int = 0
    @State private var percent: CGFloat = 0
    @State private var text: FlashCardText
    
    init(env: EnvironmentObject<GlobalEnvironment>, studyStyle: Binding<StudyStyle>, index: Int){
        _env = env
        _studyStyle = studyStyle
        let tempVocabulary = env.wrappedValue.courses[env.wrappedValue.currentCourse].vocabulary[index].vocabulary.shuffled()
        vocabulary = tempVocabulary
        vocable = tempVocabulary[0]
        text = FlashCardText(mainText: env.wrappedValue.settings.studyType == .VocableToTranslation ? tempVocabulary[0].vocable : tempVocabulary[0].translation, otherText: "")
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
                
                Spacer()
                
                let cardWidth = proxy.frame(in: .global).width
                let cardHeight = proxy.frame(in: .global).height
                Card(width: isMacOS() || isBigDevice() ? cardWidth - 55 : cardWidth - 55, height: isMacOS() || isBigDevice() ? cardHeight - 200 : cardWidth )
                    .padding()
                
                Spacer()
                
                if isMacOS() || isBigDevice() {
                    HStack {
                        RightButton(width: cardWidth)
                            .padding()
                        
                        WrongButton(width: cardWidth)
                            .padding()
                    }
                    .padding(.bottom)
                } else {
                    RightButton(width: cardWidth)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    WrongButton(width: cardWidth)
                        .padding()
                }
            }
            .onChange(of: vocable){newValue in
                withAnimation(.easeInOut){
                    ValidateTextChanged()
                }
            }
        }
    }
    
    func ValidateTextChanged(){
        text.mainText = env.settings.studyType == .VocableToTranslation ? vocable.vocable : vocable.translation
        text.otherText = ""
    }
    
    func ValidateText(){
        if env.settings.studyType == .VocableToTranslation {
            if text.mainText != vocable.vocable {
                text.mainText = vocable.vocable
                text.otherText = ""
            } else {
                text.mainText = vocable.translation
                text.otherText = vocable.extra
            }
        } else {
            if text.mainText != vocable.translation {
                text.mainText = vocable.translation
                text.otherText = ""
            } else {
                text.mainText = vocable.vocable
                text.otherText = vocable.extra
            }
        }
    }
    
    @ViewBuilder
    func Card(width: CGFloat, height: CGFloat)->some View {
        Button{
            withAnimation(.easeInOut){
                ValidateText()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width: width, height: height, alignment: .center)
                    .foregroundColor(Color("Blue"))
                
                VStack {
                    Text(text.mainText)
                        .font(.title.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Main"))
                    
                    Text(text.otherText)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Main"))
                        .padding(.top, isMacOS() || isBigDevice() ? 40 : 20)
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    func RightButton(width: CGFloat)->some View {
        Button{
            if (progress == vocabulary.count - 1) {
                withAnimation(.easeOut){
                    studyStyle = .None
                }
            } else {
                progress += 1
                vocable = vocabulary[progress]
                let per: CGFloat = CGFloat(progress) / CGFloat(vocabulary.count) * 100
                percent = per
            }
        }label: {
            ZStack {
                RoundedRectangle(cornerRadius: 45, style: .continuous)
                    .frame(width: isMacOS() || isBigDevice() ? 200 :  width - 40, height: isMacOS() || isBigDevice() ? 30 : 45, alignment: .bottom)
                    .foregroundColor(Color("Blue"))
                
                Text("Richtig")
                    .foregroundColor(Color("Main"))
                    .font(.title3)
            }
        }
    }
    
    @ViewBuilder
    func WrongButton(width: CGFloat)->some View{
        Button{
            progress += 1
            vocabulary.append(vocable)
            vocable = vocabulary[progress]
            let per: CGFloat = CGFloat(progress) / CGFloat(vocabulary.count) * 100
            percent = per
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 45, style: .continuous)
                    .frame(width: isMacOS() || isBigDevice() ? 200 :  width - 100, height: isMacOS() || isBigDevice() ? 30 : 40, alignment: .bottom)
                    .foregroundColor(Color("Blue"))
                
                Text("Falsch")
                    .foregroundColor(Color("Main"))
                    .font(.title3)
            }
        }
    }
}
