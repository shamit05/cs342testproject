//
//  Medication.swift
//  TestProject
//
//  Created by Shamit Surana on 1/9/25.
//

import Foundation

// Represents a medication prescribed to a patient
struct Medication: CustomStringConvertible {
    let datePrescribed: Date
    let name: String
    let dose: String
    let route: String
    let frequency: Int
    let duration: Int

    // Example: "Aspirin 81 mg by mouth 1x/day for 90 days"
    var description: String {
        "\(name) \(dose) \(route) \(frequency)x/day for \(duration) days"
    }

    // Check if the medication's prescribed duration has been completed
    var isCompleted: Bool {
        let endDate = Calendar.current.date(byAdding: .day, value: duration, to: datePrescribed) ?? Date()
        return Date() > endDate
    }
}
