import SwiftUI

struct CourseModal: Identifiable {
    var id: String = UUID().uuidString
    
    var name: String
    
    var vocabulary: [VocabularyModel]
    var grammarRules: [GrammarRuleModel]
    var grammarForms: [GrammarFormModel]
}

struct VocabularyDefinition: Identifiable, Equatable {
    var id = UUID().uuidString
    var bookmarked: Bool = false
    
    var vocable: String
    var extra: String
    var translation: String
}

struct VocabularyModel: Identifiable {
    var id = UUID().uuidString
    
    var title: String
    var vocabulary: [VocabularyDefinition]
}

struct GrammarRuleModel: Identifiable, Equatable {
    var id = UUID().uuidString
    var bookmarked: Bool = false
    
    var title: String
    var description: String
    var example: String
}

struct GrammarFormTypeDefinition: Identifiable, Equatable {
    var id = UUID().uuidString
    
    var type: String
    var example: String
    var words: [String]
    
    func wordsToString()->String {
        var out: String = ""
        
        for i in 0...(words.count - 1){
            out.append(words[i])
            
            if i < words.count - 1 {
                out.append(", ")
            }
        }
        
        return out
    }
}

struct GrammarFormModel: Identifiable {
    var id = UUID().uuidString
    var bookmarked: Bool = false
    
    var title: String
    var description: String
    var types: [GrammarFormTypeDefinition]
}
