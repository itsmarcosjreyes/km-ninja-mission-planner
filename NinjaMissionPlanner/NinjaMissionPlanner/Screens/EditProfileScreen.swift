//
//  EditProfileScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct EditProfileScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var authVM: AuthorizationVM

    @State private var tempName: String = ""
    @State private var tempAvatar: String = ""
    @State private var avatarScale: CGFloat = 1.0
    @State private var rippleEffect = false

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

                Spacer(minLength: 20)

                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(NinjaConstants.Strings.editProfile.value)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(NinjaConstants.Strings.yourProfile.value)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }

                Spacer().frame(height: 20)

                // Username field
                TextField(NinjaConstants.Strings.ninjaAlias.value, text: $tempName)
                    .autocapitalization(.none)
                    .padding()
                    .background(Capsule().strokeBorder(NinjaConstants.Colors.kineticMatrixOrange.color(), lineWidth: 1))

                Spacer().frame(height: 14)

                // Choose avatar
                VStack(alignment: .leading, spacing: 10) {
                    Text(NinjaConstants.Strings.chooseAvatar.value)
                        .font(.headline)
                        .padding(.leading)
                        .foregroundColor(colorScheme == .dark ? Color.white : NinjaConstants.Colors.gray.color())

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(avatars, id: \.self) { avatar in
                            Button(action: {
                                tempAvatar = avatar

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
                                    if tempAvatar == avatar {
                                        RippleCircle(color: NinjaConstants.Colors.kineticMatrixOrange.color(), animate: $rippleEffect)
                                            .frame(width: 80, height: 80)
                                    }

                                    Text(avatar)
                                        .font(.largeTitle)
                                        .scaleEffect(tempAvatar == avatar ? avatarScale : 1.0)
                                        .frame(width: 80, height: 80)
                                        .background(tempAvatar == avatar ? NinjaConstants.Colors.kineticMatrixOrange.color().opacity(0.3) : Color.clear)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(NinjaConstants.Colors.kineticMatrixOrange.color(), lineWidth: 1))
                                }
                            }
                        }
                    }
                }

                Spacer().frame(height: 14)

                Button(action: {
                    authVM.updateProfile(name: tempName, avatar: tempAvatar)
                    dismiss()
                }) {
                    Text(NinjaConstants.Strings.save.value)
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
            .padding(24)
            .onAppear {
                tempName = authVM.userName
                tempAvatar = authVM.userAvatar
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        let authVM = AuthorizationVM()
        let missionsVM = MissionsVM()
        EditProfileScreen()
            .environmentObject(authVM)
            .environmentObject(missionsVM)
    }
}
