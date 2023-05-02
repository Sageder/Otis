import SwiftUI

struct SplashScreen: View {
    @State var startAnimation: Bool = false
    @State var showSplashScreen: Bool = true
    @Binding var endAnimation: Bool
    
    var body: some View {
        if showSplashScreen {
            ZStack {
                Color("BG")
                
                Group {
                    OtisShape()
                        .trim(from: 0, to: startAnimation ? 1 : 0)
                        .stroke(Color("Main"), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                        .padding(.bottom, 65)
                }
                .frame(width: isMacOS() ? 330 : 220, height: isMacOS() ? 190 : 130)
                .scaleEffect(endAnimation ? 0.15 : 1.0)
                
                VStack {
                    Text("Clemens Sageder")
                        .fontWeight(.semibold)
                    #if os(macOS)
                        .padding(.bottom, 10)
                    #endif
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .foregroundColor(Color("Main").opacity(0.8))
            #if os(iOS)
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
            #endif
                .opacity(startAnimation ? 1 : 0)
                .opacity(endAnimation ? 0 : 1)
            }
            .offset(y: endAnimation ? -getRect().height : 0)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(isMacOS() ? 0.5 : 0.25)){
                    startAnimation.toggle()
                }
                
                withAnimation(.spring().delay(isMacOS() ? 1.75 : 1.5)){
                    endAnimation.toggle()
                }

                withAnimation(.easeOut.delay(5)){
                    showSplashScreen.toggle()
                }
            }
        }
    }
}

struct SplashScreem_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(env: EnvironmentObject<GlobalEnvironment>())
    }
}
