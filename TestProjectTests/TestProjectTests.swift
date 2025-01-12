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
    func patientInitializationAndFullName() {
        let patient = Patient(firstName: "Shamit", lastName: "Surana", dateOfBirth: Date(timeIntervalSinceReferenceDate: 0), height: 180, weight: 75)
        #expect(patient.firstName == "Shamit")
        #expect(patient.lastName == "Surana")
        #expect(patient.age == 24)
        #expect(patient.description == "Surana, Shamit (24 years old)")
    }

    @Test("Add medication to patient test")
    func addMedicationTest() {
        let patient = Patient(firstName: "Shamit", lastName: "Surana", dateOfBirth: Date(), height: 165, weight: 65)
        let medication = Medication(datePrescribed: Date(), name: "Aspirin", dose: "81 mg", route: "by mouth", frequency: 1, duration: 90)

        #expect({
            do {
                try patient.addMedication(medication)
                return patient.activeMedications().count == 1
            } catch {
                return false
            }
        }() == true)
    }

    @Test("Prevent duplicate medication test")
    func preventDuplicateMedicationTest() {
        let patient = Patient(firstName: "Shamit", lastName: "Surana", dateOfBirth: Date(), height: 165, weight: 65)
        let medication = Medication(datePrescribed: Date(), name: "Aspirin", dose: "81 mg", route: "by mouth", frequency: 1, duration: 90)

        #expect({
            do {
                try patient.addMedication(medication)
                try patient.addMedication(medication)
                return false
            } catch {
                return true
            }
        }() == true)
    }

    @Test("Blood type compatibility test")
    func bloodTypeCompatibilityTest() {
        let patient = Patient(firstName: "John", lastName: "Doe", dateOfBirth: Date(), height: 180, weight: 75, bloodType: .ABPlus)
        #expect(patient.compatibleBloodTypes().count == BloodType.allCases.count)
    }
    
    @Test("Remaining days calculation test")
       func remainingDaysTest() {
           let today = Date()

           // Create a medication prescribed today with a duration of 10 days
           let medication = Medication(
               datePrescribed: today,
               name: "Aspirin",
               dose: "81 mg",
               route: "by mouth",
               frequency: 1,
               duration: 10
           )

           // Expect remaining days to be 9 initially
           #expect(medication.remainingDays() == 9)
       }
}
