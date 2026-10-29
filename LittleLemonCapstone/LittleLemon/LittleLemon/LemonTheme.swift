import SwiftUI

enum LemonTheme {
    static let green = Color(red: 0.29, green: 0.40, blue: 0.36)
    static let yellow = Color(red: 0.96, green: 0.81, blue: 0.35)
    static let cream = Color(red: 0.98, green: 0.97, blue: 0.94)
    static let dark = Color(red: 0.18, green: 0.24, blue: 0.22)
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .foregroundStyle(LemonTheme.dark)
            .background(LemonTheme.yellow, in: RoundedRectangle(cornerRadius: 12))
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
