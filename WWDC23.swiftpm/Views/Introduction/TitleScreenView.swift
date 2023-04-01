import SwiftUI


struct TitleScreenView: View {
    let colours: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    let text = "Welcome to CyberShield!"
    
    @State private var animate = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var gradientOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GradientBackground()
                // Rotating squares at the corners
//                ForEach(colours, id: \.self) { colour in
//                    Rectangle()
//                        .fill(colour)
//                        .frame(width: 100, height: 100)
//                        .offset(x: geometry.size.width / 2 - 50, y: geometry.size.height / 2 - 50)
//                        .rotationEffect(.degrees(Double(colours.firstIndex(of: colour)! * 60)))
//                        .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: UUID())
//                }
                
                VStack {
                    Text(text)
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "WorkSans-Bold", size: 60.0)!))
                        .padding(.bottom)
                    
                    ContinueButton()
                        .padding()
                }
            }
        }
    }
}

struct ContinueButton: View {
    @State private var goingToNextView = false
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut, {
                // Go to the next view
                goingToNextView.toggle()
            })
        }) {
            HStack {
                Text("Continue")
                    .font(Font(UIFont(name: "WorkSans-Regular", size: 25.0)!))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Image(systemName: "arrow.right.circle")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
            .background(
                // Button background
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 43/255, green: 173/255, blue: 254/255), Color(red: 23/255, green: 138/255, blue: 255/255)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(10)
            .padding(.horizontal)
            .frame(width: 300, height: 75, alignment: .center)
        }
        // Go to the main view when button is clicked
        .fullScreenCover(isPresented: $goingToNextView) {
            SplashScreens()
        }
    }
}
