//
//  TestProjectTests.swift
//  TestProjectTests
//
//  Created by Shamit Surana on 1/9/25.
//

import Foundation
import Testing
@testable import TestProject

struct TestProjectTests {
    
    @Test("Patient initialization and full name test")
    func patientInitializationAndFullName() throws {
        let patient = try Patient(firstName: "Shamit", lastName: "Surana", dateOfBirth: Date(timeIntervalSinceReferenceDate: 0), height: 180, weight: 75)
        #expect(patient.firstName == "Shamit")
        #expect(patient.lastName == "Surana")
        #expect(patient.age == 24)
        #expect(patient.description == "Surana, Shamit (24 years old)")
    }

    @Test("Add medication to patient test")
    func addMedicationTest() throws {
        var patient = try Patient(firstName: "Shamit", lastName: "Surana", dateOfBirth: Date(), height: 165, weight: 65)
        let medication = Medication(datePrescribed: Date(), name: "Aspirin", dose: 81, route: Route.byMouth, frequency: 1, duration: 90)

        try patient.addMedication(medication)
        
        #expect(patient.activeMedications().count == 1)
    }

    @Test("Prevent duplicate medication test")
    func preventDuplicateMedicationTest() throws {
        var patient = try Patient(firstName: "Shamit", lastName: "Surana", dateOfBirth: Date(), height: 165, weight: 65)
        let medication = Medication(datePrescribed: Date(), name: "Aspirin", dose: 81, route: Route.byMouth, frequency: 1, duration: 90)

        #expect(throws: PatientError.duplicateMedicine) {
            try patient.addMedication(medication)
            try patient.addMedication(medication)
        }
        #expect(patient.activeMedications().count == 1)  // Ensure medication count remains 1 after the error
    }

    @Test("Blood type compatibility test for AB+")
    func bloodTypeCompatibilityABPlusTest() throws {
        let patient = try Patient(firstName: "John", lastName: "Doe", dateOfBirth: Date(), height: 180, weight: 75, bloodType: .aBPlus)
        
        #expect(patient.bloodType!.compatibleBloodTypes().count == BloodType.allCases.count)
    }

    @Test("Blood type compatibility test for A+")
    func bloodTypeCompatibilityAPlusTest() throws {
        let patient = try Patient(firstName: "Alice", lastName: "Smith", dateOfBirth: Date(), height: 170, weight: 60, bloodType: .aPlus)

        let compatibleBloodTypes = patient.bloodType!.compatibleBloodTypes()
        #expect(compatibleBloodTypes.contains(.aPlus))
        #expect(compatibleBloodTypes.contains(.aMinus))
        #expect(compatibleBloodTypes.contains(.oPlus))
        #expect(compatibleBloodTypes.contains(.oMinus))
    }

    @Test("Blood type compatibility test for O-")
    func bloodTypeCompatibilityOMinusTest() throws {
        let patient = try Patient(firstName: "David", lastName: "Johnson", dateOfBirth: Date(), height: 175, weight: 70, bloodType: .oMinus)

        let compatibleBloodTypes = patient.bloodType!.compatibleBloodTypes()
        #expect(compatibleBloodTypes.contains(.oMinus))
    }

    @Test("Blood type compatibility test for B-")
    func bloodTypeCompatibilityBMinusTest() throws {
        let patient = try Patient(firstName: "Emma", lastName: "Williams", dateOfBirth: Date(), height: 160, weight: 50, bloodType: .bMinus)

        let compatibleBloodTypes = patient.bloodType!.compatibleBloodTypes()
        #expect(compatibleBloodTypes.contains(.bMinus))
        #expect(compatibleBloodTypes.contains(.oMinus))
    }

    @Test("Blood type compatibility test for O+")
    func bloodTypeCompatibilityOPlusTest() throws {
        let patient = try Patient(firstName: "James", lastName: "Brown", dateOfBirth: Date(), height: 180, weight: 80, bloodType: .oPlus)

        let compatibleBloodTypes = patient.bloodType!.compatibleBloodTypes()
        #expect(compatibleBloodTypes.contains(.oPlus))
        #expect(compatibleBloodTypes.contains(.oMinus))
    }

    @Test("Remaining days calculation test")
    func remainingDaysTest() {
        let today = Date()

        // Create a medication prescribed today with a duration of 10 days
        let medication = Medication(
            datePrescribed: today,
            name: "Aspirin",
            dose: 81,
            route: Route.byMouth,
            frequency: 1,
            duration: 10
        )

        // Expect remaining days to be 9 initially
        #expect(medication.remainingDays() == 9)
    }
}
