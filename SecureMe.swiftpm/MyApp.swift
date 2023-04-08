import SwiftUI

@main
struct MyApp: App {
    
    init() {
        print("Init!")
        var cfURL = Bundle.main.url(forResource: "WorkSans-Regular", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        cfURL = Bundle.main.url(forResource: "WorkSans-Bold", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        cfURL = Bundle.main.url(forResource: "WorkSans-SemiBold", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        print("Registered fonts")
    }
    
    var body: some Scene {
        WindowGroup {
            TitleScreenView()
        }
    }
}
