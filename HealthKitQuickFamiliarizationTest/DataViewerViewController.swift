//
//  DataViewerViewController.swift
//  HealthKitQuickFamiliarizationTest
//
//  Created by Glenn Posadas on 10/19/20.
//

import HealthKit
import UIKit

class DataViewerViewController: UITableViewController {
    
    // MARK: - Properties
    
    private enum ProfileSection: Int {
        case ageSexBloodType
        case weightHeightBMI
        case readHealthKitData
        case saveBMI
    }
    
    private enum ProfileDataError: Error {
        
        case missingBodyMassIndex
        
        var localizedDescription: String {
            switch self {
            case .missingBodyMassIndex:
                return "Unable to calculate body mass index with available profile data."
            }
        }
    }
    
    @IBOutlet private var ageLabel:UILabel!
    @IBOutlet private var bloodTypeLabel:UILabel!
    @IBOutlet private var biologicalSexLabel:UILabel!
    @IBOutlet private var weightLabel:UILabel!
    @IBOutlet private var heightLabel:UILabel!
    @IBOutlet private var bodyMassIndexLabel:UILabel!
    
    private let userHealthProfile = UserHealthProfile()
    
    // MARK: - Overrides
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadAndDisplayAllInfo()
    }
    
    private func loadAndDisplayAllInfo() {
        self.loadAndDisplayAgeSexAndBloodType()
        self.loadAndDisplayMostRecentWeight()
        self.loadAndDisplayMostRecentHeight()
    }
    
    private func loadAndDisplayAgeSexAndBloodType() {
        do {
            let userAgeSexAndBloodType = try ProfileDataStore.getAgeSexAndBloodType()
            userHealthProfile.age = userAgeSexAndBloodType.age
            userHealthProfile.sex = userAgeSexAndBloodType.sex
            userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
            updateLabels()
        } catch let error {
            self.showAlert(message: error.localizedDescription)
        }
    }
    
    private func updateLabels() {
        
        if let age = userHealthProfile.age {
            ageLabel.text = "\(age)"
        }
        
        if let sex = userHealthProfile.sex {
            biologicalSexLabel.text = sex.stringRepresentation
        }
        
        if let bloodType = userHealthProfile.bloodType {
            bloodTypeLabel.text = bloodType.stringRepresentation
        }
        
        if let weight = userHealthProfile.weightInKilograms {
            let weightFormatter = MassFormatter()
            weightFormatter.isForPersonMassUse = true
            weightLabel.text = weightFormatter.string(fromKilograms: weight)
        }
        
        if let height = userHealthProfile.heightInMeters {
            let heightFormatter = LengthFormatter()
            heightFormatter.isForPersonHeightUse = true
            heightLabel.text = heightFormatter.string(fromMeters: height)
        }
        
        if let bodyMassIndex = userHealthProfile.bodyMassIndex {
            bodyMassIndexLabel.text = String(format: "%.02f", bodyMassIndex)
        }
    }
    
    private func loadAndDisplayMostRecentHeight() {
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
            guard let sample = sample else {
                
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                }
                
                return
            }
            
            let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            self.userHealthProfile.heightInMeters = heightInMeters
            self.updateLabels()
        }
    }
    
    private func loadAndDisplayMostRecentWeight() {
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Body Mass Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                }
                return
            }
            
            let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.userHealthProfile.weightInKilograms = weightInKilograms
            self.updateLabels()
        }
    }
}
