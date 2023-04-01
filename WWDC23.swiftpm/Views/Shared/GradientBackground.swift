import SwiftUI

struct GradientBackground: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let lightColours: [Color] = [.blue, .green]
    let darkColours: [Color] = [Color(red: 0, green: 51/255, blue: 102/255), Color(red: 0, green: 0, blue: 102/255)]
    var body: some View {
        // Background gradient
        LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? darkColours : lightColours), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
    }
}
