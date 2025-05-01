//
//  AuraEffect.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct AuraEffect: ViewModifier {
    @State private var pulse = false
    @AppStorage(NinjaConstants.AppStorage.ninjaAuraEnabled.key) private var ninjaAura: Bool = true
    private let duration: Double = 3.0

    func body(content: Content) -> some View {
        if ninjaAura {
            return AnyView(
                ZStack {
                    content
                        .blur(radius: pulse ? 10 : 0)
                        .animation(.easeOut(duration: duration).repeatForever(), value: pulse)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                pulse.toggle()
                            }
                        }
                    content
                }
            )
        } else {
            return AnyView(content)
        }
    }
}
