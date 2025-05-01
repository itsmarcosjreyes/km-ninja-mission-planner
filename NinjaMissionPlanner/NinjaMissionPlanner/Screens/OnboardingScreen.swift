//
//  OnboardingScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var authVM: AuthorizationVM

    @AppStorage(NinjaConstants.AppStorage.ninjasJumpingEnabled.key) private var ninjasJumping: Bool = true

    @State private var powerFxEnable = true
    @State private var ninja1Visible = false
    @State private var ninja2Visible = false
    @State private var showingSignUp = false
    @State private var showingSignIn = false

    // MARK: - UI

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if authVM.isSignedIn {
                    MissionsScreen()
                } else {
                    VStack {
                        Spacer()

                        Image(NinjaConstants.Images.nmpLogo.name)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)

                        Spacer()

                        Button(action: {
                            showingSignUp.toggle()
                        }) {
                            Text(NinjaConstants.Strings.iWantAccess.value)
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
                        .padding()
                        .sheet(isPresented: $showingSignUp) {
                            SignUpView()
                                .environmentObject(authVM)
                        }

                        Button(action: {
                            showingSignIn.toggle()
                        }) {
                            Text(NinjaConstants.Strings.iAlreadyHaveDojoAccess.value)
                                .font(.headline)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        }
                        .sheet(isPresented: $showingSignIn) {
                            SignInView()
                        }

                        Spacer()

                        Text(NinjaConstants.Strings.kineticMatrixFooter.value)
                            .font(.footnote)
                            .foregroundColor(NinjaConstants.Colors.kineticMatrixOrange.color())
                    }
                    .padding()
                }

                if ninjasJumping {
                    Image(NinjaConstants.Images.ninjaTop.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .opacity(ninja1Visible ? 1 : 0)
                        .offset(y: ninja1Visible ? -geometry.size.height / 2 + 5 : -geometry.size.height)
                        .animation(.easeInOut(duration: 1.0), value: ninja1Visible)
                        .onAppear {
                            startNinja1Animation()
                        }
                }

                if ninjasJumping {
                    Image(NinjaConstants.Images.ninjaBottom.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .opacity(ninja2Visible ? 1 : 0)
                        .offset(x: 100, y: ninja2Visible ? geometry.size.height / 2 - 20 : geometry.size.height)
                        .animation(.easeInOut(duration: 1.0), value: ninja2Visible)
                        .onAppear {
                            startNinja2Animation()
                        }
                }
            }
        }
    }

    // MARK: - Logic

    private func startNinja1Animation() {
        animateNinjaWithRandomInterval {
            withAnimation(.easeInOut(duration: 1.0)) {
                ninja1Visible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Stay visible for 2 seconds
                withAnimation(.easeInOut(duration: 1.0)) {
                    ninja1Visible = false
                }
            }
        }
    }

    private func startNinja2Animation() {
        animateNinjaWithRandomInterval {
            withAnimation(.easeInOut(duration: 1.0)) {
                ninja2Visible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Immediately go back to hiding
                withAnimation(.easeInOut(duration: 1.0)) {
                    ninja2Visible = false
                }
            }
        }
    }

    /// Helper function to animate with random intervals
    private func animateNinjaWithRandomInterval(action: @escaping () -> Void) {
        let interval = Double.random(in: 3...8)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            action()
            animateNinjaWithRandomInterval(action: action)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        let authVM = AuthorizationVM()
        let missionsVM = MissionsVM()
        OnboardingView()
            .environmentObject(authVM)
            .environmentObject(missionsVM)
    }
}
