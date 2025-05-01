//
//  GradientExtension.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

/// Don't worry about Extensions right now. I will show you secrets about them in a separate, small and concise post.
/// From 'Extensions'
extension Gradient {
    static let orangeYellowPurple: Gradient = .init(colors:
                                                        [NinjaConstants.Colors.kineticMatrixOrange.color(),
                                                         NinjaConstants.Colors.yellow.color(),
                                                         NinjaConstants.Colors.kineticMatrixMagenta.color(),]
    )
}
