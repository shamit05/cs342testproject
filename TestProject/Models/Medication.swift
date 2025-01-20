//
//  Medication.swift
//  TestProject
//
//  Created by Shamit Surana on 1/9/25.
//

import Foundation

enum Route: String, CaseIterable {
    case byMouth
    case subcutaneously
    case inhaled
}

// Represents a medication prescribed to a patient
struct Medication: CustomStringConvertible {
    let datePrescribed: Date
    let name: String
    let dose: Float // mg
    let route: Route
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
    
    // Bonus function - calculate number of remaining days for the medication.
    // Returns 0 if the course has already been completed.
    func remainingDays() -> Int {
        let endDate = Calendar.current.date(byAdding: .day, value: duration, to: datePrescribed) ?? Date()
        let remaining = Calendar.current.dateComponents([.day], from: Date(), to: endDate).day ?? 0
        return max(0, remaining)
    }
}
