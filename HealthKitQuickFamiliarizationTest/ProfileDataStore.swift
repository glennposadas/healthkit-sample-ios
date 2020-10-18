//
//  ProfileDataStore.swift
//  HealthKitQuickFamiliarizationTest
//
//  Created by Glenn Posadas on 10/19/20.
//

import Foundation
import HealthKit

class ProfileDataStore {
    private init() { }
    
    class func getAgeSexAndBloodType() throws -> (age: Int,
                                                  sex: HKBiologicalSex,
                                                  bloodType: HKBloodType) {
        let hkStore = HKHealthStore()
        
        do {
            let birthdayComponents =  try hkStore.dateOfBirthComponents()
            let biologicalSex = try hkStore.biologicalSex()
            let bloodType = try hkStore.bloodType()
              
            let today = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year],
                                                                from: today)
            let thisYear = todayDateComponents.year!
            let age = thisYear - birthdayComponents.year!
             
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            let unwrappedBloodType = bloodType.bloodType
              
            return (age, unwrappedBiologicalSex, unwrappedBloodType)
        }
    }
    
    
}
