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
        // Remove everything after and including decimal place
        let cleaned = "\(self)".components(separatedBy: ".")[0]
        // Used to format years with comments
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        // Handle not being able to create number from cleaned string
        if let num = numberFormatter.number(from: cleaned) {
            return numberFormatter.string(from: num) ?? cleaned
        } else {
            return cleaned
        }
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

extension AttributedString {
    init(styledMarkdown markdownString: String) throws {
        var output = try AttributedString(
            markdown: markdownString,
            options: .init(
                allowsExtendedAttributes: true,
                interpretedSyntax: .full,
                failurePolicy: .returnPartiallyParsedIfPossible
            ),
            baseURL: nil
        )
        
        for (intentBlock, intentRange) in output.runs[AttributeScopes.FoundationAttributes.PresentationIntentAttribute.self].reversed() {
            guard let intentBlock = intentBlock else { continue }
            for intent in intentBlock.components {
                switch intent.kind {
                case .header(level: let level):
                    switch level {
                    case 1:
                        output[intentRange].font = .system(.title).bold()
                    case 2:
                        output[intentRange].font = .system(.title2).bold()
                    case 3:
                        output[intentRange].font = .system(.title3).bold()
                    default:
                        break
                    }
                default:
                    break
                }
            }
            
            if intentRange.lowerBound != output.startIndex {
                output.characters.insert(contentsOf: "\n", at: intentRange.lowerBound)
            }
        }
        
        self = output
    }
}
