//
//  StringExtension.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import Foundation

/// Don't worry about Extensions right now. I will show you secrets about them in a separate, small and concise post.
extension String {
    var isValidEmail: Bool {
        let regex = #"^\S+@\S+\.\S+$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }

    var isValidPassword: Bool {
        return self.count > 2 && !self.contains(" ")
    }

    var isValidUsername: Bool {
        return !self.contains(" ")
    }
}
