import SwiftUI

class GlobalEnvironment: ObservableObject {
    @Published var courses: [CourseModal]
    @Published var currentCourse: Int
    @Published var settings: SettingsModel
    @Published var data: DataModel
    
    init() {
        courses = [
            CourseModal(name: "Latein", vocabulary: latinVocabulary(), grammarRules: latinGrammarRules(), grammarForms: latinGrammarForms()),
            CourseModal(name: "English", vocabulary: englishVocabulary(), grammarRules: englishGrammarRules(), grammarForms: englishGrammarForms())
        ]
        
        currentCourse = 0
        
        settings = SettingsModel()
        data = DataModel()
        
        printCurrentCourseToConsole()
    }
    
    func GetCourse()->CourseModal{
        return courses[currentCourse]
    }
    
    func deserializeBookmarks(){
        let bookmarks = data.bookmarks.split(separator: "]")
        
        for bookmark in bookmarks {
            let sub = bookmark.split(separator: "}")
            
            if sub.count != 5 && sub.count != 3 {
                assert(false)
            }
            
            for i in courses.indices {
                if courses[i].name == sub[0] {
                    if sub[1] == "V" {
                        for j in courses[i].vocabulary.indices {
                            if courses[i].vocabulary[j].title == sub[2] {
                                for k in courses[i].vocabulary[j].vocabulary.indices {
                                    if courses[i].vocabulary[j].vocabulary[k].vocable == sub[3] && courses[i].vocabulary[j].vocabulary[k].translation == sub[4] {
                                        courses[i].vocabulary[j].vocabulary[k].bookmarked = true
                                    }
                                }
                            }
                        }
                    } else if sub[1] == "F" {
                        for j in courses[i].grammarForms.indices {
                            if courses[i].grammarForms[j].title == sub[2] {
                                courses[i].grammarForms[j].bookmarked = true
                            }
                        }
                    } else if sub[1] == "R" {
                        for j in courses[i].grammarRules.indices {
                            if courses[i].grammarRules[j].title == sub[2] {
                                courses[i].grammarRules[j].bookmarked = true
                            }
                        }
                    } else {
                        assert(false)
                    }
                }
            }
        }
    }
    
    func saveBookmark(search: SearchItem, _ bookmark: Bool){
        let text = createBookmarkText(search: search)
        
        if data.bookmarks.contains(text){
            if bookmark {
                return
            }
            
            data.bookmarks = data.bookmarks.replacingOccurrences(of: text, with: "")
        } else {
            if !bookmark {
                return
            }
            
            data.bookmarks.append(text)
        }
    }
    
    private func createBookmarkText(search: SearchItem)->String {
        var str = ""
        
        switch(search.type){
        case .Vocabulary:
            // Latin}V}1}amare}lieben}]
            let cur = GetCourse().vocabulary[search.index]
            let cur1 = GetCourse().vocabulary[search.index].vocabulary[search.index2]
            str = "\(GetCourse().name)}V}\(cur.title)}\(cur1.vocable)}\(cur1.translation)}]"
            break
        case .GrammarForms:
            // Latin}F}Konjugation}]
            let cur = GetCourse().grammarForms[search.index]
            str = "\(GetCourse().name)}F}\(cur.title)}]"
            break
        case .GrammarRules:
            // Latin}R}Dativus Possesivus}]
            let cur = GetCourse().grammarRules[search.index]
            str = "\(GetCourse().name)}R}\(cur.title)}]"
            break
        }
        
        return str
    }
    
    func printCurrentCourseToConsole() {
        for learnset in courses[currentCourse].vocabulary {
            print(learnset.id)
            print(learnset.title)
            
            for vocable in learnset.vocabulary {
                var vocAndExtra = vocable.vocable
                
                if vocable.extra != "" {
                    vocAndExtra += ", "
                    vocAndExtra += vocable.extra
                }
                
                print("\(vocable.translation)||\(vocAndExtra)")
            }
        }
    }
}
