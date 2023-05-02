import SwiftUI

func latinGrammarRules()->[GrammarRuleModel] {
    return [
        GrammarRuleModel(title: "Dativus Possesivus", description: "Der Dativ gibt in Kombination mit einer Form von 'esse' an, was eine Person besitzt.", example: "Estne tibi pecunia, quinte? (= Ist dir Geld, Quintis?) -> Hast du Geld, Quintus?"),
        GrammarRuleModel(title: "Ablativus Instrumenti", description: "Der Ablativus Instrumenti beschreibt womit etwas gemacht wurde und steht auf die Frage 'Womit?' / 'Wodurch?', wobei vor allem Dinge ohne Präpositionen und Personen mit Präpositionen ('mit', 'durch') stehen.", example: "Oculis cernimus. -> Wir sehen mit den Augen."),
        GrammarRuleModel(title: "Ablativus Temporis", description: "Beschreibt die Zeit und steht bei Zeitbegriffen nach der Frage 'Wann?' ohne Präpositionen.", example: "brevi tempore -> in kurzer Zeit"),
        GrammarRuleModel(title: "Akkusativ der Zeitstrecke", description: "Der Akkusativ der Zeitstrecke beschreibt die Zeit und steht bei Zeitbegriffen nach der Frage 'Wie lange?' ohne Präposition.", example: "Plus annum in urbe fui. -> Ich war über ein Jahr in der Stadt."),
        GrammarRuleModel(title: "Ablativus Separationis", description: "Der Ablativus wird mit der Präposition 'von' übersetzt und steht auf die Frage 'Wovon?.", example: "Homines non differunt a bestiis. -> Die Menschen unterscheiden sich nicht von wilden Tieren"),
        GrammarRuleModel(title: "Ablativus Qualitates", description: "Der Ablativus Qualitates gibt die Eigenschaft (Qualität) einer Person/Sache an und wird mit 'von' oder freier übersetzt.", example: "hostis summa potestate -> ein Feind von höchster Macht"),
        GrammarRuleModel(title: "Genitivus Qualitates", description: "Ähnelt dem Ablativ Qualitatis sehr, mit der Ausnahme, dass er ein Genitiv ist.", example: "oppidum duodecim annorum -> eine Stadt von 12 Jahren (eine 12 Jahre alte Stadt)"),
        GrammarRuleModel(title: "Genitivus Partitivus", description: "Der Genitivus Partitivus beschreibt einen bestimmten Teil aus einer größeren Menge, wobei die Übersetzung mit 'von' oder frei erfolgt.", example: "nemo nostrum -> niemand von uns"),
        GrammarRuleModel(title: "Genitivus Objectivus", description: "Der Genitivus Objectivus beschreibt ein Objekt/Person, auf die sich eine Handlung erstreckt und wird in dem Falle verwendet, in dem der normale Genitiv keinen Sinn ergibt und mit 'vor' übersetzt.", example: "ius legis -> das Recht des Gesetzes (normaler Genitiv) / das Recht vor dem Gesetz (Gen. Objectivus)"),
        GrammarRuleModel(title: "Apposition", description: "Als Apposition wird ein Satzteil bezeichnet, wenn ein Nomen oder Adjektiv im selben Fall wie ein weiteres Nomen steht und dieses näher beschreibt.", example: "Liber fovea inveniendi libenter legitur. -> Das Buch, eine Fundgrube, wird gerne gelesen."),
        GrammarRuleModel(title: "Prädikativum", description: "Ein Prädikativum ist eine Apposition, die sich nicht auf ein Nomen sondern das Prädikat bezieht. Sie muss mit 'als' übersetzt werden.", example: "Quintus primus ad tumulum venit. -> Quintus kommt als erster zum Hügel."),
        GrammarRuleModel(title: "Cuncta Regel", description: "Die Cuncta Regel beschreibt ein Pronomen, welches im 1. oder 4. Fall Plural Neutrum ohne Bezugswort steht. Dieses Pronomen muss im Singular und wenn es das Subjekt des Satzes ist auch das Prädikat im Singular übersetzt werden.", example: "Quae dixit -> Er sagte dieses."),
        GrammarRuleModel(title: "Relativer Anschluss", description: "Wenn es kein Fragesatz ist und eine Form von 'qui'/'quae'/'quod' am Satzanfang steht, muss es mit 'dieser'/'diese'/'dieses' übersetzt werden.", example: "Quae dixit -> Er sagte dieses."),
        GrammarRuleModel(title: "Ablativus Comperationis", description: "Der Ablativus Comperationis wird für Vergleiche verwendet, wobei er oft auch ohne 'quam' steht.", example: "plus necessario -> mehr als notwendig")
    ]
}
