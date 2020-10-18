//
//  HKSetupAssistant.swift
//  HealthKitQuickFamiliarizationTest
//
//  Created by Glenn Posadas on 10/18/20.
//

import HealthKit
import Foundation

enum HealthkitSetupError: Error {
    case notAvailable
    case dataTypeNotAvailable
}

extension HealthkitSetupError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notAvailable:
            return NSLocalizedString("Not available", comment: "Not available")
        case .dataTypeNotAvailable:
            return NSLocalizedString("Data types are not available", comment: "Data types are not available")
        }
    }
}
