import SwiftUI

struct PasswordView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GradientBackground()
                    .blur(radius: 10)
                HStack {
                    PasswordCrackingView()
                        // Use the - 10 because it fixes an issue with the Divider not being centered
                        .frame(width: geometry.size.width / 2 - 10,  height: geometry.size.height)
                    Divider()
                        .frame(height: (geometry.size.height / 5) * 4)
                        .padding(.bottom)
                    PasswordGeneratorView()
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                }
            }
        }
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
    }
}
