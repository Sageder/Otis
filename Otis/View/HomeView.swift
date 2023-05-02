import SwiftUI

enum Tab: String, CaseIterable {
    case None = ""
    case Study = "studentdesk"
    case GrammarRule = "book.fill"
    case GrammarForm = "tablecells"
    case Search = "magnifyingglass"
    case Settings = "gear"
}

struct HomeView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @State private var currentTab: Tab = .Study
    @State private var showMenu: Bool = false
    @State private var showToSearch: Bool = false
    @State private var showCourseMenu: Bool = false
    @State private var animateButton: Bool = false
    @State private var searchQuery: String = ""
    
    var body: some View {
        if env.data.showIntro {
            IntroView(env: _env)
        } else {
            HStack(spacing: 0) {
                if isMacOS() || isBigDevice() {
                    Group {
                        SideBar()
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.15))
                            .frame(width: 1)
                    }
                }
                
                ZStack {
                    MainContent()
                    
                    if searchQuery != "" && currentTab != .Search && showToSearch {
                        VStack(alignment: .center, spacing: 15){
                            PopupView(show: $showToSearch, data: [
                                PopupData(title: "'\(searchQuery)' suchen", image: "magnifyingglass", action: {
                                    withAnimation(.easeOut){
                                        showToSearch = false
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                                        currentTab = .Search
                                    }
                                })
                            ])
                        }
                    }
                    
                    if showCourseMenu {
                        VStack(alignment: .center, spacing: 15){
                            PopupView(show: $showCourseMenu, data: CourseData())
                        }
                    }
                }
            }
#if os(iOS)
            .overlay(
                SideBar()
                    .opacity(isBigDevice() ? 0 : 1)
            )
#endif
            .onAppear(perform: {
                if isMacOS() || isBigDevice() {
                    showMenu = true
                }
            })
            .onChange(of: searchQuery, perform: { newValue in
                if searchQuery != "" && currentTab != .Search {
                    showToSearch = true
                }
            })
        }
    }
    
    @ViewBuilder
    func MainContent()->some View {
        VStack(spacing: 6) {
            HStack(spacing: 8){
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                TextField("Suchen", text: $searchQuery)
                    .disableAutocorrection(!env.settings.autoCorrection)
                #if os(iOS)
                    .onSubmit {
                        if searchQuery == "" {
                            return
                        }
                        
                        withAnimation(.easeOut){
                            showToSearch = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            currentTab = .Search
                        }
                    }
                #endif
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, isMacOS() ? 0 : 10)
            .overlay(
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 1)
                    .padding(.horizontal, -25)
                    .offset(y: 6)
                    .opacity(isMacOS() || isBigDevice() ? 0 : 1),
                
                alignment: .bottom
            )
            
            if currentTab == .Study {
                StudyView(env: _env)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BG").ignoresSafeArea())
            }
            
            else if currentTab == .GrammarRule {
                GrammarRuleView(env: _env)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BG").ignoresSafeArea())
            }
            
            else if currentTab == .GrammarForm {
                GrammarFormView(env: _env)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BG").ignoresSafeArea())
            }
            
            else if currentTab == .Search {
                SearchView(env: _env, searchQuery: $searchQuery)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BG").ignoresSafeArea())
            }
            
            else if currentTab == .Settings {
                SettingsView(env: _env)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BG").ignoresSafeArea())
            }
            
            else if currentTab == .None {
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, isMacOS() ? 40 : 15)
        .padding(.horizontal, 25)
    }
    
    @ViewBuilder
    func SideBar()->some View{
        VStack {
            if isMacOS() || isBigDevice() {
                
                CourseButton()
                    .zIndex(1)
                
                AddButton()
                    .zIndex(1)
            }
            
            HStack {
                if isIOS() && !isBigDevice(){
                    Spacer()
                }
                
                VStack(spacing: 15){
                    let tabs: [Tab] = VisibleTabs()
                    
                    ForEach(tabs, id: \.self){tab in
                        Button {
                            withAnimation(.easeInOut){
                                currentTab = tab
                                if isIOS() && !isBigDevice() {
                                    showMenu = false
                                }
                            }
                        } label: {
                            Image(systemName: tab.rawValue)
                                .font(.title2)
                                .foregroundColor(Color("Main1"))
                                .frame(width: isMacOS() ? 20 : 25, height: isMacOS() ? 20 : 25)
                                .padding(isMacOS() ? 8 : 10)
                                .background(tab == currentTab ? Color("Main") : Color("Main").opacity(0.6))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.top, 20)
                .frame(height: showMenu ? nil : 0)
                .opacity(showMenu ? 1 : 0)
                .zIndex(0)
            }
            
            if isIOS() && !isBigDevice() {
                HStack {
                    Spacer()
                    
                    AddButton()
                        .zIndex(1)
                }
            }
        }
        #if os(macOS)
        .frame(maxWidth: 80, maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
        .padding(.top, 35)
        #else
        .frame(maxWidth: isBigDevice() ? 80 : .infinity, maxHeight: .infinity, alignment: isBigDevice() ? .top : .bottomTrailing)
        .padding()
        .background(BlurView(style: .systemUltraThinMaterialDark)
                        .opacity(showMenu && !isBigDevice() ? 1 : 0)
                        .ignoresSafeArea()
        )
        #endif
    }
    
    @ViewBuilder
    func CourseButton()->some View {
        Button{
            withAnimation(.easeInOut){
                showCourseMenu = false
                if isIOS() && !isBigDevice() {
                    showMenu = false
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                withAnimation(.easeIn){
                    showCourseMenu = true
                }
            }
        } label: {
            HStack {
                let name = env.GetCourse().name
                Text(name)
                    .font(isMacOS() ? .title3 : .title2)
                    .fontWeight(.semibold)
                #if os(iOS)
                    .foregroundColor(Color("Main"))
                #endif
            }
        }
    }
    
    @ViewBuilder
    func AddButton()->some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                showMenu.toggle()
                animateButton.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.spring()){
                    animateButton.toggle()
                }
            }
        } label: {
            Image(systemName: showMenu ? "xmark" : "text.justify")
                .font(.title2)
                .foregroundColor(Color("Main1"))
                .scaleEffect(animateButton ? 1.1 : 1)
                .padding(isMacOS() ? 12 : 15)
                .background(Color("Main"))
                .clipShape(Circle())
        }
        .scaleEffect(animateButton ? 1.1 : 1)
        .padding(.top, 30)
    }
    
    func CourseData()->[PopupData] {
        var data: [PopupData] = []
        
        for i in 0...(env.courses.count - 1) {
            let item = PopupData(title: env.courses[i].name, image: "globe", action: {
                currentTab = .None
                showCourseMenu = false
                
                //That's a little bit of a hack, because it forces to reload the view
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    env.currentCourse = i
                    currentTab = .Study
                }
            })
            
            data.append(item)
        }
        
        return data
    }
    
    func VisibleTabs()->[Tab] {
        var temp: [Tab] = []
        
        temp.append(.Study)
        
        if !env.courses[env.currentCourse].grammarRules.isEmpty {
            temp.append(.GrammarRule)
        }
        
        if !env.courses[env.currentCourse].grammarForms.isEmpty {
            temp.append(.GrammarForm)
        }
        
        temp.append(.Search)
        temp.append(.Settings)
        
        return temp
    }
}
