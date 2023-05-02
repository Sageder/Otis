import SwiftUI

struct GrammarRuleView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @State private var showRule: Bool = false
    @State private var activeRule: GrammarRuleModel = GrammarRuleModel(title: "", description: "", example: "")
    
    var body: some View {
        VStack(spacing: 15){
            Text("Grammatik - Regeln")
                .font(isMacOS() ? . system(size: 33, weight: .bold) : .largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15){
                    let columns = Array(repeating: GridItem(.flexible(), spacing: isMacOS() || isBigDevice() ? 25 : 15), count: isMacOS() || isBigDevice() ? 3 : 1)
                    
                    LazyVGrid(columns: columns, spacing: 15){
                        ForEach(env.GetCourse().grammarRules){rule in
                            GrammarRuleCard(rule: rule)
                        }
                    }
                }
            }
            
            if showRule {
                GrammarRuleDescription()
            }
        }
        .padding(.top, isMacOS() ? 45 : 30)
    }
    
    @ViewBuilder
    func GrammarRuleCard(rule: GrammarRuleModel)->some View {
        Button {
            activeRule = rule
            showRule.toggle()
        } label: {
            HStack {
                Text(rule.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if rule.bookmarked {
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
    func GrammarRuleDescription()->some View {
        VStack {
            Divider()
            
            HStack {
                Button{
                    withAnimation(.default){
                        showRule = false
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
                
                Text(activeRule.title)
                    .font(.title3.bold())
                    .foregroundColor(Color("Main"))
                    .padding()
                
                Spacer()
                
                Button{
                    withAnimation(.default){
                        activeRule.bookmarked.toggle()
                        
                        for i in env.GetCourse().grammarRules.indices {
                            if env.GetCourse().grammarRules[i].id == activeRule.id {
                                env.courses[env.currentCourse].grammarRules[i].bookmarked = activeRule.bookmarked
                                
                                env.saveBookmark(search: SearchItem(type: .GrammarRules, index: i, index2: -1, index3: -1), activeRule.bookmarked)
                            }
                        }
                    }
                }label: {
                    Image(systemName: activeRule.bookmarked ? "bookmark.fill" : "bookmark")
                        .font(.title3)
#if os(iOS)
                        .foregroundColor(Color("Main"))
#endif
                }
                .padding()
            }
            
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .leading) {
                    Text(activeRule.description)
                        .font(.title3)
                        .foregroundColor(Color("Main"))
                        .padding(.bottom, 20)
                    
                    Text(activeRule.example)
                        .font(.title3)
                        .foregroundColor(Color("Main").opacity(0.6))
                }
            })
        }
    }
}

struct GrammarView_Previews: PreviewProvider {
    static var previews: some View {
        GrammarRuleView()
            .environmentObject(GlobalEnvironment())
    }
}
