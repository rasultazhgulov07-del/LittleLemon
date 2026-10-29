import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboardingComplete") private var onboardingComplete = false
    @AppStorage("firstName") private var storedFirstName = ""
    @AppStorage("lastName") private var storedLastName = ""
    @AppStorage("email") private var storedEmail = ""

    @State private var step = 0
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""

    private var canContinue: Bool {
        switch step {
        case 0: return !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        case 1: return !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        default: return email.contains("@") && email.split(separator: "@").last?.contains(".") == true
        }
    }

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("LITTLE LEMON").font(.system(size: 23, weight: .heavy, design: .rounded))
                Spacer()
                Text("\(step + 1) / 3").font(.subheadline)
            }
            .foregroundStyle(LemonTheme.green)
            .padding(.top, 28)

            Spacer()
            Image(systemName: step == 0 ? "person.crop.circle" : step == 1 ? "person.text.rectangle" : "envelope.circle")
                .font(.system(size: 95, weight: .ultraLight))
                .foregroundStyle(LemonTheme.green)
                .accessibilityHidden(true)
            Text(step == 0 ? "Welcome to Little Lemon" : step == 1 ? "Nice to meet you" : "One last thing")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            Text(step == 0 ? "Let's personalize your experience." : step == 1 ? "What is your last name?" : "Where can we reach you?")
                .font(.body).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Group {
                if step == 0 {
                    TextField("First name", text: $firstName)
                        .textContentType(.givenName)
                } else if step == 1 {
                    TextField("Last name", text: $lastName)
                        .textContentType(.familyName)
                } else {
                    TextField("Email address", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding(.top, 12)

            Spacer()
            Button(step == 2 ? "Get started" : "Next") {
                if step < 2 {
                    step += 1
                } else {
                    storedFirstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
                    storedLastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
                    storedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    onboardingComplete = true
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(!canContinue)
            .opacity(canContinue ? 1 : 0.55)
            if step > 0 {
                Button("Back") { step -= 1 }
                    .foregroundStyle(LemonTheme.green)
            }
        }
        .padding(24)
        .background(LemonTheme.cream.ignoresSafeArea())
    }
}
