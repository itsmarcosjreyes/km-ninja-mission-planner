//
//  ForgotPasswordScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var authVM: AuthorizationVM

    @State private var email: String = ""
    // we are not really using these States below but I'm leaving them in case you want to try wiring them to an actual service
    @State private var isLoading: Bool = false
    @State private var showAlert = false
    @State private var alertMessage: String = ""

    // MARK: - UI

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(NinjaConstants.Strings.areYouASpy.value)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                }

                Spacer()
                    .frame(height: 24)

                VStack(alignment: .leading, spacing: 10) {
                    Text(NinjaConstants.Strings.ifNotEnterEmailAddress.value)
                        .font(.headline)
                        .padding(.leading)
                        .foregroundColor(colorScheme == .dark ? Color.white : NinjaConstants.Colors.gray.color())

                    TextField(NinjaConstants.Strings.email.value, text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Capsule().strokeBorder(NinjaConstants.Colors.kineticMatrixOrange.color(), lineWidth: 1))

                }

                Spacer()
                    .frame(height: 14)
            }
            .padding(24)

            Button(action: {
                showAlert = true
            }) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: NinjaConstants.Colors.kineticMatrixOrange.color()))
                        .frame(maxWidth: .infinity)
                } else {
                    Text(NinjaConstants.Strings.resetPassword.value)
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
            .padding(24)
            .alert(NinjaConstants.Strings.passwordRecoveryNotAvailable.value, isPresented: $showAlert) {
                Button(NinjaConstants.Strings.gotIt.value, role: .cancel) {
                    dismiss()
                }
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(NinjaConstants.Images.backIcon.name)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 32)
                }
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
