//
//  CloseIconImage.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//

import SwiftUI

struct CloseIconImage: View {
    var body: some View {
        Image(NinjaConstants.Images.closeIcon.name)
            .resizable()
            .scaledToFit()
            .frame(height: 28)
            .tint(Color.white)
    }
}
