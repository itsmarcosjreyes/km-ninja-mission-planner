//
//  RippleCircle.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct RippleCircle: View {
    let color: Color
    @Binding var animate: Bool

    var body: some View {
        Circle()
            .stroke(color.opacity(0.8), lineWidth: 1)
            .scaleEffect(animate ? 1.6 : 1.0)
            .opacity(animate ? 0 : 1)
            .animation(.easeOut(duration: 0.4), value: animate)
    }
}
