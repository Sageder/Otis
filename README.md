# Otis

Otis is a learning app that currently focuses on Latin, but will be customizable in the future.
Among the features are not only flash cards and other vocabulary learning modes, 
but also explanations of various grammatical constructs used in Latin, as well as the grammar forms themselves.
These can also be trained in another learning mode.

**Only Latin - German according to the Austrian curriculum (10th - 11th grade) is currently supported.**

## Setup

To use Chipster, you need a Mac with Xcode installed. Follow these steps to get started:
1. Clone this repository to your local machine.
3. Open the project in Xcode.
4. Run the project on your Mac.
5. Start studying!

## Features
- Mac & iPad & iPhone support
- Different study modes
  - Flash cards
  - Multiple choice
  - Answer
- Grammar forms
- Grammar structures
- Latin
  - about 800 Latin words with German translations
  - all major grammar forms (e.g. A-Declination, etc.)
  - some key grammar structures
- Dark mode
- Expandability (See 👇)

## Add a custom language
Additionally, if you want to learn another language you can easily add it:
1. Go to the folder **Model/Data/Courses/** in Xcode
2. Add a folder **YOUR_COURSE**
3. Add these files with this code:
  - YOUR_COURSE_Vocabulary.swift:
```Swift
func YOUR_COURSE_Vocabulary () -> [VocabularyModel] {
  return [
    // ‼️ Don't delete Random & Saved ‼️
    VocabularyModel(title: "Random", vocabulary: []),
    VocabularyModel(title: "Saved", vocabulary: []),
    // Add new model here
  ]
}
```
  - YOUR_COURSE_GammarRules.swift:
```Swift
func YOUR_COURSE_GrammarRules () -> [GrammarRuleModel] {
  return [
    // Add new rules here
  ]
}
```
  - YOUR_COURSE_GammarForms.swift:
```Swift
func YOUR_COURSE_GrammarForms () -> [GrammarFormModel] {
  return [
    // Add new forms here
  ]
}
```
  
## Screenshots
<img width="350" alt="Otis on iPhone" src="https://user-images.githubusercontent.com/77528379/235753846-46b18d9f-b42a-4d59-b3f7-726ff2e4e549.png">
<img width="962" alt="Otis - Mac" src="https://user-images.githubusercontent.com/77528379/235750226-92efb021-4440-43f8-a879-354754938f7c.png">
<img width="962" alt="Otis - Flash Cards" src="https://user-images.githubusercontent.com/77528379/235750637-3f0a0093-1b09-4467-9b1e-d5ef195c70e7.png">
<img width="962" alt="Otis - Multiple Choice" src="https://user-images.githubusercontent.com/77528379/235750822-f8d0aad6-a84c-4df9-b589-28e7b64c0fed.png">
<img width="962" alt="Otis - Grammar Rules" src="https://user-images.githubusercontent.com/77528379/235751249-f422ca70-5ab3-4f90-bc2c-b870fc300223.png">
