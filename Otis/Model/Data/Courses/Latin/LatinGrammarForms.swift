import SwiftUI

func latinGrammarForms()->[GrammarFormModel] {
    return [
        GrammarFormModel(title: "Deklinationen", description: "Alle Deklinationen bei Nomen.", types: [
            GrammarFormTypeDefinition(type: "A. (f.)", example: "amica", words: ["a", "ae", "ae", "am", "a", "a", "ae", "arum", "is", "as", "ae", "is"]),
            GrammarFormTypeDefinition(type: "O. (m.)", example: "amicus", words: ["us", "i", "o", "um", "e", "o", "i", "orum", "is", "os", "i", "is"]),
            GrammarFormTypeDefinition(type: "O. (n.)", example: "forum", words: ["um", "i", "o", "um", "um", "o", "a", "orum", "is", "a", "a", "is"]),
            GrammarFormTypeDefinition(type: "Kons. (f.)", example: "vox", words: ["x", "is", "i", "em", "x", "e", "es", "um", "ibus", "es", "es", "ibus"]),
            GrammarFormTypeDefinition(type: "Kons. (m.)", example: "homo", words: ["o", "is", "i", "em", "o", "e", "es", "um", "ibus", "es", "es", "ibus"]),
            GrammarFormTypeDefinition(type: "Kons. (n.)", example: "flumen", words: ["en", "is", "i", "en", "en", "e", "a", "um", "ibus", "a", "a", "ibus"]),
            GrammarFormTypeDefinition(type: "Misch. (f.)", example: "navis", words: ["is", "is", "i", "em",  "is", "e", "es", "ium", "ibus", "es", "es", "ibus"]),
            GrammarFormTypeDefinition(type: "Misch. (f.)", example: "urbs", words: ["s", "is", "i", "em", "s", "e", "es", "ium", "ibus", "es", "es", "ibus"]),
            GrammarFormTypeDefinition(type: "I. (f.)", example: "turris", words: ["is", "is", "i", "im", "is", "i", "es", "ium", "ibus", "es", "es", "ibus"]),
            GrammarFormTypeDefinition(type: "I. (n.)", example: "mare", words: ["e", "is", "i", "e", "e", "i", "ia", "ium", "ibus", "ia", "ia", "ibus"]),
            GrammarFormTypeDefinition(type: "E. (f.)", example: "res", words: ["es", "ei", "ei", "em", "es", "e", "es", "rerum", "ebus", "es", "es", "ebus"]),
            GrammarFormTypeDefinition(type: "U. (m.)", example: "casus", words: ["us", "us", "ui", "um", "us", "u", "us", "uum", "ibus", "us", "us", "ibus"])
        ]),
        GrammarFormModel(title: "Deklinationen der Adjektiva", description: "Alle Deklinationen bei Adjektiven.", types: [
            GrammarFormTypeDefinition(type: "A. (f.)", example: "bona", words: ["a", "ae", "ae", "am", "a", "a", "ae", "arum", "is", "as", "ae", "is"]),
            GrammarFormTypeDefinition(type: "O. (m.)", example: "bonus", words: ["us", "i", "o", "um", "e", "o", "i", "orum", "is", "os", "i", "is"]),
            GrammarFormTypeDefinition(type: "O. (n.)", example: "bonum", words: ["um", "i", "o", "um", "e", "o", "a", "orum", "is", "a", "a", "is"]),
            GrammarFormTypeDefinition(type: "3. (m./f.)", example: "atrox", words: ["x", "is", "i", "em", "x", "i", "es", "ium", "ibus", "es", "es", "ibus"]),
            GrammarFormTypeDefinition(type: "3. (n.)", example: "atrox", words: ["x", "is", "i", "x", "x", "i", "ia", "ium", "ibus", "ia", "ia", "ibus"]),
            GrammarFormTypeDefinition(type: "3. (m./f.)", example: "fortis", words: ["is", "is", "i", "em", "is", "i", "es", "ium", "ibus", "es", "es", "ibus"]),
            GrammarFormTypeDefinition(type: "3. (n.)", example: "forte", words: ["e", "is", "i", "e", "e", "i", "ia", "ium", "ibus", "ia", "ia", "ibus"]),
            GrammarFormTypeDefinition(type: "3. (m.)", example: "celer", words: ["er", "is", "i", "em", "em", "i", "es", "ium", "ibus", "es", "es", "ibus"]),
            GrammarFormTypeDefinition(type: "3. (f.)", example: "celeris", words: ["is", "is", "i", "em", "em", "i", "es", "ium", "ibus", "es", "es", "ibus"]),
            GrammarFormTypeDefinition(type: "3. (n.)", example: "celere", words: ["e", "is", "i", "e", "e", "i", "ia", "ium", "ibus", "ia", "ia", "ibus"]),
            GrammarFormTypeDefinition(type: "Komparativ (m./f.)", example: "fortior", words: ["ior", "ioris", "iori", "iorem", "ior", "iore", "iores", "iorum", "ioribus", "iores", "iores", "ioribus"]),
            GrammarFormTypeDefinition(type: "Komparativ (n.)", example: "fortius", words: ["ius", "ioris", "iori", "ius", "ius", "iore", "iora", "iorum", "ioribus", "iora", "iora", "ioribus"]),
            GrammarFormTypeDefinition(type: "Superlativ (normal, f.)", example: "clarissima", words: ["issima", "issimae", "issimae", "issimam", "issima", "issima", "issimae", "issimarum", "issimis", "issimas", "issimae", "issimis"]),
            GrammarFormTypeDefinition(type: "Superlativ (normal, m.)", example: "clarissimus", words: ["issimus", "issimi", "issimo", "issimum", "issime", "issimo", "issimi", "issimorum", "issimis", "issimos", "issimi", "issimis"]),
            GrammarFormTypeDefinition(type: "Superlativ (normal, n.)", example: "clarissimum", words: ["issimum", "issimi", "issimo", "issimum", "issimum", "issimo", "issima", "issimorum", "issimis", "issima", "issima", "issimis"]),
            GrammarFormTypeDefinition(type: "Superlativ (auf Endung 'er', f.)", example: "pulcherrima", words: ["errima", "errimae", "errimae", "errimam", "errima", "errima", "errimae", "errimarum", "errimis", "errimas", "errimae", "errimis"]),
            GrammarFormTypeDefinition(type: "Superlativ (auf Endung 'er', m.)", example: "pulcherrimus", words: ["errimus", "errimi", "errimo", "errimum", "errime", "errimo", "errimi", "errimorum", "errimis", "errimos", "errimi", "errimis"]),
            GrammarFormTypeDefinition(type: "Superlativ (auf Endung 'er', n.)", example: "pulcherrimum", words: ["errimum", "errimi", "errimo", "errimum", "errimum", "errimo", "errima", "errimorum", "errimis", "errima", "errima", "errimis"]),
            GrammarFormTypeDefinition(type: "Superlativ (auf Endung 'ilis', f.)", example: "facillima", words: ["illima", "illimae", "illimae", "illimam", "illima", "illima", "illimae", "illimarum", "illimis", "illimas", "illimae", "illimis"]),
            GrammarFormTypeDefinition(type: "Superlativ (auf Endung 'ilis', m.)", example: "facillimus", words: ["illimus", "illimi", "illimo", "illimum", "illime", "illimo", "illimi", "illimorum", "illimis", "illimos", "illimi", "illimis"]),
            GrammarFormTypeDefinition(type: "Superlativ (auf Endung 'ilis', n.)", example: "facillimum", words: ["illimum", "illimi", "illimo", "illimum", "illimum", "illimo", "illima", "illimorum", "illimis", "illima", "illima", "illimis"]),
        ]),
        GrammarFormModel(title: "Unregelmäßige Adjektive - Steigerung", description: "Die Steigerung der wichtigsten unregelmäßigen Adjektive.", types: [
            GrammarFormTypeDefinition(type: "magnus/a/um", example: "= groß", words: ["magnus/a/um", "maior/maius", "maximus/a/um"]),
            GrammarFormTypeDefinition(type: "pravus/a/um", example: "= klein", words: ["pravus/a/um", "minor/minus", "minimus/a/um"]),
            GrammarFormTypeDefinition(type: "bonus/a/um", example: "= gut", words: ["bonus/a/um", "melior/melius", "optimus/a/um"]),
            GrammarFormTypeDefinition(type: "malus/a/um", example: "= schlecht", words: ["malus/a/um", "peior/peius", "pssimus/a/um"]),
            GrammarFormTypeDefinition(type: "multi/ae/a", example: "= viele", words: ["multi/ae/a", "plures/plura", "plurimi/ae/a"]),
            GrammarFormTypeDefinition(type: "multum", example: "= viel", words: ["multum", "plus/pluris", "plurimum"]),
        ]),
        GrammarFormModel(title: "Konjugationen", description: "Alle regelmäßigen Kunjugationen der Verben.", types: [
            GrammarFormTypeDefinition(type: "A. Präsens Aktiv", example: "Präsensstamm + Endung (amo = ich liebe)", words: ["o", "as", "at", "amus", "atis", "ant"]),
            GrammarFormTypeDefinition(type: "A. Imperfekt Aktiv", example: "Präsensstamm + 'a' + 'ba' + Endung (amabam = ich liebte)", words: ["bam", "bas", "bat", "bamus", "batis", "bant"]),
            GrammarFormTypeDefinition(type: "A. Futur Aktiv", example: "Präsensstamm + Endung (amabo = ich werde lieben)", words: ["bo", "bis", "bit", "bimus", "bitis", "bunt"]),
            GrammarFormTypeDefinition(type: "A. Perfekt Aktiv", example: "Perfektstamm + Endung (amavi = ich liebte)", words: ["i", "isti", "it", "imus", "itis", "erunt"]),
            GrammarFormTypeDefinition(type: "A. Plusquamperfekt Aktiv", example: "Perfektstamm + Endung (amaveram = ich hatte geliebt)", words: ["eram", "eras", "erat", "eramus", "eratis", "erant"]),
            GrammarFormTypeDefinition(type: "E. Präsens Aktiv", example: "Präsensstamm + Endung (moneo = ich ermahne)", words: ["eo", "es", "et", "emus", "etis", "ent"]),
            GrammarFormTypeDefinition(type: "E. Imperfekt Aktiv", example: "Präsensstamm + 'e' + 'ba' + Endung (monebam = ich ermahnte)", words: ["bam", "bas", "bat", "bamus", "batis", "bant"]),
            GrammarFormTypeDefinition(type: "E. Futur Aktiv", example: "Präsensstamm + Endung (monebo = ich werde ermahnen)", words: ["bo", "bis", "bit", "bimus", "bitis", "bunt"]),
            GrammarFormTypeDefinition(type: "E. Perfekt Aktiv", example: "Perfektstamm + Endung (monui = ich ermahnte)", words: ["i", "isti", "it", "imus", "itis", "erunt"]),
            GrammarFormTypeDefinition(type: "E. Plusquamperfekt Aktiv", example: "Perfektstamm + Endung (monueram = ich hatte ermahnt)", words: ["eram", "eras", "erat", "eramus", "eratis", "erant"]),
            GrammarFormTypeDefinition(type: "Kons. Präsens Aktiv", example: "Präsensstamm + Endung (mitto = ich schicke)", words: ["o", "is", "it", "imus", "itis", "unt"]),
            GrammarFormTypeDefinition(type: "Kons. Imperfekt Aktiv", example: "Präsensstamm + 'e' + 'ba' + Endung (mittebam = ich schickte)", words: ["bam", "bas", "bat", "bamus", "batis", "bant"]),
            GrammarFormTypeDefinition(type: "Kons. Futur Aktiv", example: "Präsensstamm + 'a'/'e' (mittam = ich werde schicken)", words: ["am", "es", "et", "emus", "etis", "ent"]),
            GrammarFormTypeDefinition(type: "Kons. Perfekt Aktiv", example: "Perfektstamm + Endung (misi = ich schickte)", words: ["i", "isti", "it", "imus", "itis", "erunt"]),
            GrammarFormTypeDefinition(type: "Kons. Plusquamperfekt Aktiv", example: "Perfektstamm + Endung (miseram = ich hatte geschickt)", words: ["eram", "eras", "erat", "eramus", "eratis", "erant"]),
            GrammarFormTypeDefinition(type: "I. Präsens Aktiv", example: "Präsensstamm + Endung (audio = ich höre)", words: ["io", "is", "it", "imus", "itis", "iunt"]),
            GrammarFormTypeDefinition(type: "I. Imperfekt Aktiv", example: "Präsensstamm + 'e' + 'ba' + Endung (audiebam = ich hörte)", words: ["bam", "bas", "bat", "bamus", "batis", "bant"]),
            GrammarFormTypeDefinition(type: "I. Futur Aktiv", example: "Präsensstamm + Endung (audiam = ich werde hören)", words: ["am", "es", "et", "emus", "etis", "ent"]),
            GrammarFormTypeDefinition(type: "I. Perfekt Aktiv", example: "Perfektstamm + Endung (audivi = ich hörte)", words: ["i", "isti", "it", "imus", "itis", "erunt"]),
            GrammarFormTypeDefinition(type: "I. Plusquamperfekt Aktiv", example: "Perfektstamm + Endung (audiveram = ich hatte gehört)", words: ["eram", "eras", "erat", "eramus", "eratis", "erant"]),
            GrammarFormTypeDefinition(type: "Misch. Präsens Aktiv", example: "Präsensstamm + Endung (capio = ich fasse)", words: ["io", "is", "it", "imus", "itis", "iunt"]),
            GrammarFormTypeDefinition(type: "Misch. Imperfekt Aktiv", example: "Präsensstamm + 'e' + 'ba' + Endung (capiebam = ich fasste)", words: ["bam", "bas", "bat", "bamus", "batis", "bant"]),
            GrammarFormTypeDefinition(type: "Misch. Futur Aktiv", example: "Präsensstamm + Endung (capiam = ich werde fassen)", words: ["am", "es", "et", "emus", "etis", "ent"]),
            GrammarFormTypeDefinition(type: "Misch. Perfekt Aktiv", example: "Perfektstamm + Endung (capi = ich fasste)", words: ["i", "isti", "it", "imus", "itis", "erunt"]),
            GrammarFormTypeDefinition(type: "Misch. Plusquamperfekt Aktiv", example: "Perfektstamm + Endung (ceperam = ich hatte gefasst)", words: ["eram", "eras", "erat", "eramus", "eratis", "erant"]),
            GrammarFormTypeDefinition(type: "Präsens Passiv", example: "Präsensstamm + Endung (amor = ich werde geliebt)", words: ["(o)r", "ris", "tur", "mur", "mini", "ntur"]),
            GrammarFormTypeDefinition(type: "Imperfekt Passiv", example: "Präsensstamm + Endung (amabar = ich wurde geliebt)", words: ["bar", "baris", "batur", "bamur", "bamini", "bantur"]),
            GrammarFormTypeDefinition(type: "A. & E. Futur Passiv", example: "Präsensstamm + Endung (amabor = ich werde geliebt werden)", words: ["bor", "beris", "bitur", "bimur", "bimini", "buntur"]),
            GrammarFormTypeDefinition(type: "Misch. & I. & Kons. Futur Passiv", example: "Präsensstamm + Endung (mittar = ich werde geschickt werden)", words: ["ar", "eris", "etur", "emur", "emini", "entur"]),
            GrammarFormTypeDefinition(type: "Perfekt Passiv", example: "PPP + esse in Präsens (amatus sum = ich bin geliebt worden)", words: ["amatus sum", "amatus es", "amatus est", "amati sumus", "amati estis", "amati sunt"]),
            GrammarFormTypeDefinition(type: "Plusquamperfekt Passiv", example: "PPP + esse in Perfekt (amatus eram = ich war geliebt worden)", words: ["amatus eram", "amatus eras", "amatus erat", "amati eramus", "amati eratis", "amati erant"]),
        ]),
        GrammarFormModel(title: "Unregelmäßige Verben", description: "Die wichtigsten unregelmäßigen Verben durchkunjugiert.", types: [
            GrammarFormTypeDefinition(type: "Esse (Präsens Aktiv)", example: "esse = sein", words: ["esse", "es!", "este!", "sum", "es", "est", "sumus", "estis", "sunt"]),
            GrammarFormTypeDefinition(type: "Esse (Imperfekt Aktiv)", example: "esse = sein", words: ["eram", "eras", "erat", "eramus", "eratis", "erant"]),
            GrammarFormTypeDefinition(type: "Esse (Perfekt Aktiv)", example: "esse = sein", words: ["fui", "fuisti", "fuit", "fuimus", "fuistis", "fuerunt"]),
            GrammarFormTypeDefinition(type: "Esse (Plusquamperfekt Aktiv)", example: "esse = sein", words: ["fueram", "fueras", "fuerat", "fueramus", "fueratis", "fuerant"]),
            GrammarFormTypeDefinition(type: "Esse (Futur Aktiv)", example: "esse = sein", words: ["ero", "eris", "erit", "erimus", "eritis", "erunt"]),
            
            //TODO: Passiv
            
            GrammarFormTypeDefinition(type: "Posse (Präsens Aktiv)", example: "posse = imstande sein", words: ["posse", "potes!", "poteste!", "possum", "potes", "potest", "possumus", "potestis", "possunt"]),
            GrammarFormTypeDefinition(type: "Posse (Imperfekt Aktiv)", example: "posse = imstande sein", words: ["poteram", "poteras", "poterat", "poteramus", "poteratis", "poterant"]),
            GrammarFormTypeDefinition(type: "Posse (Perfekt Aktiv)", example: "posse = imstande sein", words: ["potui", "potuisti", "potuit", "potuimus", "potuistis", "potuerunt"]),
            GrammarFormTypeDefinition(type: "Posse (Plusquamperfekt Aktiv)", example: "posse = imstande sein", words: ["potueram", "potueras", "potuerat", "potueramus", "potueratis", "potuerant"]),
            GrammarFormTypeDefinition(type: "Posse (Futur Aktiv)", example: "posse = imstande sein", words: ["potero", "poteris", "poterit", "poterimus", "poteritis", "poterunt"]),
            
            //TODO: Passiv
            
            GrammarFormTypeDefinition(type: "Ire (Präsens Aktiv)", example: "ire = gehen", words: ["i!", "ite!", "eo", "is", "it", "imus", "itis", "eunt"]),
            GrammarFormTypeDefinition(type: "Ire (Imperfekt Aktiv)", example: "ire = gehen", words: ["ibam", "ibas", "ibat", "ibamus", "ibatis", "ibant"]),
            GrammarFormTypeDefinition(type: "Ire (Perfekt Aktiv)", example: "ire = gehen", words: ["ivi", "ivisti", "ivit", "ivimus", "ivistis", "iverunt"]),
            GrammarFormTypeDefinition(type: "Ire (Plusquamperfekt Aktiv)", example: "ire = gehen", words: ["iveram", "iveras", "iverat", "iveramus", "iveratis", "iverant"]),
            GrammarFormTypeDefinition(type: "Ire (Futur Aktiv)", example: "ire = gehen", words: ["ibo", "ibis", "ibit", "ibimus", "ibitis", "ibunt"]),
            
            //TODO: Passiv
            
            GrammarFormTypeDefinition(type: "Ferre (Präsens Aktiv)", example: "ferre = tragen/bringen", words: ["fero", "fers", "fert", "ferimus", "fertis", "ferunt"]),
            GrammarFormTypeDefinition(type: "Ferre (Imperfekt Aktiv)", example: "ferre = tragen/bringen", words: ["ferebam", "ferebas", "ferebat", "ferebamus", "ferebatis", "ferebant"]),
            GrammarFormTypeDefinition(type: "Ferre (Perfekt Aktiv)", example: "ferre = tragen/bringen", words: ["tuli", "tulisti", "tulit", "tulimus", "tulistis", "tulerunt"]),
            GrammarFormTypeDefinition(type: "Ferre (Plusquamperfekt Aktiv)", example: "ferre = tragen/bringen", words: ["tuleram", "tuleras", "tulerat", "tuleramus", "tuleratis", "tulerant"]),
            GrammarFormTypeDefinition(type: "Ferre (Futur Aktiv)", example: "ferre = tragen/bringen", words: ["feram", "feres", "feret", "feremus", "feretis", "ferent"]),
            
            //TODO: passiv
            
            //TODO: add adesse
            
            //TODO: add animadvertere
        ]),
        GrammarFormModel(title: "Personalpromina", description: "Persönliche Fürwörter", types: [
            GrammarFormTypeDefinition(type: "1. Person", example: "ego = ich", words: ["ego", "mei", "mihi", "me", "a me", "mecum", "nos", "nostri", "nostrum", "nobis", "nos", "a nobis", "nobiscum"]),
            GrammarFormTypeDefinition(type: "2. Person", example: "tu = du", words: ["tu", "tui", "tibi", "te", "a te", "tecum", "vos", "vestri", "vestrum", "vobis", "vos", "a vobis", "vobiscum"]),
            GrammarFormTypeDefinition(type: "3. Person (Reflexivpronomen)", example: "sui = seiner/ihrer", words: ["-", "sui", "sibi", "se", "a se", "secum", "-", "sui", "-", "sibi", "se", "a se", "secum"])
        ]),
        GrammarFormModel(title: "Possesivpronomina", description: "Besitzanzeigende Fürwörter. Dekliniert wie Adjektive.", types: [
            GrammarFormTypeDefinition(type: "1. Person", example: "meus = mein, noster = unser", words: ["meus/a/um (Sg.)", "noster/tra/trum (Pl.)"]),
            GrammarFormTypeDefinition(type: "2. Person", example: "tuus = dein, vester = euer", words: ["tuus/a/um (Sg.)", "vester/tra/trum (Pl.)"]),
            GrammarFormTypeDefinition(type: "3. Person", example: "suus = sein, ihr", words: ["suus/a/um (Sg.)", "suus/a/um (Pl.)"])
        ]),
        GrammarFormModel(title: "Interrogativpronomina", description: "Substantivische Fragepronomen", types: [
            GrammarFormTypeDefinition(type: "quis?/quid?", example: "quis?/quid? = wer?/was?", words: ["quis?/quis?", "cuius?", "cui?", "quem?/quid?", "a quo?", "cum quo?"])
        ]),
        GrammarFormModel(title: "Demonstrativpronomina", description: "Hinweisende Fürwörter", types: [
            GrammarFormTypeDefinition(type: "is/ea/id", example: "= dieser/diese/dieses", words: ["is/ea/id", "eius", "ei", "eum/eam/id", "eo/ea/eo", "ii/eae/ea", "eorum/earum/eorum", "iis", "eos/eas/ea", "iis"]),
            GrammarFormTypeDefinition(type: "idem/eadem/idem", example: "= derselbe/dieselbe/dasselbe", words: ["idem/eadem/idem", "eiusdem", "eidem", "eundem/eandem/idem", "eodem/eadem/eodem", "iidem/eaedem/eadem", "eorundem/earundem/eorundem", "iisdem", "eosdem/easdem/eadem", "iisdem"]),
            GrammarFormTypeDefinition(type: "hic/heac/hoc", example: "= dieser/diese/dieses", words: ["hic/heac/hoc", "huius", "hui", "hunc/hanc/hoc", "hoc/hac/hoc", "hi/hae/haec", "horum/harum/horum", "his", "hos/has/haec", "his"]),
            GrammarFormTypeDefinition(type: "ille/illa/illud", example: "= jener/jene/jenes", words: ["ille/illa/illud", "illius", "illi", "illum/illam/illud", "illo/illa/illo", "illi/illae/illa", "illorum/illarum/illorum", "illis", "illos/illas/illa", "illis"]),
            GrammarFormTypeDefinition(type: "ipse/ipsa/ipsum", example: "= selbst", words: ["ipse/ipsa/ipsum", "ipsius", "ipsi", "ipsum/ipsam/ipsum", "ipso/ipsa/ipso", "ipsi/ipsae/ipsa", "ipsorum/ipsarum/ipsorum", "ipsis", "ipsos/ipsas/ipsa", "ipsis"])
        ]),
        GrammarFormModel(title: "Relativpromina", description: "Beziehendes Fürwort", types: [
            GrammarFormTypeDefinition(type: "qui/quae/quod", example: "= der/die/das/welcher/welche/welches; Auch als Fragewort welcher?/welche?/welches? verwendbar.", words: ["qui/quae/quod", "cuius", "cui", "quem/quam/quod", "quo/qua/quo", "qui/quae/quae", "quorum/quarum/quorum", "quibus", "quos/quas/quae", "quibus"]),
            GrammarFormTypeDefinition(type: "quidam/quaedam/quoddam", example: "= Sg.: ein (gewisser), Pl.: einige", words: ["quidam/quaedam/quoddam", "cuiusdam", "cuidam", "quemdam/quamdam/quoddam", "quodam/quadam/quodam", "quidam/quaedam/quaedam", "quorumdam/quarumdam/quorumdam", "quibusdam", "quosdam/quasdam/quaedam", "quibusdam"]),
        ]),
        GrammarFormModel(title: "Numeralia", description: "Zahlwörter", types: [
            GrammarFormTypeDefinition(type: "Ordnungszahlen", example: "primus/a/um = der/die/das Erste", words: ["primus/a/um", "secundus/a/um", "tertius/a/um", "quartus/a/um", "quintus/a/um", "sextus/a/um", "septimus/a/um", "octavus/a/um", "nonus/a/um", "decimus/a/um", "centesimus/a/um", "millesimus/a/um"]),
            GrammarFormTypeDefinition(type: "Grundzahlen", example: "unus/a/um = ein(s)", words: ["unus/a/um", "duo/duae/duo", "tres/tres/tria", "quattuor", "quinque", "sex", "septem", "octo", "novem", "decem", "centum", "mille"]),
            GrammarFormTypeDefinition(type: "Grundzahl - unus", example: "unus/a/um = ein(s)", words: ["unus/a/um", "unius", "uni", "unum/unam/unum", "uno/una/uno"]),
            GrammarFormTypeDefinition(type: "Grundzahl - duo", example: "duo/duae/duo = zwei", words: ["duo/duae/duo", "duorum/duarum/duorum", "duobus/duabus/duobus", "duos/duas/duo", "duobus/duabus/duobus"]),
            GrammarFormTypeDefinition(type: "Grundzahl - tres", example: "tres/tres/tria = drei", words: ["tres/tres/tria", "trium", "tribus", "tres/tres/tria", "tribus"])
        ])
    ]
}
