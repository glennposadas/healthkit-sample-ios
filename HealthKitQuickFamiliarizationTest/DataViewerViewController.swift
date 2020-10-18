//
//  DataViewerViewController.swift
//  HealthKitQuickFamiliarizationTest
//
//  Created by Glenn Posadas on 10/19/20.
//

import UIKit

class DataViewerViewController: UIViewController {

    // MARK: - Properties
    
    var userHealthProfile: UserHeal
    
    // MARK: - Overrides
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
          let userAgeSexAndBloodType = try ProfileDataStore.getAgeSexAndBloodType()
          userHealthProfile.age = userAgeSexAndBloodType.age
          userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
          userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
          updateLabels()
        } catch let error {
          self.displayAlert(for: error)
        }
    }
}
