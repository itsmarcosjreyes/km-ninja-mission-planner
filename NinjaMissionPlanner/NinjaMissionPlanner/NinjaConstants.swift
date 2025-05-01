//
//  NinjaConstants.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

enum NinjaConstants {
    // AppStorage
    enum AppStorage: String {
        case authEmail
        case authPassword
        case isSignedIn
        case ninjasJumpingEnabled
        case ninjaAuraEnabled
        case userAvatar
        case userName

        var key: String {
            return self.rawValue
        }
    }

    // Colors
    enum Colors {
        case green
        case blue
        case gray
        case kineticMatrixMagenta
        case kineticMatrixOrange
        case yellow
        case red

        func color() -> Color {
            switch self {
            case .green: return Color("#00A500")
            case .blue: return Color("#0329D6")
            case .gray: return Color("#384357")
            case .kineticMatrixMagenta: return Color("#AB27A9")
            case .kineticMatrixOrange: return Color("#FF4C00")
            case .yellow: return Color("#F9B50D")
            case .red: return Color("#CB0000")
            }
        }
    }

    // Images
    enum Images: String {
        case addIcon = "add-icon"
        case backIcon = "back-icon"
        case checkmarkCircleIcon = "checkmark.circle"
        case checkmarkFilledIcon = "checkmark.circle.fill"
        case chevronDownIcon = "chevron.down"
        case closeIcon = "close-icon"
        case eyeIcon = "eye"
        case eyeSlashIcon = "eye.slash"
        case filterActiveIcon = "list.clipboard.fill"
        case filterInactiveIcon = "list.clipboard"
        case helpIcon = "questionmark.circle"
        case ninjaTop = "ninja-top"
        case ninjaBottom = "ninja-bottom"
        case nmpLogo = "NinjaMissionPlannerLogo"
        case logoutIcon = "rectangle.portrait.and.arrow.forward"
        case returnIcon = "arrow.uturn.backward.circle.fill"
        case settingsIcon = "slider.horizontal.3"
        case trashIcon = "trash"

        var name: String {
            return self.rawValue
        }
    }

    // MissionFilter
    enum MissionFilter: String {
        case all = "All"
        case completed = "Completed"
        case pending = "Pending"

        var value: String {
            return self.rawValue
        }
    }

    // General Strings
    // For the sake of this demo app, we have user facing strings here, but the better way to handle these
    // would be to use Localized Strings so that our app is future proof
    // we would also separate Strings, from Colors, from Keys
    enum Strings: String {
        case actionCannotBeUndone = "This action cannot be undone"
        case addFirstMission = "add first mission"
        case addMission = "add mission"
        case alertTitle = "⚠️ oops"
        case alreadyRegisteredMessage = "This email is already registered, sign in 🥷"
        case areYouASpy = "Are you a spy?"
        case cancel
        case category = "Category"
        case chooseAvatar = "choose avatar"
        case delete
        case deleteNinjaMission = "Delete 🥷 Mission?"
        case done
        case editMission = "Edit Mission"
        case editProfile = "✏️ Edit"
        case effects
        case email
        case enterNinjaAlias = "enter ninja alias"
        case forgotPassword = "forgot password?"
        case gotIt = "got it"
        case group
        case iAlreadyHaveDojoAccess = "I already have dojo access"
        case ifNotEnterEmailAddress = "if not, enter email below"
        case invalidCredentials = "Invalid credentials. Suspicious 🤔"
        case invalidUsername = "Hmm... that doesn’t look like a valid ninja alias, no spaces! 🧐"
        case invalidEmailAddress = "Hmm... that doesn’t look like a valid email 🧐"
        case invalidPassword = "Passwords must be more than 3 characters and cannot contain spaces 🚫"
        case iWantAccess = "I want access"
        case kineticMatrixFooter = "a sample app, made with love at dojo.KineticMatrix.io"
        case markAsNotDone = "mark as not done"
        case missions = "Missions"
        case missionCompleted = "mission completed"
        case missionDetails = "Mission Details"
        case missionName = "Mission Name"
        case ninjaAlias = "ninja alias"
        case ninjaAura = "ninja aura"
        case ninjasJumping = "ninjas jumping"
        case noMissionsYet = "no missions yet"
        case leaveDojoMessage = "Are you sure you want to leave the Dojo?"
        case letsGo = "let's go!"
        case logout
        case logoutAction = "Log Out"
        case logoutConfirmTitle = "Log Out?"
        case password
        case passwordRecoveryNotAvailable = "Password recovery is not available in demo mode"
        case pleaseCompleteAllFields = "Please complete all fields before entering the dojo!"
        case pleaseFillBothFields = "Please fill in both fields"
        case resetPassword = "reset password"
        case save
        case selectFilter = "Select Filter"
        case settings
        case showHideAuraMessage = "enable or disable the aura glow on buttons ✨"
        case showHideRandomNinjasMessage = "show or hide random ninjas as a surprise 🥷"
        case signInEnter = "⛩️ Enter"
        case signInEnterTheDojo = "Enter the Dojo"
        case signInTheDojo = "the Dojo"
        case signUp = "Sign Up"
        case signUpDojoAccessFor = "Dojo Access for"
        case signUpNew = "⛩️ New"
        case swipeToDeleteHint = "Swipe to quickly complete or delete a mission"
        case yourProfile = "Your Profile"

        var value: String {
            return self.rawValue
        }
    }
}
