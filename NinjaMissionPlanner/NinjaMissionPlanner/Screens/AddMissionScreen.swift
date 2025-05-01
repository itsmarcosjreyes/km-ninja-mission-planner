//
//  AddMissionScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct AddMissionScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var onAdd: (Mission) -> Void

    @State private var missionName: String = ""
    @State private var missionGroup: MissionCategory = .personalProjects
    @FocusState private var isNameFocused: Bool

    // MARK: - UI

    var body: some View {
        NavigationStack {
            ZStack {
                (colorScheme == .dark ? Color.black : Color.white)
                    .ignoresSafeArea()

                VStack {
                    Form {
                        Section(header: Text(NinjaConstants.Strings.missionDetails.value)) {
                            TextField(NinjaConstants.Strings.missionName.value, text: $missionName)
                                .focused($isNameFocused)

                            /// From 'Control Flow - Looping over Enums'
                            Picker(NinjaConstants.Strings.category.value, selection: $missionGroup) {
                                ForEach(MissionCategory.allCases) { category in
                                    Text(category.displayName).tag(category)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)

                    /// From 'Functions' + 'Closure Basics'
                    Button(action: {
                        if !missionName.isEmpty {
                            let newMission = Mission(name: missionName, category: missionGroup)
                            onAdd(newMission)
                            dismiss()
                        }
                    }) {
                        Text(NinjaConstants.Strings.addMission.value)
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
                }
            }
            .navigationTitle(NinjaConstants.Strings.addMission.value.capitalized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        CloseIconImage()
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    isNameFocused = true
                }
            }
        }
    }
}

struct AddMissionScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddMissionScreen(onAdd: {_ in })
    }
}
