//
//  SettingsScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct SettingsScreen: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authVM: AuthorizationVM
    @Environment(\.colorScheme) var colorScheme

    @AppStorage(NinjaConstants.AppStorage.ninjasJumpingEnabled.key) private var ninjasJumping: Bool = true
    @AppStorage(NinjaConstants.AppStorage.ninjaAuraEnabled.key) private var ninjaAura: Bool = true
    @State private var showLogoutAlert: Bool = false
    @State private var showTooltips: Bool = false
    @State private var showEditProfile = false

    // MARK: - UI

    var body: some View {
        NavigationStack {
            ZStack {
                (colorScheme == .dark ? Color.black : Color.white)
                    .ignoresSafeArea()

                VStack {
                    ScrollView {
                        VStack(spacing: 20) {
                            Section {
                                HStack(spacing: 16) {
                                    Text(authVM.userAvatar)
                                        .font(.system(size: 48))
                                    Text(authVM.userName)
                                        .font(.headline)
                                }
                                .padding(.top)
                                .onTapGesture {
                                    showEditProfile = true
                                }
                            }

                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text(NinjaConstants.Strings.effects.value.capitalized)
                                        .font(.headline)
                                    Spacer()
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            showTooltips.toggle()
                                        }
                                    } label: {
                                        Image(systemName: NinjaConstants.Images.helpIcon.name)
                                            .foregroundColor(.gray)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                                .padding(.top)

                                VStack(alignment: .leading, spacing: 4) {
                                    Toggle(NinjaConstants.Strings.ninjasJumping.value, isOn: $ninjasJumping)
                                        .tint(NinjaConstants.Colors.kineticMatrixOrange.color())
                                    if showTooltips {
                                        Text(NinjaConstants.Strings.showHideRandomNinjasMessage.value)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .transition(.opacity.combined(with: .move(edge: .top)))
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Toggle(NinjaConstants.Strings.ninjaAura.value, isOn: $ninjaAura)
                                        .tint(NinjaConstants.Colors.kineticMatrixOrange.color())
                                    if showTooltips {
                                        Text(NinjaConstants.Strings.showHideAuraMessage.value)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .transition(.opacity.combined(with: .move(edge: .top)))
                                    }
                                }
                            }
                            .padding(.horizontal)

                            Spacer()
                        }
                    }

                    VStack(spacing: 16) {
                        Button(action: {
                            showLogoutAlert = true
                        }) {
                            HStack {
                                Image(systemName: NinjaConstants.Images.logoutIcon.name)
                                Text(NinjaConstants.Strings.logout.value)
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .clipShape(Capsule())
                        }
                        .alert(NinjaConstants.Strings.logoutConfirmTitle.value, isPresented: $showLogoutAlert) {
                            Button(NinjaConstants.Strings.logoutAction.value, role: .destructive) {
                                authVM.signOut()
                                dismiss()
                            }
                            Button(NinjaConstants.Strings.cancel.value.capitalized, role: .cancel) { }
                        } message: {
                            Text(NinjaConstants.Strings.leaveDojoMessage.value)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                }
            }
            .navigationTitle(NinjaConstants.Strings.settings.value.capitalized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        CloseIconImage()
                    }
                }
            }
            .sheet(isPresented: $showEditProfile) {
                EditProfileScreen()
            }
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        let authVM = AuthorizationVM()
        let missionsVM = MissionsVM()
        SettingsScreen()
            .environmentObject(authVM)
            .environmentObject(missionsVM)
    }
}
