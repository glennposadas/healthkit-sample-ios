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
    
    class func getMostRecentSample(for sampleType: HKSampleType,
                                   completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            guard let samples = samples,
                  let mostRecentSample = samples.first as? HKQuantitySample else {
                
                completion(nil, error)
                return
            }
            
            completion(mostRecentSample, nil)
        }
        
        HKHealthStore().execute(sampleQuery)
    }
}
