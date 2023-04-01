import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var selected = 1
    var body: some View {
        ZStack {
            // Handle which view to display under tab bar
            if selected == 1 {
                PasswordView() 
            } else {
                InformationView()
            }
            
            // The main floating tab bar 
            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        // Dark mode compatibility
                        .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.2) : Color.white.opacity(0.4))
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.easeOut) {
                                selected = 1
                            }
                        }, label: {
                            VStack(alignment: .center, spacing: 2) {
                                Image(systemName: selected == 1 ? "lock.shield.fill" : "lock.shield")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .scaledToFit()
                                    .frame(width: 23, height: 23, alignment: .center)
                                Text("Passwords")
                                   .font(Font(UIFont(name: "WorkSans-Regular", size: 13)!))
                            }
                        })
                        // Dark mode compatibility and handle selection
                        .foregroundColor(selected == 1 ? .accentColor : .secondary)
                        Spacer()
                        
                        Divider()
                            .frame(height: 40)
                        
                        Spacer()
                        Button(action: {
                            withAnimation(.easeOut) {
                                selected = 2
                            }
                        }, label: {
                            VStack(alignment: .center, spacing: 2) {
                                Image(systemName: selected == 2 ? "info.bubble.fill" : "info.bubble")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .scaledToFit()
                                    .frame(width: 23, height: 23, alignment: .center)
                                Text("Information")
                                    .font(Font(UIFont(name: "WorkSans-Regular", size: 13)!))
                            }
                        })
                        // Dark mode compatibility and handle selection
                        .foregroundColor(selected == 2 ? .accentColor : .secondary)
                        Spacer()
                    }
                }
                .frame(width: 350, height: 65, alignment: .center)
                .padding(.bottom)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
