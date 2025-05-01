//
//  SignUpScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct SignUpView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var authVM: AuthorizationVM
    @EnvironmentObject var missionsVM: MissionsVM

    @State private var ninjaAlias: String = ""
    @State private var selectedAvatar: String? = nil
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var avatarScale: CGFloat = 1.0
    @State private var rippleEffect = false
    @State private var isLoading: Bool = false
    @State private var showAlert = false
    @State private var alertMessage: String = ""

    /// From 'Data Types, Constants, Variables and Expressions'
    let avatars = ["🥷", "🐱", "🍃", "🤖", "🦉", "⚡️"]

    // MARK: - UI

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        CloseIconImage()
                    }
                }

                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(NinjaConstants.Strings.signUpNew.value)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(NinjaConstants.Strings.signUpDojoAccessFor.value)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }

                TextField(NinjaConstants.Strings.enterNinjaAlias.value, text: $ninjaAlias)
                    .autocapitalization(.none)
                    .padding()
                    .background(Capsule().strokeBorder(NinjaConstants.Colors.kineticMatrixOrange.color(), lineWidth: 1))

                VStack(alignment: .leading, spacing: 10) {
                    Text(NinjaConstants.Strings.chooseAvatar.value)
                        .font(.headline)
                        .padding(.leading)
                        .foregroundColor(colorScheme == .dark ? Color.white : NinjaConstants.Colors.gray.color())

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(avatars, id: \.self) { avatar in
                            Button(action: {
                                selectedAvatar = avatar
                                avatarScale = 1.4
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                    avatarScale = 1.0
                                }
                                rippleEffect = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    rippleEffect = true
                                }
                            }) {
                                ZStack {
                                    if selectedAvatar == avatar {
                                        RippleCircle(color: NinjaConstants.Colors.kineticMatrixOrange.color(), animate: $rippleEffect)
                                            .frame(width: 80, height: 80)
                                    }

                                    Text(avatar)
                                        .font(.largeTitle)
                                        .scaleEffect(selectedAvatar == avatar ? avatarScale : 1.0)
                                        .frame(width: 80, height: 80)
                                        .background(selectedAvatar == avatar ? NinjaConstants.Colors.kineticMatrixOrange.color().opacity(0.3) : Color.clear)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(NinjaConstants.Colors.kineticMatrixOrange.color(), lineWidth: 1))
                                }
                            }
                        }
                    }
                }

                TextField(NinjaConstants.Strings.email.value, text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Capsule().strokeBorder(NinjaConstants.Colors.kineticMatrixOrange.color(), lineWidth: 1))

                HStack {
                    if isPasswordVisible {
                        TextField(NinjaConstants.Strings.password.value, text: $password)
                            .autocapitalization(.none)
                    } else {
                        SecureField(NinjaConstants.Strings.password.value, text: $password)
                            .autocapitalization(.none)
                    }
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? NinjaConstants.Images.eyeIcon.name : NinjaConstants.Images.eyeSlashIcon.name)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Capsule().strokeBorder(NinjaConstants.Colors.kineticMatrixOrange.color(), lineWidth: 1))

                Button(action: handleSignUp) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: NinjaConstants.Colors.kineticMatrixOrange.color()))
                            .frame(maxWidth: .infinity)
                    } else {
                        Text(NinjaConstants.Strings.letsGo.value)
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? NinjaConstants.Colors.yellow.color() : NinjaConstants.Colors.kineticMatrixOrange.color())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                Capsule().stroke(
                                    LinearGradient(
                                        gradient: Gradient.orangeYellowPurple,
                                        startPoint: .leading,
                                        endPoint: .trailing),
                                    lineWidth: 3.0)
                                .auraEffect()
                            )
                            .shadow(color: NinjaConstants.Colors.kineticMatrixOrange.color().opacity(0.5), radius: 10, x: 0, y: 0)
                    }
                }
                .disabled(isLoading)
                .padding(.top, 24)
            }
            .padding(24)
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .alert(NinjaConstants.Strings.alertTitle.value, isPresented: $showAlert) {
            Button(NinjaConstants.Strings.gotIt.value, role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    // MARK: - Logic

    private func handleSignUp() {
        guard !email.isEmpty, !password.isEmpty, !ninjaAlias.isEmpty, let avatar = selectedAvatar else {
            alertMessage = NinjaConstants.Strings.pleaseCompleteAllFields.value
            showAlert = true
            return
        }

        guard ninjaAlias.isValidUsername else {
            alertMessage = NinjaConstants.Strings.invalidUsername.value
            showAlert = true
            return
        }

        guard email.isValidEmail else {
            alertMessage = NinjaConstants.Strings.invalidEmailAddress.value
            showAlert = true
            return
        }

        guard password.isValidPassword else {
            alertMessage = NinjaConstants.Strings.invalidPassword.value
            showAlert = true
            return
        }

        isLoading = true
        alertMessage = ""
        showAlert = false

        /// Simluating a delay that would happen if your app is talking to your auth provider.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            isLoading = false

            let didSignUp = authVM.signUp(
                email: email,
                password: password,
                alias: ninjaAlias,
                avatar: avatar
            )

            if didSignUp {
                missionsVM.resetToDefault()
            } else {
                alertMessage = NinjaConstants.Strings.alreadyRegisteredMessage.value
                showAlert = true
            }
        }
        /// No need to dismiss since the root will change via isSignedIn.
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let authVM = AuthorizationVM()
        let missionsVM = MissionsVM()
        SignUpView()
            .environmentObject(authVM)
            .environmentObject(missionsVM)
    }
}
