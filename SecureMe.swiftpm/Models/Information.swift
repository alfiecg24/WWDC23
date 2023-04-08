import SwiftUI

// MARK: - InformationElement
struct InformationElement: Codable, Hashable {
    let title, image: String
    let content: [Content]
}

// MARK: - Content
struct Content: Codable, Hashable {
    let heading, content: String
}

typealias Information = [InformationElement]

func getInformation() -> Information {
    do {
        // Get URL and contents of Information.json
        let jsonFile = Bundle.main.url(forResource: "Information", withExtension: "json")
        let json = try Data(contentsOf: jsonFile!)
        
        // Try to decode it into Information type
        do {
            let decoded = try JSONDecoder().decode(Information.self, from: json)
            return decoded
        }
        catch let e {
            print("⚠️ Error: could not decode from JSON file. \(e)")
        }
        
    }
    catch let e {
        print("⚠️ Error: could not get contents of Information.json. \(e)")
    }
    return Information()
}
