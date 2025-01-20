//
//  PatientError.swift
//  TestProject
//
//  Created by Shamit Surana on 1/16/25.
//

enum PatientError: Error, CustomStringConvertible {
    case futureDateOfBirth
    case duplicateMedicine

    var description: String {
        switch self {
        case .futureDateOfBirth:
            return "Date of birth cannot be in the future."
        case .duplicateMedicine:
            return "Duplicate medicine found."
        }
    
    }
}
