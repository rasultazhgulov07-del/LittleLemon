import SwiftUI

@main
struct LittleLemonApp: App {
    @AppStorage("onboardingComplete") private var onboardingComplete = false

    var body: some Scene {
        WindowGroup {
            Group {
                if onboardingComplete {
                    NavigationStack { HomeView() }
                } else {
                    OnboardingView()
                }
            }
            .tint(LemonTheme.green)
        }
    }
}
