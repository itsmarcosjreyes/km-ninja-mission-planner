//
//  EditMissionScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct EditMissionScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var onSave: (Mission) -> Void
    var onDelete: (Mission) -> Void

    @State private var mission: Mission
    @State private var showDeleteAlert: Bool = false
    @FocusState private var isNameFocused: Bool

    // MARK: - Initializers

    init(mission: Mission, onSave: @escaping (Mission) -> Void, onDelete: @escaping (Mission) -> Void) {
        self._mission = State(initialValue: mission)
        self.onSave = onSave
        self.onDelete = onDelete
    }

    // MARK: - UI

    var body: some View {
        NavigationStack {
            ZStack {
                (colorScheme == .dark ? Color.black : Color.white)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Form {
                        Section(header: Text(NinjaConstants.Strings.missionDetails.value)) {
                            TextField(NinjaConstants.Strings.missionName.value, text: $mission.name)
                                .focused($isNameFocused)

                            Picker(NinjaConstants.Strings.group.value.capitalized, selection: $mission.category) {
                                ForEach(MissionCategory.allCases) { category in
                                    Text(category.displayName).tag(category)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)

                    VStack(spacing: 12) {
                        Button(action: {
                            mission.isDone.toggle()
                            onSave(mission)
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: mission.isDone ? NinjaConstants.Images.returnIcon.name : NinjaConstants.Images.checkmarkFilledIcon.name)
                                Text(mission.isDone ? NinjaConstants.Strings.markAsNotDone.value : NinjaConstants.Strings.missionCompleted.value)
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(mission.isDone ? NinjaConstants.Colors.kineticMatrixOrange.color() : NinjaConstants.Colors.green.color())
                            .clipShape(Capsule())
                        }

                        Button(action: {
                            onSave(mission)
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
                                        lineWidth: 3.0
                                    )
                                    .auraEffect()
                                )
                                .shadow(color: NinjaConstants.Colors.kineticMatrixOrange.color().opacity(0.5), radius: 10, x: 0, y: 0)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                }
            }
            .navigationTitle(NinjaConstants.Strings.editMission.value)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showDeleteAlert = true
                    }) {
                        Image(systemName: NinjaConstants.Images.trashIcon.name)
                            .font(.title2)
                            .foregroundColor(NinjaConstants.Colors.kineticMatrixOrange.color())
                    }
                }

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
            .alert(NinjaConstants.Strings.deleteNinjaMission.value, isPresented: $showDeleteAlert) {
                /// From 'Closures' + 'Control Flow' + 'Methods'
                Button(NinjaConstants.Strings.delete.value.capitalized, role: .destructive) {
                    onDelete(mission)
                    dismiss()
                }
                Button(NinjaConstants.Strings.cancel.value.capitalized, role: .cancel) { }
            } message: {
                Text(NinjaConstants.Strings.actionCannotBeUndone.value)
            }
        }
    }
}

struct EditMissionScreen_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMission = Mission(name: "Sample Mission", category: MissionCategory.personalProjects)
        EditMissionScreen(mission: sampleMission, onSave: {_ in }, onDelete: {_ in })
    }
}
