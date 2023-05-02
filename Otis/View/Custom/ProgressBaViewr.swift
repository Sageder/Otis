import SwiftUI

struct ProgressBarView: View {
    var width: CGFloat = 200
    var height: CGFloat = 20
    var percent: CGFloat = 0
    var color1 = Color("Main")
    var color2 = Color("Main")
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .foregroundColor(.gray.opacity(0.2))
                .frame(width: width, height: height, alignment: .top)
            
            
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .background(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .leading, endPoint: .trailing).clipShape(RoundedRectangle(cornerRadius: height, style: .continuous)))
                .foregroundColor(.clear)
                .frame(width: percent * (width / 100), height: height, alignment: .top)
        }
    }
}
