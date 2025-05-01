//
//  FilterOptionButton.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct FilterOptionButton: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(NinjaConstants.Colors.kineticMatrixOrange.color())
        }
    }
}
