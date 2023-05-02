import SwiftUI

struct DataIntroTabDefinition: Identifiable {
    var id = UUID().uuidString
    
    var title: String
    var subTitle: String
    var description: String
    var image: String
}

struct DataModel: Identifiable {
    var id = UUID().uuidString
    
    var showIntro: Bool = true
    var gameHighScore: Int = 0
    var bookmarks: String = ""
}
