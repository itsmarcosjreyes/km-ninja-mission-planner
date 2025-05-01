//
//  MissionsVM.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

/// 🗂️ The MissionsVM is your personal mission scroll manager.
/// It handles adding, updating, deleting, and organizing missions for your aspiring ninja.
/// Think of it as your mission HQ — tracking your progress across personal growth, learning, work, and fitness arcs.
final class MissionsVM: ObservableObject {

    /// The full list of current missions the user is tackling — active or completed.
    /// It's like the quest log in your favorite JRPG.
    /// From 'Properties' + 'Collections (Arrays)'
    @Published var missions: [Mission] = []

    /// A dictionary grouping missions by category — so personal quests don't mix with dojo training.
    @Published var groupedMissions: [String: [Mission]] = [:]

    /// When this view model awakens, it loads the default missions — every hero needs a starting arc.
    init() {
        loadDefaultMissions()
    }

    /// Adds a new mission to the list.
    ///
    /// - Parameter mission: The new mission (a.k.a. side quest) to be added to the user's journey.
    func addMission(_ mission: Mission) {
        /// From 'Functions' + 'Methods'
        missions.append(mission)
        regroup()
    }

    /// Deletes a mission (with honor).
    ///
    /// - Parameter mission: The mission to be removed from the scroll.
    func deleteMission(_ mission: Mission) {
        missions.removeAll { $0.id == mission.id }
        regroup()
    }

    /// Toggles a mission’s completion status.
    ///
    /// - Parameter mission: The mission that just gained or lost a green checkmark of glory.
    func toggleDone(_ mission: Mission) {
        /// From 'Control Flow' — flips mission state using logic.
        if let index = missions.firstIndex(where: { $0.id == mission.id }) {
            missions[index].isDone.toggle()
            regroup()
        }
    }

    /// Updates an existing mission’s name, category, or progress.
    ///
    /// - Parameter updated: The upgraded version of the mission. Think: Version 2.0 of the same quest.
    func updateMission(_ updated: Mission) {
        if let index = missions.firstIndex(where: { $0.id == updated.id }) {
            missions[index] = updated
            regroup()
        }
    }

    /// Resets all missions to their mystical defaults.
    /// Perfect for a new sign-up, a training reset, or a spiritual reawakening.
    func resetToDefault() {
        loadDefaultMissions()
    }

    /// Returns missions filtered by group and completion status.
    ///
    /// - Parameters:
    ///   - group: The category name (like `.learning`, `.fitness`, etc.).
    ///   - filter: Whether you want to see all missions, only completed, or pending ones.
    /// - Returns: The filtered slice of the mission scroll.
    func missions(for group: String, filter: MissionFilter) -> [Mission] {
        /// From 'Functions' + 'Control Flow' — filtering using logic and switch.
        let missionsInGroup = groupedMissions[group] ?? []
        switch filter {
        case .all:
            return missionsInGroup
        case .completed:
            return missionsInGroup.filter { $0.isDone }
        case .pending:
            return missionsInGroup.filter { !$0.isDone }
        }
    }

    /// Re-groups missions by category for clean, scroll-style organization.
    private func regroup() {
        /// From 'Functions' + 'Dictionaries' — group missions by category.
        groupedMissions = Dictionary(grouping: missions, by: { $0.category.rawValue })
    }

    /// Loads the default starter quests for a fresh ninja.
    /// This is the beginning of every great anime opening sequence — filled with ambition and potential.
    private func loadDefaultMissions() {
        missions = [
            // Personal Projects
            Mission(name: "Launch my first app 🚀", category: .personalProjects),
            Mission(name: "Start a YouTube coding vlog 🎥", category: .personalProjects),
            Mission(name: "Build a portfolio site 💻", category: .personalProjects),
            Mission(name: "Start a blog about Swift 📝", category: .personalProjects),

            // Learning
            Mission(name: "Finish the Swift course 🧠", category: .learning),
            Mission(name: "Build a Swift demo app 🧪", category: .learning),
            Mission(name: "Watch a WWDC session 🎥", category: .learning),

            // Work
            Mission(name: "Automate a repetitive task ⚙️", category: .work),
            Mission(name: "Refactor legacy code ✨", category: .work),
            Mission(name: "Introduce a new tool to my team 🛠️", category: .work),

            // Fitness
            Mission(name: "Do 20 push-ups a day 💪", category: .fitness),
            Mission(name: "Take a 30-min walk daily 🚶‍♂️", category: .fitness),
            Mission(name: "Try a new sport or workout 🏓", category: .fitness)
        ]

        regroup()
    }
}
