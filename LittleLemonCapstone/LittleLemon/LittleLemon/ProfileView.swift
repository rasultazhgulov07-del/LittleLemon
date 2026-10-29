import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("onboardingComplete") private var onboardingComplete = false
    @AppStorage("firstName") private var storedFirstName = ""
    @AppStorage("lastName") private var storedLastName = ""
    @AppStorage("email") private var storedEmail = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var showSaved = false

    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 70))
                        .foregroundStyle(LemonTheme.green)
                    Spacer()
                }.listRowBackground(Color.clear)
            }
            Section("Personal information") {
                TextField("First name", text: $firstName).textContentType(.givenName)
                TextField("Last name", text: $lastName).textContentType(.familyName)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            Section {
                Button("Save changes") {
                    storedFirstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
                    storedLastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
                    storedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    showSaved = true
                }
                .disabled(firstName.isEmpty || lastName.isEmpty || !email.contains("@"))
                Button("Log out", role: .destructive) {
                    // Clear all saved profile fields and reopen the onboarding flow.
                    storedFirstName = ""
                    storedLastName = ""
                    storedEmail = ""
                    firstName = ""
                    lastName = ""
                    email = ""
                    dismiss()
                    onboardingComplete = false
                }
            }
        }
        .navigationTitle("Profile")
        .onAppear {
            firstName = storedFirstName
            lastName = storedLastName
            email = storedEmail
        }
        .alert("Profile saved", isPresented: $showSaved) {
            Button("OK", role: .cancel) { }
        } message: { Text("Your changes will be available after restarting the app.") }
    }
}
