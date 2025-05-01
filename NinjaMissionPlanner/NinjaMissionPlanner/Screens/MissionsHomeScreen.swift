//
//  MissionsHomeScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//

import SwiftUI

struct MissionsScreen: View {
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var authVM: AuthorizationVM
    @EnvironmentObject var missionsVM: MissionsVM

    /// From 'Property Wrappers'
    @AppStorage(NinjaConstants.AppStorage.ninjasJumpingEnabled.key) private var ninjasJumping: Bool = true

    @State private var expandedGroups: Set<String> = []
    @State private var filter: MissionFilter = .all
    @State private var showFilterScreen = false
    @State private var showAddMissionScreen = false
    @State private var selectedMissionForEdit: Mission? = nil
    @State private var showDeleteAlert = false
    @State private var missionPendingDelete: Mission?
    @State private var showSettingsScreen = false
    @State private var ninja1Visible = false
    @State private var ninja2Visible = false

    var missions: [Mission] { missionsVM.missions }
    var groupedMissions: [String: [Mission]] { missionsVM.groupedMissions }

    // MARK: - UI

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        if missions.isEmpty {
                            Spacer()
                            EmptyStateView(showAddMissionScreen: $showAddMissionScreen)
                            Spacer()
                        } else {
                            header
                            missionList
                        }
                    }

                    if !missions.isEmpty {
                        addButton
                    }

                    if ninjasJumping {
                        topNinja(geometry: geometry)
                        bottomNinja(geometry: geometry)
                    }
                }
                .toolbar {
                    leadingToolbar
                    trailingToolbar
                }
                .sheet(isPresented: $showFilterScreen) {
                    FilterSelectionScreen(selectedFilter: $filter)
                }
                .sheet(isPresented: $showAddMissionScreen) {
                    AddMissionScreen { newMission in
                        missionsVM.addMission(newMission)
                    }
                }
                .sheet(item: $selectedMissionForEdit) { mission in
                    EditMissionScreen(
                        mission: mission,
                        onSave: { updated in updateMission(updated) },
                        onDelete: { toDelete in deleteMission(toDelete) }
                    )
                }
                .sheet(isPresented: $showSettingsScreen) {
                    SettingsScreen()
                }
                .alert(NinjaConstants.Strings.deleteNinjaMission.value, isPresented: $showDeleteAlert) {
                    Button(NinjaConstants.Strings.delete.value.capitalized, role: .destructive) {
                        if let mission = missionPendingDelete {
                            deleteMission(mission)
                            missionPendingDelete = nil
                        }
                    }
                    Button(NinjaConstants.Strings.cancel.value.capitalized, role: .cancel) {
                        missionPendingDelete = nil
                    }
                } message: {
                    Text(NinjaConstants.Strings.actionCannotBeUndone.value)
                }
                .background(colorScheme == .dark ? Color.black : Color.white)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(NinjaConstants.Strings.missions.value)
                .font(.largeTitle)
                .bold()

            if filter != .all {
                Text("(\(filter.displayName))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .transition(.moveAndFade)
                    .id(filter)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .animation(.easeInOut(duration: 0.3), value: filter)
    }

    private var missionList: some View {
        /// From 'Collections' + 'Loops'
        List {
            ForEach(MissionCategory.allCases) { category in
                MissionSectionView(
                    category: category,
                    isExpanded: expandedGroups.contains(category.rawValue),
                    missions: filteredMissions(for: category.rawValue),
                    onToggle: { toggleGroupExpansion(category.rawValue) },
                    onTap: { mission in
                        selectedMissionForEdit = mission
                    },
                    onMarkDone: markAsDone,
                    onDeleteRequest: { mission in
                        missionPendingDelete = mission  // Set the mission to confirm
                        showDeleteAlert = true          // Show the alert
                    }
                )
            }

            Section {
                Color.clear
                    .frame(height: 100)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
    }


    private var addButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showAddMissionScreen = true
                }) {
                    Image(NinjaConstants.Images.addIcon.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .padding()
                        .background(Circle().fill(Color.clear))
                        .overlay(
                            Capsule().stroke(
                                LinearGradient(
                                    gradient: Gradient.orangeYellowPurple,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 3.0
                            )
                            .auraEffect()
                        )
                }
                .padding([.trailing, .bottom], 20)
            }
        }
    }

    private func topNinja(geometry: GeometryProxy) -> some View {
        Image(NinjaConstants.Images.ninjaTop.name)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .opacity(ninja1Visible ? 1 : 0)
            .offset(x: 60, y: ninja1Visible ? -geometry.size.height / 2 + 5 : -geometry.size.height)
            .animation(.easeInOut(duration: 1.0), value: ninja1Visible)
            .onAppear { startNinja1Animation() }
    }

    private func bottomNinja(geometry: GeometryProxy) -> some View {
        Image(NinjaConstants.Images.ninjaBottom.name)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .opacity(ninja2Visible ? 1 : 0)
            .offset(x: -100, y: ninja2Visible ? geometry.size.height / 2 - 20 : geometry.size.height)
            .animation(.easeInOut(duration: 1.0), value: ninja2Visible)
            .onAppear { startNinja2Animation() }
    }

    private var leadingToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarLeading) {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showSettingsScreen = true
                }
            } label: {
                Image(systemName: NinjaConstants.Images.settingsIcon.name)
                    .font(.title2)
                    .foregroundColor(NinjaConstants.Colors.kineticMatrixOrange.color())
            }
        }
    }

    private var trailingToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showFilterScreen = true
                }
            } label: {
                Image(systemName: filter.iconName)
                    .font(.title2)
                    .foregroundColor(NinjaConstants.Colors.kineticMatrixOrange.color())
                    .transition(.scale.combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.3), value: filter)
            }
        }
    }

    // MARK: - Logic

    private func filteredMissions(for group: String) -> [Mission] {
        let groupMissions = groupedMissions[group] ?? []
        switch filter {
        case .completed:
            return groupMissions.filter { $0.isDone }
        case .pending:
            return groupMissions.filter { !$0.isDone }
        case .all:
            return groupMissions
        }
    }

    private func markAsDone(_ mission: Mission) {
        missionsVM.toggleDone(mission)
    }

    private func deleteMission(_ mission: Mission) {
        missionsVM.deleteMission(mission)
    }

    private func updateMission(_ updated: Mission) {
        missionsVM.updateMission(updated)
    }

    private func toggleGroupExpansion(_ group: String) {
        if expandedGroups.contains(group) {
            expandedGroups.remove(group)
        } else {
            expandedGroups.insert(group)
        }
    }

    private func startNinja1Animation() {
        animateNinjaWithRandomInterval {
            withAnimation(.easeInOut(duration: 1.0)) {
                ninja1Visible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    ninja2Visible = false
                }
            }
        }
    }

    private func animateNinjaWithRandomInterval(action: @escaping () -> Void) {
        let interval = Double.random(in: 3...7)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            action()
            animateNinjaWithRandomInterval(action: action)
        }
    }
}

struct MissionsScreen_Previews: PreviewProvider {
    static var previews: some View {
        let authVM = AuthorizationVM()
        let missionsVM = MissionsVM()
        MissionsScreen()
            .environmentObject(authVM)
            .environmentObject(missionsVM)
    }
}
