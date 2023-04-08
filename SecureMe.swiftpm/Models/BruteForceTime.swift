import SwiftUI

struct BruteForceTime {
    var years: Decimal
    var months: Decimal
    var days: Decimal
    var hours: Decimal
    var minutes: Decimal
    var seconds: Decimal
    
    // Create the string to show the user in PasswordCrackingView()
    func passwordCrackingTimeString() -> String {
        // Don't calculate if everything will be zero
        if years.clean == "0" && months.clean == "0" && days.clean == "0" && hours.clean == "0" && minutes.clean == "0" && seconds.clean == "0" {
            return "less than a second"
        }
        
        var timeString = ""

        if self.years.clean != "0" {
            timeString += "\(self.years.clean) years"
        }

        if self.months.clean != "0" {
            // Format incase year is 0
            if self.years.clean != "0" {
                timeString += ", "
            }
            timeString += "\(self.months.clean) months"
        }

        if self.days.clean != "0" {
            if self.years.clean != "0" || self.months.clean != "0" {
                timeString += ", "
            }
            timeString += "\(self.days.clean) days"
        }

        if self.hours.clean != "0" {
            if self.years.clean != "0" || self.months.clean != "0" || self.days.clean != "0" {
                timeString += ", "
            }
            timeString += "\(self.hours.clean) hours"
        }

        if self.minutes.clean != "0" {
            if self.years.clean != "0" || self.months.clean != "0" || self.days.clean != "0" || self.hours.clean != "0" {
                timeString += ", "
            }
            timeString += "\(self.minutes.clean) minutes"
        }

        if self.seconds.clean != "0" {
            if self.years.clean != "0" || self.months.clean != "0" || self.days.clean != "0" || self.hours.clean != "0" || self.minutes.clean != "0" {
                timeString += " and "
            }
            timeString += "\(self.seconds.clean) seconds"
        }
        
        // Just for the technicality
        return "approximately " + timeString
    }
}
