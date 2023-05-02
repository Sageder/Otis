import SwiftUI

struct ContentView: View {
    @State var splashScreen: Bool = false
    @EnvironmentObject var env: GlobalEnvironment
    
    @AppStorage("Course") var course: Int = 0
    @AppStorage("Appearance") var appearance: Int = 0
    @AppStorage("StudyType") var studyType: Int = 0
    @AppStorage("AutoCorrection") var autoCorrection = false
    @AppStorage("ShowIntro") var showIntro: Bool = true
    @AppStorage("HighScore") var gameHighScore = 0
    @AppStorage("Bookmarks") var bookmarks: String = ""
    
    var body: some View {
        ZStack {
            HomeView()
                .buttonStyle(BorderlessButtonStyle())
                .textFieldStyle(PlainTextFieldStyle())
                .offset(y: splashScreen ? 0 : getRect().height)
            
            SplashScreen(endAnimation: $splashScreen)
        }
        #if os(macOS)
        .ignoresSafeArea()
        .frame(minWidth: 850, minHeight: 650, alignment: .leading)
        #endif
        .background(Color("BG").ignoresSafeArea())
        .preferredColorScheme(SetColorScheme())
        .onAppear(){
            env.currentCourse = course
            
            env.settings = SettingsModel(appearance: Appearance(rawValue: appearance) ?? .Light, studyType: StudyType(rawValue: studyType) ?? .VocableToTranslation, autoCorrection: autoCorrection)
            
            env.data.showIntro = showIntro
            env.data.gameHighScore = gameHighScore
            env.data.bookmarks = bookmarks
            
            if bookmarks != "" {
                env.deserializeBookmarks()
            }
        }
        .onChange(of: env.currentCourse, perform: {newValue in
            course = env.currentCourse
        })
        .onChange(of: env.settings.appearance, perform: {newValue in
            appearance = env.settings.appearance.rawValue
        })
        .onChange(of: env.settings.studyType, perform: { newValue in
            studyType = env.settings.studyType.rawValue
        })
        .onChange(of: env.settings.autoCorrection, perform: { newValue in
            autoCorrection = env.settings.autoCorrection
        })
        .onChange(of: env.data.showIntro, perform: { newValue in
            showIntro = env.data.showIntro
        })
        .onChange(of: env.data.gameHighScore, perform: {newValue in
            gameHighScore = env.data.gameHighScore
        })
        .onChange(of: env.data.bookmarks, perform: {newValue in
            bookmarks = env.data.bookmarks
        })
    }
    
    func SetColorScheme()->ColorScheme {
        switch (env.settings.appearance){
            case .Light:        return ColorScheme.light
            case .Dark:         return ColorScheme.dark
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GlobalEnvironment())
    }
}
