//
//  MissionsVMTests.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import XCTest
@testable import NinjaMissionPlanner

final class MissionsVMTests: XCTestCase {
    var vm: MissionsVM!

    override func setUp() {
        super.setUp()
        vm = MissionsVM()
    }

    func testDefaultMissionsAreLoaded() {
        XCTAssertFalse(vm.missions.isEmpty)
        XCTAssertEqual(vm.groupedMissions[MissionCategory.personalProjects.rawValue]?.count, 4)
        XCTAssertEqual(vm.groupedMissions[MissionCategory.learning.rawValue]?.count, 3)
        XCTAssertEqual(vm.groupedMissions[MissionCategory.work.rawValue]?.count, 3)
        XCTAssertEqual(vm.groupedMissions[MissionCategory.fitness.rawValue]?.count, 3)
    }

    func testAddMission() {
        let mission = Mission(name: "Test", category: .learning)
        vm.addMission(mission)
        XCTAssertTrue(vm.missions.contains(where: { $0.id == mission.id }))
    }

    func testDeleteMission() {
        let mission = vm.missions.first!
        vm.deleteMission(mission)
        XCTAssertFalse(vm.missions.contains(where: { $0.id == mission.id }))
    }

    func testToggleDone() {
        let mission = vm.missions.first!
        let original = mission.isDone
        vm.toggleDone(mission)
        let updated = vm.missions.first { $0.id == mission.id }
        XCTAssertNotEqual(original, updated?.isDone)
    }

    func testUpdateMission() {
        var mission = vm.missions.first!
        mission.name = "Updated Mission"
        vm.updateMission(mission)
        let updated = vm.missions.first { $0.id == mission.id }
        XCTAssertEqual(updated?.name, "Updated Mission")
    }

    func testResetToDefault() {
        vm.missions.removeAll()
        vm.resetToDefault()
        XCTAssertFalse(vm.missions.isEmpty)
    }
}
