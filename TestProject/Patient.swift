//
//  Patient.swift
//  TestProject
//
//  Created by Shamit Surana on 1/9/25.
//

import Foundation

// Patient class representing a medical record of a patient
class Patient: CustomStringConvertible {
    // Static property tracks medical record numbers
    private static var currentRecordNumber = 0

    // Patient properties
    let medicalRecordNumber: Int
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    var height: Double // Height in cm
    var weight: Double // Weight in kg
    var bloodType: BloodType?

    // List of medications the patient has been prescribed
    private(set) var medications: [Medication]

    // Initializer for the Patient class
    init(
        firstName: String,
        lastName: String,
        dateOfBirth: Date,
        height: Double,
        weight: Double,
        bloodType: BloodType? = nil
    ) {
        // Auto-generate unique medical record number
        Self.currentRecordNumber += 1
        self.medicalRecordNumber = Self.currentRecordNumber

        // Assign properties
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = []
    }

    // Description of the patient in the format: "LastName, FirstName (Age years old)"
    var description: String {
        "\(lastName), \(firstName) (\(age) years old)"
    }

    // Computed property to calculate the patient's age in years
    var age: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
        return ageComponents.year ?? 0
    }

    // Add a medication to the patient's record
    func addMedication(_ medication: Medication) throws {
        // Check if a duplicate active medication already exists
        if medications.contains(where: { $0.name == medication.name && !$0.isCompleted }) {
            throw NSError(
                domain: "PatientError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Duplicate active medication."]
            )
        }
        // Add the new medication
        medications.append(medication)
    }

    // Get a list of active medications (not yet completed) - sort by date prescribed
    func activeMedications() -> [Medication] {
        medications
            .filter { !$0.isCompleted }
            .sorted(by: { $0.datePrescribed < $1.datePrescribed })
    }

    // Get a list of compatible blood types for transfusion
    func compatibleBloodTypes() -> [BloodType] {
        guard let bloodType = bloodType else { return [] }

        switch bloodType {
        case .OPlus: return [.OPlus, .OMinus]
        case .OMinus: return [.OMinus]
        case .APlus: return [.APlus, .AMinus, .OPlus, .OMinus]
        case .AMinus: return [.AMinus, .OMinus]
        case .BPlus: return [.BPlus, .BMinus, .OPlus, .OMinus]
        case .BMinus: return [.BMinus, .OMinus]
        case .ABPlus: return BloodType.allCases
        case .ABMinus: return [.ABMinus, .AMinus, .BMinus, .OMinus]
        }
    }
}
