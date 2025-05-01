//
//  SignInScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct SignInView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var authVM: AuthorizationVM

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoading: Bool = false
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @State private var showMissions = false

    // MARK: - UI

    var body: some View {
        NavigationStack {
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

                    Spacer()

                    VStack(alignment: .leading) {
                        Text(NinjaConstants.Strings.signInEnter.value)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(NinjaConstants.Strings.signInTheDojo.value)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer().frame(height: 24)

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
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? NinjaConstants.Images.eyeIcon.name : NinjaConstants.Images.eyeSlashIcon.name)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Capsule().strokeBorder(NinjaConstants.Colors.kineticMatrixOrange.color(), lineWidth: 1))

                    Spacer().frame(height: 14)

                    Button(action: handleSignIn) {
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
                    .padding(.bottom, 16)

                    NavigationLink {
                        ForgotPasswordView()
                    } label: {
                        Text(NinjaConstants.Strings.forgotPassword.value)
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }
                }
                .padding(24)
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .alert(NinjaConstants.Strings.alertTitle.value, isPresented: $showAlert) {
                Button(NinjaConstants.Strings.gotIt.value, role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .navigationDestination(isPresented: $showMissions) {
                MissionsScreen()
                    .environmentObject(authVM)
            }
        }
        .navigationTitle(NinjaConstants.Strings.signInEnterTheDojo.value)
    }

    // MARK: - Logic

    private func handleSignIn() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = NinjaConstants.Strings.pleaseFillBothFields.value
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

        isLoading = true
        /// Simluating a delay that would happen if your app is talking to your auth provider.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            authVM.signIn(email: email, password: password)
            isLoading = false

            if authVM.isSignedIn {
                showMissions = true
            } else {
                alertMessage = authVM.loginErrorMessage ?? ""
                showAlert = true
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let authVM = AuthorizationVM()
        let missionsVM = MissionsVM()
        SignInView()
            .environmentObject(authVM)
            .environmentObject(missionsVM)
    }
}
