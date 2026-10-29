# Little Lemon — iOS Capstone Project

## Included files
- `LittleLemon/LittleLemon.xcodeproj` — Xcode project for an iOS SwiftUI app.
- `LittleLemon/LittleLemon/` — source code, menu.json, and asset catalog.
- `Wireframe/HomeWireframe.jpg` — wireframe of the Home screen for peer review.

## Requirements implemented
1. Home wireframe JPG.
2. Three-page first-launch onboarding: first name, last name, email, with Next buttons.
3. Home sections: header, hero (restaurant intro + search), category menu breakdown, food menu list.
4. Profile displays onboarding values and saves changes using AppStorage (UserDefaults).
5. Profile Log out clears saved profile values and reopens onboarding.
6. NavigationStack, NavigationLink food rows, system Back button on detail/Profile screens.
7. Search and selectable category filters (All, Starters, Mains, Desserts, Drinks).
8. Bundled local JSON menu decoded with Codable. The app works offline.

## Open and test on a Mac
1. Unzip the archive.
2. Open `LittleLemon/LittleLemon.xcodeproj` with Xcode 15 or later.
3. Select an iPhone Simulator, then Product > Run (Cmd+R).
4. Complete onboarding; verify each screen and search/category filters.
5. Open Profile, save changes, terminate/reopen the app and confirm values persist.
6. Use Log out; confirm onboarding returns and old profile data is cleared.
7. Click a dish to verify detail navigation and Back behavior.

### Distribution and review
Upload *the whole repository*, including the `.xcodeproj`, source files, and JPG wireframe. Use Git to commit and push. Supply the repository URL on Coursera. Review two peer submissions.

## Notes
- Project uses sample menu data and SF Symbols instead of copyrighted food photos.
- The simulator build and runtime behavior **have not been verified here** because Xcode requires macOS.
- App has no backend dependency and needs no API keys.
- If signing is requested for a physical device, choose your Apple Development Team in Xcode's Signing & Capabilities.
