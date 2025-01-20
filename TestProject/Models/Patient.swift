//
//  Patient.swift
//  TestProject
//
//  Created by Shamit Surana on 1/9/25.
//

import Foundation
import Observation


// Patient representing a medical record of a patient
struct Patient: CustomStringConvertible, Identifiable {
    // Patient properties
    let id: UUID
    let medicalRecordNumber: UUID
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    var height: Int // Height in cm
    var weight: Int // Weight in g
    var bloodType: BloodType?

    // List of medications the patient has been prescribed
    var medications: [Medication]

    // Initializer for the Patient class
    init(
        firstName: String,
        lastName: String,
        dateOfBirth: Date,
        height: Int,
        weight: Int,
        bloodType: BloodType? = nil
    ) throws {
        // Validate that the date of birth is not in the future
        guard dateOfBirth <= Date() else {
            throw PatientError.futureDateOfBirth;
        }
        
        // Auto-generate unique medical record number
        self.id = UUID()
        self.medicalRecordNumber = UUID()

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
    mutating func addMedication(_ medication: Medication) throws {
        // Check if a duplicate active medication already exists
        if medications.contains(where: { $0.name == medication.name && !$0.isCompleted }) {
            throw PatientError.duplicateMedicine
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
}

@Observable
class PatientManager {
    var patients: [Patient] = []
    
    init() {
        do {
           patients = [
                try Patient(firstName: "John", lastName: "Doe", dateOfBirth: Date(), height: 180, weight: 75000, bloodType: .oPlus),
                try Patient(firstName: "Jane", lastName: "Smith", dateOfBirth: Date(), height: 165, weight: 65000, bloodType: .aMinus)
            ]
        } catch {
            patients = []
        }
    }
}
