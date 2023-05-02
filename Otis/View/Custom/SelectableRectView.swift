import SwiftUI

struct SelectableRectView: View {
    @Binding var isOn: Bool
    var title: String
    var secondTitle: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(isOn ? Color("Blue") : Color("Blue").opacity(0.6))
                
                VStack {
                    Text(title)
                        .foregroundColor(Color("Main"))
                        .font(.callout)
                        .padding(.bottom, 15)
                    
                    HStack {
                        Text(secondTitle)
                            .foregroundColor(Color("Main"))
                            .font(.caption)
                        
                        Image(systemName: isOn ? "checkmark" : "xmark")
                            .resizable()
                            .foregroundColor(Color("Main"))
                            .frame(width: 10, height: 10, alignment: .bottomTrailing)
                            .font(.caption)
                    }
                }
            }
            .frame(width: width, height: height, alignment: .center)
        }
    }
}
