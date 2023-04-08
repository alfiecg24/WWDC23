import SwiftUI

struct SplashScreens: View {
    // Different messages to show on splash screens
    let messages = ["In the first half of 2022, there were an estimated 2.8 billion malware attacks.", "Luckily, only around 6.2% of computer malware was found to target macOS systems. As for mobile malware, iOS accounts for less than 0.1% of infections.", "However, it is always important to make sure you are protected against these threats to prevent you being targeted by them."]
    
    // Which message to show
    @State private var index = 0
    
    // Go to the main view at end of messages
    @State private var goToMainView = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GradientBackground()
                VStack {
                    Text(messages[index])
                        .font(Font(UIFont(name: "WorkSans-SemiBold", size: 25.0)!))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        // Set width and height to stop button moving when it transitions
                        .frame(width: 350, height: 300)
                    
                    Button(action: {
                        // Do it elegantly
                        withAnimation(.easeInOut, {
                            if index == (messages.count - 1) {
                                goToMainView.toggle() 
                            } else {
                                index += 1
                            }
                        })
                    }, label: {
                        ZStack {
                            Circle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color(red: 43/255, green: 173/255, blue: 254/255))
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .frame(width: 300, height: 75, alignment: .center)
                        
                    })
                }
            }
            // Go to the main view
            .fullScreenCover(isPresented: $goToMainView, content: {
                MainView()
            })
        }
    }
}

struct SplashScreens_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreens()
    }
}
