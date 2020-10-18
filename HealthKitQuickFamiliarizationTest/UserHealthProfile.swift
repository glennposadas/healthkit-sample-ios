//
//  UserHealthProfile.swift
//  HealthKitQuickFamiliarizationTest
//
//  Created by Glenn Posadas on 10/19/20.
//

import Foundation
import HealthKit

class UserHealthProfile {
    
    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?
    var heightInMeters: Double?
    var weightInKilograms: Double?
    
    var bodyMassIndex: Double? {
        
        guard let weightInKilograms = weightInKilograms,
              let heightInMeters = heightInMeters,
              heightInMeters > 0 else {
            return nil
        }
        
        return (weightInKilograms/(heightInMeters*heightInMeters))
    }
}
