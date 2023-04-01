import SwiftUI

// Used for generic strength value
enum PasswordStrength {
    case veryWeak
    case weak
    case moderate
    case strong
    case veryStrong
    case unknown
}

struct Password: Equatable {
    var password: String
    var passwordStrength: PasswordStrength
    
    // We won't need to access these values
    private var hasLowerCase: Bool
    private var hasUpperCase: Bool
    private var hasDigits: Bool
    private var hasSpecialCharacters: Bool
    
    
    // Only initialise with password parameter
    init(password: String) {
        self.password = password

        // Check for digits
        let digits = CharacterSet.decimalDigits
        let digitsRange = password.rangeOfCharacter(from: digits)
        self.hasDigits = digitsRange != nil

        // Check for lower case
        let lowerCase = CharacterSet.lowercaseLetters
        let lowerCaseRange = password.rangeOfCharacter(from: lowerCase)
        self.hasLowerCase = lowerCaseRange != nil

        // Check for upper case
        let upperCase = CharacterSet.uppercaseLetters
        let upperCaseRange = password.rangeOfCharacter(from: upperCase)
        self.hasUpperCase = upperCaseRange != nil

        // Check for special characters
        let specialCharacters = CharacterSet.symbols
        let specialCharactersRange = password.rangeOfCharacter(from: specialCharacters)
        self.hasSpecialCharacters = specialCharactersRange != nil
        
        // Calculate password strength as a PasswordStrength case
        self.passwordStrength = .unknown // initialise value so that self can be used
        let entropy = self.calculateEntropy()
        if entropy < 28 { self.passwordStrength = .veryWeak }
        else if entropy <= 35 { self.passwordStrength = .weak }
        else if entropy <= 59 { self.passwordStrength = .moderate }
        else if entropy <= 127 { self.passwordStrength = .strong }
        else if entropy >= 128 { self.passwordStrength = .veryStrong }
        else { self.passwordStrength = .unknown }
    }
    
    // Calculate the pool of possible characters
    private func calculatePool() -> Int {
        // Total possible options for each
        let digitsPool = 10
        let lowerCasePool = 26
        let upperCasePool = 26
        let specialCharactersPool = 32
        
        // Create pool of total possible characters
        var totalPool = 0
        if self.hasLowerCase { totalPool += lowerCasePool }
        if self.hasUpperCase { totalPool += upperCasePool }
        if self.hasDigits { totalPool += digitsPool }
        if self.hasSpecialCharacters { totalPool += specialCharactersPool }
        
        return totalPool
    }
    
    // Calculate the entropy based off of the pool
    private func calculateEntropy() -> Double {
        // Get the total pool
        let pool = self.calculatePool()
        print("🏊‍♂️ Got pool of: \(pool)")
        
        // Calculate entropy per character
        var entropy = log2(Double(pool))
        
        // Calculate password entropy
        entropy = entropy * Double(self.password.count)
        
        return entropy
    }
    
    private func calculateTotalAttempts() -> Decimal {
        // Get the password entropy
        let entropy = self.calculateEntropy()
        print("🚀 Got entropy of \(entropy)")
        
        // Calculate total attempts needed with 2^entropy-1
        let totalAttempts: Decimal = Decimal(pow(2.0, entropy-1.0))
        return totalAttempts
    }

    func calculateTimeToCrack() -> BruteForceTime {
        print("⌨️ Using password: \(self.password)")
        
        // Get the total attempts
        let totalAttempts = self.calculateTotalAttempts()
        print("💯 Total attempts: \(totalAttempts)")
        
        // Calculate time to crack with attempts / attempts per second
        let timeToCrackSeconds = totalAttempts / Decimal(1000000000) // (assume one billion per second)
        print("⏱️ Time to crack in seconds: \(timeToCrackSeconds)")
        
        // Convert seconds to a set of (years, months, days, hours, minutes, seconds)
        let timeToCrackSet = timeToCrackSeconds.secondsToTime()
        
        // Get time to crack as an instance of BruteForceTime
        let timeToCrack = BruteForceTime(years: timeToCrackSet.0, months: timeToCrackSet.1, days: timeToCrackSet.2, hours: timeToCrackSet.3, minutes: timeToCrackSet.4, seconds: timeToCrackSet.5)

        return timeToCrack
    }

}
