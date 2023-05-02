import SwiftUI

enum TagState {
    case Top
    case Bottom
}

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    
    var title: String
    var size: Int
    
    func getSize()->CGFloat {
        return CGFloat(title.count * size + size)
    }
}

struct Tags {
    var bottomTags: [Tag] = []
    var topTags: [Tag] = []
    
    init(bottomTags: [Tag] = [], topTags: [Tag] = []){
        self.bottomTags = bottomTags
        self.topTags = topTags
    }
    
    init(bottomStrArr: [String] = [], topStrArr: [String] = [], size: Int){
        for str in bottomStrArr {
            bottomTags.append(Tag(title: str, size: size))
        }
        
        for str in topStrArr {
            topTags.append(Tag(title: str, size: size))
        }
    }
    
    mutating func createTagsFormStringArray(strArr: [String], size: Int, state: TagState){
        for str in strArr {
            if state == .Bottom {
                bottomTags.append(Tag(title: str, size: size))
            } else {
                topTags.append(Tag(title: str, size: size))
            }
        }
    }
    
    func getAllString(state: TagState)->[String] {
        var temp: [String] = []
        
        if state == .Bottom {
            for tag in bottomTags {
                temp.append(tag.title)
            }
        } else {
            for tag in topTags {
                temp.append(tag.title)
            }
        }
        
        return temp
    }
    
    func getState(id: String)->TagState {
        for tag in bottomTags {
            if tag.id == id {
                return .Bottom
            }
        }
        
        for tag in topTags {
            if tag.id == id {
                return .Top
            }
        }
        
        fatalError()
    }
    
    mutating func changeToOtherState(id: String){
        let state = getState(id: id)
        
        if state == .Bottom {
            for i in 0...(bottomTags.count - 1){
                if bottomTags[i].id == id {
                    topTags.append(bottomTags[i])
                    bottomTags.remove(at: i)
                    return
                }
            }
        } else {
            for i in 0...(topTags.count - 1){
                if topTags[i].id == id {
                    bottomTags.append(topTags[i])
                    topTags.remove(at: i)
                    return
                }
            }
        }
        
        fatalError()
    }
}

struct TagView: View {
    @Binding var tags: Tags
    var foregroundColor: Color = Color("Main")
    var backgroundColor: Color = Color("Blue")
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 15) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(getRows(screenWidth: proxy.frame(in: .global).size.width - 90, state: .Top), id: \.self){ row in
                            HStack(spacing: 10){
                                ForEach(row){ tag in
                                    TagButton(tag: tag)
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(backgroundColor)
                )
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(getRows(screenWidth: proxy.frame(in: .global).size.width - 90, state: .Bottom), id: \.self){ row in
                            HStack(spacing: 10){
                                ForEach(row){ tag in
                                    TagButton(tag: tag)
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(backgroundColor.opacity(0.5))
                )
            }
        }
    }
    
    @ViewBuilder
    func TagButton(tag: Tag)->some View {
        Button {
            tags.changeToOtherState(id: tag.id)
        } label: {
            Text(tag.title)
                .font(.title3)
                .foregroundColor(foregroundColor)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("BG"))
                )
        }
    }
    
    func getRows(screenWidth: CGFloat, state: TagState)->[[Tag]] {
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []

        var totalWidth: CGFloat = 0
        
        if state == .Bottom {
            tags.bottomTags.forEach { tag in
                totalWidth += tag.getSize()
                if totalWidth > screenWidth {
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                    totalWidth = 0
                } else {
                    currentRow.append(tag)
                }
            }
        } else {
            tags.topTags.forEach { tag in
                totalWidth += tag.getSize()
                if totalWidth > screenWidth {
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                    totalWidth = 0
                } else {
                    currentRow.append(tag)
                }
            }
        }
        
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        return rows
    }
}
