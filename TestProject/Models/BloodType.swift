//
//  BloodType.swift
//  TestProject
//
//  Created by Shamit Surana on 1/9/25.
//

enum BloodType: String, CaseIterable {
    case aPlus = "A+"
    case aMinus = "A-"
    case bPlus = "B+"
    case bMinus = "B-"
    case oPlus = "O+"
    case oMinus = "O-"
    case aBPlus = "AB+"
    case aBMinus = "AB-"
    
    // Bonus - Get a list of compatible blood types for transfusion
    func compatibleBloodTypes() -> [BloodType] {
        switch self {
            case .oPlus: return [.oPlus, .oMinus]
            case .oMinus: return [.oMinus]
            case .aPlus: return [.aPlus, .aMinus, .oPlus, .oMinus]
            case .aMinus: return [.aMinus, .oMinus]
            case .bPlus: return [.bPlus, .bMinus, .oPlus, .oMinus]
            case .bMinus: return [.bMinus, .oMinus]
            case .aBPlus: return BloodType.allCases
            case .aBMinus: return [.aBMinus, .aMinus, .bMinus, .oMinus]
        }
    }
}

