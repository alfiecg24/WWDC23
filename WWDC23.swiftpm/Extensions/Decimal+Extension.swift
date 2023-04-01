import SwiftUI

extension Decimal {
    // Implement modulus function for this type as there isn't a built-in one    
    func mod(_ b: Decimal) -> Decimal {
        var d = self/(b)
        var f : Decimal = 0
        NSDecimalRound(&f, &d, 0, .down)
        return self-(b*(f))
    }    
    
    // Used to output brute-force time to user
    var clean: String {
        let cleaned = "\(self)".components(separatedBy: ".")[0]
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let num = numberFormatter.number(from: cleaned) ?? 0
        return numberFormatter.string(from: num) ?? cleaned
    }
    
    // Convert x seconds to years, months, days, hours, minutes, seconds
    func secondsToTime() -> (Decimal, Decimal, Decimal, Decimal, Decimal, Decimal) {
        let years = self / 31536000 // 60 * 60 * 24 * 365
        let months = self.mod(31536000) / Decimal(2592000) // 60 * 60 * 24 * 30
        let days = self.mod(2592000) / 86400 // 60 * 60 * 24
        let hours = self.mod(86400) / 3600 // 60 * 60
        let minutes = self.mod(3600) / 60
        let seconds = self.mod(3600).mod(60)

        return (years, months, days, hours, minutes, seconds)
    }
}
