import SwiftUI

enum SearchType {
    case Vocabulary
    case GrammarRules
    case GrammarForms
}

struct SearchItem: Identifiable {
    var id = UUID().uuidString
    
    var type: SearchType
    var index: Int
    var index2: Int
    var index3: Int
}

struct SearchRules {
    /* Learnset */
    var learnSet: Bool = true
    var bookmarked: Bool = false
    
    /* Vocabulary */
    var vocabularyVocab: Bool = true
    var vocabularyExtra: Bool = false
    var vocabularyTranslation: Bool = true
    
    /* Rules */
    var ruleTitle: Bool = true
    var ruleText: Bool = false
    var ruleExample: Bool = false
    
    /* Forms */
    var formTitle: Bool = true
    var formDescription: Bool = false
    var formTypes: Bool = false
}

struct SearchView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @Binding var searchQuery: String
    @State private var showSearchRules: Bool = false
    @State private var searchRule: SearchRules = SearchRules()
    @State private var showCurrentSearchItem: Bool = false
    @State private var currentSearchItem: SearchItem = SearchItem(type: .Vocabulary, index: -1, index2: -1, index3: -1)
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    Text("Suchen")
                        .font(isMacOS() ? . system(size: 33, weight: .bold) : .largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    
                    Spacer()
                    
                    
                    Button {
                        showCurrentSearchItem = false
                        showSearchRules.toggle()
                    } label: {
                        Text(searchQuery == "" ? "Wörterbuch" : "Suchen")
                            .font(.caption)
                        #if os(iOS)
                            .foregroundColor(Color("Main"))
                        #endif
                        
                        Image(systemName: showSearchRules ? "xmark" : "slider.horizontal.3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.caption)
                            .frame(width: showSearchRules ? 14 : 18, height: 18, alignment: .trailing)
                        #if os(iOS)
                            .foregroundColor(Color("Main"))
                        #endif
                    }
                }
                
                if showSearchRules {
                    SearchSettings()
                }
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 15){
                        let columns = Array(repeating: GridItem(.flexible(), spacing: isMacOS() || isBigDevice() ? 25 : 15), count: isMacOS() || isBigDevice() ? 3 : 1)
                        
                        LazyVGrid(columns: columns, spacing: 15){
                            let items = CreateSearchItems()
                            
                            ForEach(items){item in
                                CardSearchItem(item: item)
                                    .frame(height: 100)
                            }
                        }
                    }
                }
                
                if showCurrentSearchItem {
                    SearchItemView()
                }
            }
            .padding(.top, isMacOS() ? 45 : 30)
        }
    }
    
    @ViewBuilder
    func SearchSettings()->some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    let width: CGFloat = 105
                    let height: CGFloat = 105
                    
                    HStack {
                        SelectableRectView(isOn: $searchRule.learnSet, title: "Lernset", secondTitle: "", width: width, height: height)
                        SelectableRectView(isOn: $searchRule.bookmarked, title: "Lesezeichen", secondTitle: "", width: width, height: height)
                    }
                    
                    HStack {
                        SelectableRectView(isOn: $searchRule.vocabularyVocab, title: "Vokabel", secondTitle: "Vokabel", width: width, height: height)
                        SelectableRectView(isOn: $searchRule.vocabularyExtra, title: "Extra", secondTitle: "Vokabel", width: width, height: height)
                        SelectableRectView(isOn: $searchRule.vocabularyTranslation, title: "Übersetzung", secondTitle: "Vokabel", width: width, height: height)
                    }
                    
                    HStack {
                        SelectableRectView(isOn: $searchRule.ruleTitle, title: "Titel", secondTitle: "Regel", width: width, height: height)
                        SelectableRectView(isOn: $searchRule.ruleText, title: "Text", secondTitle: "Regel", width: width, height: height)
                        SelectableRectView(isOn: $searchRule.ruleExample, title: "Beispiel", secondTitle: "Regel", width: width, height: height)
                    }
                    
                    HStack {
                        SelectableRectView(isOn: $searchRule.formTitle, title: "Titel", secondTitle: "Form", width: width, height: height)
                        SelectableRectView(isOn: $searchRule.formDescription, title: "Beschreibung", secondTitle: "Form", width: width, height: height)
                        SelectableRectView(isOn: $searchRule.formTypes, title: "Typen", secondTitle: "Form", width: width, height: height)
                    }
                }
            }
            
            Divider()
        }
    }
    
    @ViewBuilder
    func SearchItemView()->some View {
        let title = currentSearchItem.type == .Vocabulary ? env.GetCourse().vocabulary[currentSearchItem.index].vocabulary[currentSearchItem.index2].vocable : currentSearchItem.type == .GrammarForms ? env.GetCourse().grammarForms[currentSearchItem.index].title : env.GetCourse().grammarRules[currentSearchItem.index].title
        let isBookmarked = currentSearchItem.type == .Vocabulary ? env.GetCourse().vocabulary[currentSearchItem.index].vocabulary[currentSearchItem.index2].bookmarked : currentSearchItem.type == .GrammarForms ? env.GetCourse().grammarForms[currentSearchItem.index].bookmarked : env.GetCourse().grammarRules[currentSearchItem.index].bookmarked
        
        VStack {
            Divider()
            
            HStack {
                Button{
                    showCurrentSearchItem = false
                }label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(Color("Main"))
                }
                .padding()
                
                Spacer()
                
                Text(title)
                    .font(.title3.bold())
                    .foregroundColor(Color("Main"))
                    .padding()
                
                Spacer()
                
                Button {
                    withAnimation(.default){
                        switch(currentSearchItem.type){
                        case .Vocabulary:
                            env.courses[env.currentCourse].vocabulary[currentSearchItem.index].vocabulary[currentSearchItem.index2].bookmarked = !isBookmarked
                            break
                        case .GrammarForms:
                            env.courses[env.currentCourse].grammarForms[currentSearchItem.index].bookmarked = !isBookmarked
                            break
                        case .GrammarRules:
                            env.courses[env.currentCourse].grammarRules[currentSearchItem.index].bookmarked = !isBookmarked
                            break
                        }
                        
                        env.saveBookmark(search: currentSearchItem, !isBookmarked)
                    }
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.title3)
                        .foregroundColor(Color("Main"))
                }
                .padding()
            }
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: currentSearchItem.type == SearchType.GrammarRules ? .leading : .center) {
                    if currentSearchItem.type == .Vocabulary {
                        let vobularyName: String = env.GetCourse().vocabulary[currentSearchItem.index].title
                        let vocab: VocabularyDefinition = env.GetCourse().vocabulary[currentSearchItem.index].vocabulary[currentSearchItem.index2]
                        
                        Text(vocab.translation)
                            .font(.title3)
                            .foregroundColor(Color("Main"))
                        
                        Text(vocab.extra == "" ? "-"  : vocab.extra)
                            .font(.title3)
                            .foregroundColor(Color("Main"))
                            .padding(.bottom, isMacOS() ? 25 : 20)
                        
                        Text(vobularyName)
                            .font(.title3)
                            .foregroundColor(Color("Main"))
                    }
                    
                    if currentSearchItem.type == .GrammarRules {
                        let rule: GrammarRuleModel = env.GetCourse().grammarRules[currentSearchItem.index]
                        
                        Text(rule.description)
                            .font(.title3)
                            .foregroundColor(Color("Main"))
                            .padding(.bottom, 20)
                        
                        Text(rule.example)
                            .font(.title3)
                            .foregroundColor(Color("Main").opacity(0.6))
                    }
                    
                    if currentSearchItem.type == .GrammarForms {
                        let form: GrammarFormModel = env.GetCourse().grammarForms[currentSearchItem.index]
                        
                        Text(form.description)
                            .font(.title3)
                            .foregroundColor(Color("Main"))
                        
                        ForEach(form.types){ type in
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
    }
    
    func CheckString(text: String)->Bool {
        return searchQuery == "" ? true : text.contains(searchQuery)
    }
    
    func CreateSearchVocabularyData()->[SearchItem] {
        var data: [SearchItem] = []
        
        if env.GetCourse().vocabulary.count - 1 > 0 {
            for i in 2...(env.GetCourse().vocabulary.count - 1){
                if env.GetCourse().vocabulary[i].vocabulary.count - 1 > 0 {
                    for j in 0...(env.GetCourse().vocabulary[i].vocabulary.count - 1){
                        var added: Bool = false
                        
                        if searchRule.bookmarked && !added {
                            let bookmark = env.GetCourse().vocabulary[i].vocabulary[j].bookmarked
                            
                            if bookmark {
                                added = true
                                data.append(SearchItem(type: .Vocabulary, index: i, index2: j, index3: -1))
                            }
                        }
                        
                        if searchRule.learnSet && !added {
                            let learnSetTitle = env.GetCourse().vocabulary[i].title
                            
                            if CheckString(text: learnSetTitle) {
                                added = true
                                data.append(SearchItem(type: .Vocabulary, index: i, index2: j, index3: -1))
                            }
                        }
                        
                        if searchRule.vocabularyVocab && !added {
                            let vocable = env.GetCourse().vocabulary[i].vocabulary[j].vocable
                            
                            if CheckString(text: vocable) {
                                added = true
                                data.append(SearchItem(type: .Vocabulary, index: i, index2: j, index3: -1))
                            }
                        }
                        
                        if searchRule.vocabularyExtra && !added {
                            let extra = env.GetCourse().vocabulary[i].vocabulary[j].extra
                            
                            if CheckString(text: extra) {
                                added = true
                                data.append(SearchItem(type: .Vocabulary, index: i, index2: j, index3: -1))
                            }
                        }
                        
                        if searchRule.vocabularyTranslation && !added {
                            let translation = env.GetCourse().vocabulary[i].vocabulary[j].translation
                            
                            if CheckString(text: translation) {
                                added = true
                                data.append(SearchItem(type: .Vocabulary, index: i, index2: j, index3: -1))
                            }
                        }
                    }
                }
            }
        }
        
        return data
    }
    
    func CreateSearchGrammarRulesData()->[SearchItem] {
        var data: [SearchItem] = []
        
        if env.GetCourse().grammarRules.count - 1 > 0 {
            for i in 0...(env.GetCourse().grammarRules.count - 1){
                var added: Bool = false
                
                if searchRule.bookmarked && !added {
                    let bookmark = env.GetCourse().grammarRules[i].bookmarked
                    
                    if bookmark {
                        added = true
                        data.append(SearchItem(type: .GrammarRules, index: i, index2: -1, index3: -1))
                    }
                }
                
                if searchRule.ruleTitle && !added {
                    let title = env.GetCourse().grammarRules[i].title
                    
                    if CheckString(text: title) {
                        added = true
                        data.append(SearchItem(type: .GrammarRules, index: i, index2: -1, index3: -1))
                    }
                }
                
                if searchRule.ruleText && !added {
                    let text = env.GetCourse().grammarRules[i].description
                    
                    if CheckString(text: text) {
                        added = true
                        data.append(SearchItem(type: .GrammarRules, index: i, index2: -1, index3: -1))
                    }
                }
                
                if searchRule.ruleExample && !added {
                    let example = env.GetCourse().grammarRules[i].example
                    
                    if CheckString(text: example) {
                        added = true
                        data.append(SearchItem(type: .GrammarRules, index: i, index2: -1, index3: -1))
                    }
                }
            }
        }

        return data
    }
    
    func CreateSearchGrammarFormsData()->[SearchItem] {
        var data: [SearchItem] = []
        
        if env.GetCourse().grammarForms.count - 1 > 0{
            for i in 0...(env.GetCourse().grammarForms.count - 1){
                var added: Bool = false
                
                if searchRule.bookmarked && !added {
                    let bookmark = env.GetCourse().grammarForms[i].bookmarked
                    
                    if bookmark {
                        added = true
                        data.append(SearchItem(type: .GrammarForms, index: i, index2: -1, index3: -1))
                    }
                }
                
                if searchRule.formTitle && !added {
                    let title = env.GetCourse().grammarForms[i].title
                    
                    if CheckString(text: title) {
                        added = true
                        data.append(SearchItem(type: .GrammarForms, index: i, index2: -1, index3: -1))
                    }
                }
                
                if searchRule.formDescription && !added {
                    let description = env.GetCourse().grammarForms[i].description
                    
                    if CheckString(text: description) {
                        added = true
                        data.append(SearchItem(type: .GrammarForms, index: i, index2: -1, index3: -1))
                    }
                }
                
                if searchRule.formTypes && !added && env.GetCourse().grammarForms[i].types.count - 1 > 0 {
                    for j in 0...(env.GetCourse().grammarForms[i].types.count - 1){
                        let type = env.GetCourse().grammarForms[i].types[j]
                        
                        if CheckString(text: type.type) && !added {
                            added = true
                            data.append(SearchItem(type: .GrammarForms, index: i, index2: -1, index3: -1))
                        }
                        
                        if CheckString(text: type.example) && !added {
                            added = true
                            data.append(SearchItem(type: .GrammarForms, index: i, index2: -1, index3: -1))
                        }
                        
                        if env.GetCourse().grammarForms[i].types[j].example.count - 1 > 0 && !added {
                            for k in 0...(env.GetCourse().grammarForms[i].types[j].words.count - 1){
                                let word = env.GetCourse().grammarForms[i].types[j].words[k]
                                
                                if CheckString(text: word) && !added {
                                    added = true
                                    data.append(SearchItem(type: .GrammarForms, index: i, index2: -1, index3: -1))
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return data
    }
    
    func CreateSearchItems()->[SearchItem] {
        let vocabulary = CreateSearchVocabularyData()
        let rules = CreateSearchGrammarRulesData()
        let forms = CreateSearchGrammarFormsData()
        
        return vocabulary + rules + forms
    }
    
    @ViewBuilder
    func CardSearchItem(item: SearchItem)->some View{
        if item.type == .Vocabulary {
            let vocable = env.GetCourse().vocabulary[item.index].vocabulary[item.index2]
            
            Button {
                currentSearchItem = item
                showSearchRules = false
                showCurrentSearchItem.toggle()
            }label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("Blue"))
                    
                    VStack {
                        HStack {
                            Text(vocable.vocable)
                                .fontWeight(.semibold)
                                .padding(.leading)
                            #if os(iOS)
                                .foregroundColor(Color("Main"))
                            #endif
                            
                            Spacer(minLength: 10)
                            
                            Text(vocable.translation)
                                .fontWeight(.semibold)
                                .padding(.trailing)
                            #if os(iOS)
                                .foregroundColor(Color("Main"))
                            #endif
                        }
                        .padding(.bottom, 5)
                        
                        HStack {
                            Text(vocable.extra == "" ? "-" : vocable.extra)
                            #if os(iOS)
                                .foregroundColor(Color("Main"))
                            #endif
                            
                            Spacer()
                            
                            Text(env.GetCourse().vocabulary[item.index].title)
                                .font(.caption)
                            #if os(iOS)
                                .foregroundColor(Color("Main"))
                            #endif
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        
        if item.type == .GrammarRules {
            let grammarRule = env.GetCourse().grammarRules[item.index]
            
            Button {
                currentSearchItem = item
                showSearchRules = false
                showCurrentSearchItem.toggle()
            }label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("Pink"))
                    
                    Text(grammarRule.title)
                        .fontWeight(.semibold)
                    #if os(iOS)
                        .foregroundColor(Color("Main"))
                    #endif
                }
            }
        }
        
        if item.type == .GrammarForms {
            let grammarForms = env.GetCourse().grammarForms[item.index]
            
            Button {
                currentSearchItem = item
                showSearchRules = false
                showCurrentSearchItem.toggle()
            }label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("Purple"))
                    
                    Text(grammarForms.title)
                        .fontWeight(.semibold)
                    #if os(iOS)
                        .foregroundColor(Color("Main"))
                    #endif
                }
            }
        }
    }
}
