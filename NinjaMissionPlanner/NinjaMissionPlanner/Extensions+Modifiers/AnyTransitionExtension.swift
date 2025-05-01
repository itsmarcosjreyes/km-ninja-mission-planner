//
//  AnyTransitionExtension.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

/// Don't worry about Extensions right now. I will show you secrets about them in a separate, small and concise post.
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .move(edge: .top)),
            removal: .opacity.combined(with: .move(edge: .bottom))
        )
    }

    static var smoothTooltip: AnyTransition {
        .opacity.combined(with: .move(edge: .top))
    }
}
