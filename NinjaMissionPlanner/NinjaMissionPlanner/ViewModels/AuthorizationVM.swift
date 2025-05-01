//
//  AuthorizationVM.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

/// 🧙‍♂️ AuthorizationVM is your gatekeeper to the dojo. Handles sign-up, sign-in,
/// password recovery, and identity storage using UserDefaults under the hood (AppStorage).
/// Think of it as your ninja login scroll – keeps your credentials stashed for when you return.
class AuthorizationVM: ObservableObject {

    /// Whether the current ninja has passed the security test and entered the dojo.
    /// From 'Mastering The Basics - Variables'
    @Published var isSignedIn: Bool = false

    /// If the login jutsu fails, this will store the error message to display.
    @Published var loginErrorMessage: String?

    /// Stores the chosen ninja alias using AppStorage. It’s their code name in the field.
    @AppStorage(NinjaConstants.AppStorage.userName.key) private var storedUserName: String = ""

    /// Emoji-based avatar for your ninja profile – stored securely like a summoning seal.
    @AppStorage(NinjaConstants.AppStorage.userAvatar.key) private var storedUserAvatar: String = "🥷"

    /// The email used to enter the gates of the app. Stored for demo purposes (not secure IRL).
    @AppStorage(NinjaConstants.AppStorage.authEmail.key) private var authEmail: String = ""

    /// Secret passphrase for the ninja vault. Stored locally in this demo version.
    @AppStorage(NinjaConstants.AppStorage.authPassword.key) private var authPassword: String = ""

    /// Whether the ninja remains inside the dojo even after closing the app.
    @AppStorage(NinjaConstants.AppStorage.isSignedIn.key) private var storedSignIn: Bool = false

    /// The public alias the user chose — the name whispered across the scrolls.
    var userName: String {
        storedUserName
    }

    /// The chosen avatar emoji representing your chakra-infused presence.
    var userAvatar: String {
        storedUserAvatar
    }

    /// Initializes the view model. If `storedSignIn` is true, the ninja remains inside.
    init() {
        self.isSignedIn = storedSignIn
    }

    /// Attempts to register a new ninja with their scroll credentials.
    ///
    /// - Parameters:
    ///   - email: The sacred email scroll used for login.
    ///   - password: Your personal secret technique (a password).
    ///   - alias: Your chosen ninja name.
    ///   - avatar: Emoji that represents your vibe.
    /// - Returns: `true` if sign-up was successful. `false` if the user already exists.
    func signUp(email: String, password: String, alias: String, avatar: String) -> Bool {
        /// From 'Functions' and 'Optionals' — casting spell to sign up a new user!
        guard email != authEmail else {
            // Already summoned? Time to log in instead.
            return false
        }

        // Save credentials locally – not battle-ready for production, but fine for this dojo.
        self.authEmail = email
        self.authPassword = password
        self.storedUserName = alias
        self.storedUserAvatar = avatar
        self.isSignedIn = true
        self.storedSignIn = true
        return true
    }

    /// Attempts to log in the user with the provided scrolls.
    ///
    /// - Parameters:
    ///   - email: The email scroll to authenticate.
    ///   - password: The hidden technique used to verify identity.
    func signIn(email: String, password: String) {
        /// From 'Control Flow' — checking credentials and switching state.
        guard email == authEmail, password == authPassword else {
            loginErrorMessage = NinjaConstants.Strings.invalidCredentials.value
            isSignedIn = false
            return
        }

        loginErrorMessage = nil
        isSignedIn = true
        storedSignIn = true
    }

    /// Initiates a password recovery flow.
    /// In this demo dojo, it simply resets the user and displays an error message scroll.
    func forgotPassword() {
        /// From 'Functions' + 'Error Handling (demo-only flow)'
        loginErrorMessage = NinjaConstants.Strings.passwordRecoveryNotAvailable.value
        signOut()
    }

    /// Performs the logout jutsu. Kicks the user from the dojo and clears their presence.
    func signOut() {
        isSignedIn = false
        storedSignIn = false
    }

    /// Returns current user's ninja identity: name and emoji face.
    ///
    /// - Returns: A tuple with `(name, avatar)` – used to display the user's profile.
    func currentUserInfo() -> (name: String, avatar: String) {
        return (userName, userAvatar)
    }

    /// Updates the ninja's profile details.
    ///
    /// - Parameters:
    ///   - name: The new alias to be known by.
    ///   - avatar: A new magical emoji to represent the ninja's form.
    func updateProfile(name: String, avatar: String) {
        /// From 'Functions' + 'Properties' — update your ninja alias and look.
        storedUserName = name
        storedUserAvatar = avatar
    }
}
