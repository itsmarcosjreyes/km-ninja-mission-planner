//
//  MissionFilter.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//

/// 🌀 Filters used to slice and dice missions — based on their completion state.
/// Every ninja scroll needs a way to focus: show all, only completed, or the pending stuff that haunts you.
enum MissionFilter: String, CaseIterable, Identifiable {
    /// From 'Enumerations' + 'CaseIterable' + 'Protocols'

    /// Show me everything — the full scroll.
    case all

    /// Only missions that are complete — for that sweet feeling of progress.
    case completed

    /// Just the missions that still need doing — aka, your current grind.
    case pending

    /// Used in SwiftUI views for looping through the filters.
    var id: String { rawValue }

    /// Human-readable label to show in UI — pulled from the constants scroll.
    var displayName: String {
        switch self {
        case .all: return NinjaConstants.MissionFilter.all.value
        case .completed: return NinjaConstants.MissionFilter.completed.value
        case .pending: return NinjaConstants.MissionFilter.pending.value
        }
    }

    /// Icon associated with each filter — used to decorate the UI with visual cues.
    /// From 'Computed Properties' + 'Control Flow (Switch)'
    var iconName: String {
        switch self {
        case .all:
            return NinjaConstants.Images.filterInactiveIcon.name
        case .completed, .pending:
            return NinjaConstants.Images.filterActiveIcon.name
        }
    }
}
