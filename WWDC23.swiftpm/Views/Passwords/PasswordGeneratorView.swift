import SwiftUI

struct PasswordGeneratorView: View {
    @State private var length = 8.0
    @State private var shouldUseNumbers = true
    @State private var shouldUseDifferentCases = true
    @State private var shouldUseSpecialCharacters = true
    
    @State var password = ""
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text("Password generator")
                        .font(Font(UIFont(name: "WorkSans-Bold", size: 25.0)!))
                    Text("Generate a secure password")
                        .font(Font(UIFont(name: "WorkSans-Regular", size: 17.0)!))
                }
                .foregroundColor(.white)
                .padding(.bottom)
                .onAppear {
                    generatePassword()
                }
                HStack {
                    Slider(value: $length, in: 8.0...25.0, onEditingChanged: { _ in
                        generatePassword()
                    })
                    .frame(width: geometry.size.width / 3)
                    Divider()
                        .frame(height: 25)
                        .padding(.horizontal)
                    Text("Password length: \(Int(length))")
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "WorkSans-Regular", size: 18.0)!))
                }
                Toggle(isOn: $shouldUseNumbers, label: {
                    Text("Use numbers")
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "WorkSans-Regular", size: 18.0)!))
                })
                .frame(width: geometry.size.width / 2)
                .onChange(of: shouldUseNumbers, perform: { _ in
                    generatePassword()
                })
                
                Toggle(isOn: $shouldUseDifferentCases, label: {
                    Text("Use different cases")
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "WorkSans-Regular", size: 18.0)!))
                })
                .frame(width: geometry.size.width / 2)
                .onChange(of: shouldUseDifferentCases, perform: { _ in
                    generatePassword()
                })
                
                Toggle(isOn: $shouldUseSpecialCharacters, label: {
                    Text("Use special characters")
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "WorkSans-Regular", size: 18.0)!))
                })
                .frame(width: geometry.size.width / 2)
                .onChange(of: shouldUseSpecialCharacters, perform: { _ in
                    generatePassword()
                })
                
                HStack {
                    Text(password)
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "WorkSans-Bold", size: 25.0)!))
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.secondary, lineWidth: 1)
                                .frame(height: 50, alignment: .center)
                        }
                        .padding()
                    Divider()
                        .frame(height: 35)
                    Button(action: {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = password
                    }, label: {
                        Image(systemName: "doc.on.clipboard")
                            .foregroundColor(.white)
                    })
                    .padding(.leading)
                }
                .padding()
                
                if password != "" && password != " " {
                    switch Password(password: password).passwordStrength {
                    case .veryWeak:
                        Divider()
                            .frame(width: geometry.size.width / 3)
                            .padding(.bottom)
                        Text("This password is very weak")
                            .foregroundColor(.red)
                            .font(Font(UIFont(name: "WorkSans-SemiBold", size: 25.0)!))
                    case .weak:
                        Divider()
                            .frame(width: geometry.size.width / 3)
                            .padding(.bottom)
                        Text("This password is weak")
                            .foregroundColor(.orange)
                            .font(Font(UIFont(name: "WorkSans-SemiBold", size: 25.0)!))
                    case .moderate:
                        Divider()
                            .frame(width: geometry.size.width / 3)
                            .padding(.bottom)
                        Text("This password is moderate")
                            .foregroundColor(.yellow)
                            .font(Font(UIFont(name: "WorkSans-SemiBold", size: 25.0)!))
                    case .strong:
                        Divider()
                            .frame(width: geometry.size.width / 3)
                            .padding(.bottom)
                        Text("This password is strong")
                            .foregroundColor(.green)
                            .font(Font(UIFont(name: "WorkSans-SemiBold", size: 25.0)!))
                    case .veryStrong:
                        Divider()
                            .frame(width: geometry.size.width / 3)
                            .padding(.bottom)
                        Text("This password is very strong")
                            .foregroundColor(.cyan)
                            .font(Font(UIFont(name: "WorkSans-SemiBold", size: 25.0)!))
                    default:
                        EmptyView()
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
    
    func generatePassword() {
        password = ""
        
        // Create character pool based on preferences
        var pool = Array("abcdefghijklmnopqrstuvwxyz")
        if shouldUseNumbers { pool += Array("0123456789") }
        if shouldUseDifferentCases { pool += Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ") }
        if shouldUseSpecialCharacters { pool += Array("!@£$%^&*()_+=-#{}[];:|,.<>/?") }
        
        // Add to password string
        for _ in 0...(Int(length) - 1) {
            let element = pool[pool.indices.randomElement()!]
            password += "\(element)"
        }
    }
    
}

struct PasswordGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordGeneratorView()
    }
}
