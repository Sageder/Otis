import SwiftUI

struct PopupData: Identifiable {
    var id = UUID().uuidString
    
    var title: String
    var image: String
    var action: ()->Void
}

struct PopupView: View {
    @Binding var show: Bool
    var data: [PopupData]
    var width: CGFloat = 170
    var backgroundColor: Color = Color("BG1").opacity(0.9)
    var foregroundColor: Color = Color("Main")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            ForEach(data){item in
                Button {
                    item.action()
                } label: {
                    HStack(spacing: 15){
                        Image(systemName: item.image)
                            .foregroundColor(Color("Main1"))
                            .padding(isMacOS() ? 5 : 7)
                            .background(Color("Main"))
                            .clipShape(Circle())
                        
                        Text(item.title)
                            .foregroundColor(Color("Main"))
                    }
                }
                
                Divider()
            }
            
            Button(action: {
                show = false
            }, label: {
                HStack(alignment: .center) {
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(Color("Main1"))
                        .padding(isMacOS() ? 7 : 9)
                        .background(Color("Main"))
                        .clipShape(Circle())
                    
                    Spacer()
                }
            })
        }
        .foregroundColor(foregroundColor)
        .frame(width: width)
        .padding()
        .background(backgroundColor)
        .cornerRadius(20)
    }
}
