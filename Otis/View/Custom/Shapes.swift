import SwiftUI

struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let pt1 = CGPoint(x: 0, y: 20)
            let pt2 = CGPoint(x: 0, y: rect.height - 20)
            let pt3 = CGPoint(x: rect.width / 2, y: rect.height)
            let pt4 = CGPoint(x: rect.width, y: rect.height - 20)
            let pt5 = CGPoint(x: rect.width, y: 20)
            let pt6 = CGPoint(x: rect.width / 2, y: 0)
            
            path.move(to: pt6)
            
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 15)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 15)
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 15)
            path.addArc(tangent1End: pt4, tangent2End: pt5, radius: 15)
            path.addArc(tangent1End: pt5, tangent2End: pt6, radius: 15)
            path.addArc(tangent1End: pt6, tangent2End: pt1, radius: 15)
        }
    }
}

struct OtisShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path {path in
            let mid = rect.width / 2
            let height = rect.height
            let radius: CGFloat = 50
            let radius2: CGFloat = 25
            
            
            path.addArc(center: CGPoint(x: mid - 100, y: height), radius: radius, startAngle: .init(degrees: 285), endAngle: .init(degrees: -10), clockwise: true)
            
            path.move(to: CGPoint(x: mid - 45, y: height - radius))
            path.addLine(to: CGPoint(x: mid, y: height - radius))
            path.addLine(to: CGPoint(x: mid, y: height + radius))
            
            path.move(to: CGPoint(x: mid + 35, y: height - radius))
            path.addLine(to: CGPoint(x: mid + 35, y: height + radius))
            
            path.move(to: CGPoint(x: mid + 95, y: height + radius))
            path.addArc(center: CGPoint(x: mid + 95, y: height + radius - radius2), radius: radius2, startAngle: .init(degrees: 120), endAngle: .init(degrees: 270), clockwise: true)
            path.addArc(center: CGPoint(x: mid + 95, y: height + radius - 3 * radius2), radius: radius2, startAngle: .init(degrees: 90), endAngle: .init(degrees: 300), clockwise: false)
        }
    }
}

struct Shape_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(env: EnvironmentObject<GlobalEnvironment>())
    }
}
