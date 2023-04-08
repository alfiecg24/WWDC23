import SwiftUI

struct PasswordCrackingView: View {
    @State private var password = ""
    @State private var result = ""
    
    @State private var passwordStrengthString = ""
    @State private var passwordStrengthColor: Color = .white
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                TextField("Enter your password", text: $password)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(.secondary, lineWidth: 1)
                    }
                    .frame(width: geometry.size.width / 2, height: 75)
                    .onChange(of: password, perform: { value in
                        if password != "" && password != " " {
                            // Remove spaces from the password
                            password = password.replacingOccurrences(of: " ", with: "")
                            if password.count > 25 {
                                withAnimation(.easeInOut) {
                                    // Explain why there is a 25-character limit
                                    result = "🚨 Unfortunately, your password must be 25 digits or less to calculate the time it would take to crack! This is because the algorithm uses very big numbers and anything after 25 characters causes issues with how large the numbers are."
                                }
                            } else {
                                let bruteForceTime = Password(password: password).calculateTimeToCrack()
                                withAnimation(.easeInOut, {
                                    result = "⏰ Your password would take \(bruteForceTime.passwordCrackingTimeString()) to brute force!"
                                })
                            }
                            passwordStrengthIndication()
                        }
                    })
                if password != "" && password != " " {
                    // Dynamic password strength indicator
                    Text("This password is \(passwordStrengthString)")
                        .foregroundColor(passwordStrengthColor)
                        .font(Font(UIFont(name: "WorkSans-SemiBold", size: 25.0)!))
                } else {
                    Text("Enter your password to begin!")
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "WorkSans-SemiBold", size: 25.0)!))
                }
                Text(result)
                    .frame(width: geometry.size.width / 1.5)
                    .foregroundColor(.white)
                    .font(Font(UIFont(name: "WorkSans-Regular", size: 19.0)!))
                    .padding()
                    .multilineTextAlignment(.center)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
    
    // Configure password strength string and colour for password
    func passwordStrengthIndication() {
        print("🏋️‍♂️ Computing strength of \(password)")
        switch Password(password: password).passwordStrength {
        case .veryWeak:
            passwordStrengthString = "very weak"
            passwordStrengthColor = .red
        case .weak:
            passwordStrengthString = "weak"
            passwordStrengthColor = .orange
        case .moderate:
            passwordStrengthString = "moderate"
            passwordStrengthColor = .yellow
        case .strong:
            passwordStrengthString = "strong"
            passwordStrengthColor = .green
        case .veryStrong:
            passwordStrengthString = "very strong"
            passwordStrengthColor = .cyan
        default:
            passwordStrengthString = ""
            passwordStrengthColor = .white
        }
    }
    
}

struct PasswordCrackingView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordCrackingView()
    }
}
