//
//  MissionCategory.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

/// 📚 Categories that group missions — the different paths in your personal development anime arc.
/// Think of these as elemental affinities: some ninjas train physically, others mentally, some in secret side projects.
enum MissionCategory: String, CaseIterable, Identifiable {
    /// From 'Basic Enumerations' + 'Custom Types'

    /// Physical growth and well-being — the chakra control and endurance training arc.
    case fitness = "fitness"

    /// Mental training and knowledge quests — leveling up your developer IQ like a shonen student.
    case learning = "learning"

    /// Personal or passion projects — the side quests that turn into the main storyline.
    case personalProjects = "personal projects"

    /// Missions from the workplace — where you secretly refine your jutsu in broad daylight.
    case work = "work"

    /// The ID required for iterating through categories in SwiftUI views.
    var id: String { rawValue }

    /// A human-friendly label for each category — used in UI scrolls and headers.
    /// From 'Computed Properties' + 'Switch Statements'
    var displayName: String {
        switch self {
        case .personalProjects: return "Personal Projects"
        case .learning: return "Learning"
        case .work: return "Work"
        case .fitness: return "Fitness"
        }
    }

    /// Each category gets a chakra color — purely aesthetic, but very ninja-approved.
    var color: Color {
        switch self {
        case .personalProjects: return .green
        case .learning: return .orange
        case .work: return .purple
        case .fitness: return .yellow
        }
    }
}
