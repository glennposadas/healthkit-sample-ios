//
//  HKSetupAssistant.swift
//  HealthKitQuickFamiliarizationTest
//
//  Created by Glenn Posadas on 10/18/20.
//

import Foundation
import HealthKit

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

class HKSetupAssistant {
    private init() { }
    
    class func authorizeHK(completion: @escaping (Bool, Error?) -> ()) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("False, Not available")
            completion(false, HealthkitSetupError.notAvailable)
            return
        }
        
        guard let dob = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
              let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
              let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
              let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
              let height = HKObjectType.quantityType(forIdentifier: .height),
              let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
              let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
              let sleep = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            
            print("False, DATA TYPE Not available")
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,
                                                        activeEnergy,
                                                        HKObjectType.workoutType()]
            
        let healthKitTypesToRead: Set<HKObjectType> = [dob,
                                                       bloodType,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,
                                                       bodyMass,
                                                       sleep,
                                                       HKObjectType.workoutType()]
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                             read: healthKitTypesToRead) { (success, error) in
            print("\(success), Error: \(String(describing: error?.localizedDescription))")
            completion(success, error)
        }
    }
}
