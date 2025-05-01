//
//  AuthorizationVMTests.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import XCTest
@testable import NinjaMissionPlanner

final class AuthorizationVMTests: XCTestCase {
    var vm: AuthorizationVM!

    override func setUp() {
        super.setUp()
        // Clear test storage before each run
        let keys = [
            NinjaConstants.AppStorage.userName.key,
            NinjaConstants.AppStorage.userAvatar.key,
            NinjaConstants.AppStorage.authEmail.key,
            NinjaConstants.AppStorage.authPassword.key,
            NinjaConstants.AppStorage.isSignedIn.key
        ]
        keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
        vm = AuthorizationVM()
    }

    func testSignUpSuccess() {
        let success = vm.signUp(email: "test@email.com", password: "pass123", alias: "TestUser", avatar: "🥷")
        XCTAssertTrue(success)
        XCTAssertTrue(vm.isSignedIn)
        XCTAssertEqual(vm.userName, "TestUser")
        XCTAssertEqual(vm.userAvatar, "🥷")
    }

    func testSignUpWithDuplicateEmailFails() {
        _ = vm.signUp(email: "dupe@email.com", password: "abc", alias: "Dup", avatar: "🦉")
        let result = vm.signUp(email: "dupe@email.com", password: "xyz", alias: "Dup2", avatar: "🐱")
        XCTAssertFalse(result)
    }

    func testSignInSuccess() {
        _ = vm.signUp(email: "me@swift.com", password: "1234", alias: "Me", avatar: "⚡️")
        vm.signOut()
        vm.signIn(email: "me@swift.com", password: "1234")
        XCTAssertTrue(vm.isSignedIn)
    }

    func testSignInFailure() {
        vm.signIn(email: "wrong@email.com", password: "badpass")
        XCTAssertFalse(vm.isSignedIn)
        XCTAssertEqual(vm.loginErrorMessage, NinjaConstants.Strings.invalidCredentials.value)
    }

    func testForgotPasswordSignsOut() {
        _ = vm.signUp(email: "temp@x.com", password: "abc", alias: "Temp", avatar: "🍃")
        vm.forgotPassword()
        XCTAssertFalse(vm.isSignedIn)
        XCTAssertEqual(vm.loginErrorMessage, NinjaConstants.Strings.passwordRecoveryNotAvailable.value)
    }

    func testUpdateProfileChangesStoredData() {
        _ = vm.signUp(email: "x@x.com", password: "123", alias: "Old", avatar: "🐱")
        vm.updateProfile(name: "NewAlias", avatar: "🤖")
        XCTAssertEqual(vm.userName, "NewAlias")
        XCTAssertEqual(vm.userAvatar, "🤖")
    }
}
