import SwiftUI

enum StudyType: Int {
    case VocableToTranslation = 0
    case TranslationToVocable = 1
}

enum Appearance: Int {
    case Light = 0
    case Dark = 1
}

struct SettingsModel {
    var appearance: Appearance = .Light
    var studyType: StudyType = .VocableToTranslation
    var autoCorrection = false
}
