//
//  EmptyStateScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct EmptyStateView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var showAddMissionScreen: Bool

    // MARK: - UI

    var body: some View {
        VStack(spacing: 16) {
            Text(NinjaConstants.Strings.noMissionsYet.value)
                .font(.title2)
                .foregroundColor(.gray)

            Button(action: {
                showAddMissionScreen = true
            }) {
                Text(NinjaConstants.Strings.addFirstMission.value)
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
            .padding(24)
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        @State var showAddMissionScreen = false
        EmptyStateView(showAddMissionScreen: $showAddMissionScreen)
    }
}
