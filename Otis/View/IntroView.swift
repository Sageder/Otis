import SwiftUI

struct IntroView: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        VStack {
            Text("Erscheinungsbild")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            AppearanceView(env: _env)
                .padding()
                .background(Color.gray.opacity(0.5).cornerRadius(12))
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut){
                    env.data.showIntro = false
                }
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: isMacOS() || isBigDevice() ? 400 : 300, height: isMacOS() || isBigDevice() ? 40 : 50)
                        .foregroundColor(Color("Blue"))
                        .cornerRadius(12)
                    
                    Text("Weiter")
                        .font(.title2)
                        .fontWeight(.semibold)
                    #if os(iOS)
                        .foregroundColor(Color("Main"))
                    #endif
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG").ignoresSafeArea())
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(env: EnvironmentObject<GlobalEnvironment>())
    }
}
