import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        HStack {
            Button {
                env.settings.appearance = .Light
            } label: {
                VStack {
                    AppearanceView(colorScheme: .light)
                    
                    Text("Hell")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Main"))
                    
                    Circle()
                        .fill(Color("Main1").opacity(env.settings.appearance == .Light ? 1 : 0.2))
                        .frame(width: 17, height: 17)
                }
            }
            
            Button {
                env.settings.appearance = .Dark
            } label: {
                VStack {
                    AppearanceView(colorScheme: .dark)
                    
                    Text("Dunkel")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Main"))
                    
                    Circle()
                        .fill(Color("Main1").opacity(env.settings.appearance == .Dark ? 1 : 0.2))
                        .frame(width: 15, height: 15)
                }
            }
        }
    }
    
    @ViewBuilder
    func AppearanceView(colorScheme: ColorScheme)->some View{
        let bg = colorScheme == .light ? Color(red: 1, green: 1, blue: 1) : Color(red: 0.118, green: 0.118, blue: 0.196)
        let main = colorScheme == .light ? Color(red: 0, green: 0, blue: 0) : Color(red: 1, green: 1, blue: 1)
        let blue = colorScheme == .light ? Color(red: 0.106, green: 0.702, blue: 0.953) : Color(red: 0.049, green: 0.292, blue: 0.640)
        
        ZStack {
            if isMacOS() {
                Rectangle()
                    .fill(bg)
                    .frame(width: 200, height: 140)
                    .cornerRadius(12)
                
                VStack {
                    Text("Otis")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(main)
                        .padding(.bottom, 30)
                    
                    HStack {
                        VStack {
                            Rectangle()
                                .fill(blue)
                                .frame(width: 40, height: 20)
                                .cornerRadius(12)
                            
                            Rectangle()
                                .fill(blue)
                                .frame(width: 40, height: 40)
                                .cornerRadius(12)
                        }
                        
                        VStack {
                            Rectangle()
                                .fill(blue)
                                .frame(width: 40, height: 40)
                                .cornerRadius(12)
                            
                            Rectangle()
                                .fill(blue)
                                .frame(width: 40, height: 20)
                                .cornerRadius(12)
                        }
                        
                        VStack {
                            Rectangle()
                                .fill(blue)
                                .frame(width: 40, height: 30)
                                .cornerRadius(12)
                            
                            Rectangle()
                                .fill(blue)
                                .frame(width: 40, height: 30)
                                .cornerRadius(12)
                        }
                        
                        Rectangle()
                            .fill(blue)
                            .frame(width: 40, height: 60)
                            .cornerRadius(12)
                    }
                }
            } else {
                Rectangle()
                    .fill(bg)
                    .frame(width: 100, height: 200)
                    .cornerRadius(12)
                
                VStack {
                    Text("Otis")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(main)
                        .padding(.bottom, 50)
                    
                    Rectangle()
                        .fill(blue)
                        .frame(width: 80, height: 30)
                        .cornerRadius(12)
                    
                    Rectangle()
                        .fill(blue)
                        .frame(width: 80, height: 30)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
    }
}
