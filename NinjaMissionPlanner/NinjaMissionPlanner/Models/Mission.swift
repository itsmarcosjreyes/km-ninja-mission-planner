//
//  Mission.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import Foundation

/// 🎯 A single mission the user takes on — like a mini-quest in your ninja journey.
/// Each one has a category (training path), completion status, and a unique ID scroll tied to it.
struct Mission: Identifiable, Equatable {
    /// From 'Structures' + 'Properties' + 'Custom Types'

    /// The sacred UUID scroll that identifies this mission across time and space.
    /// From 'Protocols - Identifiable'
    let id = UUID()

    /// The mission name or title — what this side quest is all about.
    var name: String

    /// The category this mission belongs to — like training, work, or creative projects.
    var category: MissionCategory

    /// Indicates if the mission has been completed.
    /// From 'Booleans' + 'Properties'
    var isDone: Bool = false

    /// A placeholder for missions that are past due. Not used yet, but might unlock future arc mechanics (like deadlines).
    var isPastDue: Bool = false
}
