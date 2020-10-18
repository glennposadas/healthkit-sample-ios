//
//  ViewController.swift
//  HealthKitQuickFamiliarizationTest
//
//  Created by Glenn Posadas on 10/18/20.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Overrides
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    // MARK: - IBActions
    
    @IBAction func authorizeHK(_ sender: Any) {
        HKSetupAssistant.authorizeHK { (authorized, error) in
            guard error == nil else {
                self.showAlert(message: error!.localizedDescription)
                return
            }
            
            if authorized {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showData", sender: nil)
                }
            }
        }
    }
}

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: nil)
        alert.addAction(ok)
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}
