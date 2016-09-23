//
//  ViewController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 13/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet fileprivate weak var stackView: UIStackView!
    
    @IBOutlet fileprivate weak var welcomeView: UIView!
    
    @IBOutlet fileprivate weak var helloLabel: UILabel!
    
    @IBOutlet fileprivate weak var introLabel: UILabel!
    
    @IBOutlet fileprivate weak var settingsTableView: UITableView! {
        didSet {
            settingsTableView.dataSource = self
            settingsTableView.delegate = self
        }
    }
    
    fileprivate lazy var settingsStaticCells: [UITableViewCell] = {
        
        let currentUser = PersistenceController.sharedInstance.currentUser
        
        let countryCell = SettingsTableViewCell(style: .subtitle, reuseIdentifier: nil)
        countryCell.textLabel?.text = L10n.helloactivityCountry.localized()
        countryCell.detailTextLabel?.text = currentUser.country
        
        let countryPicker = ListPickerController(items: [String]())
        
        let ageCell = SettingsTableViewCell(style: .subtitle, reuseIdentifier: nil)
        ageCell.textLabel?.text = L10n.helloactivityAge.localized()
        ageCell.detailTextLabel?.text = String(describing: currentUser.age)
        
        let agePicker = TextPickerController()
        agePicker.setPopupPresentation()
        agePicker.textField.keyboardType = .decimalPad
        agePicker.setOnPickerDidFinish({ text in
            currentUser.age = Int(text)!
            PersistenceController.sharedInstance.saveUser(user: currentUser)
            self.dismiss(animated: true)
        })
        agePicker.setOnPickerDidCancel({ 
            self.dismiss(animated: true)
        })
        
        ageCell.setOnSelectionHandler({
            self.present(agePicker, animated: true, completion: nil)
        })
        
        
        let genderCell = SettingsTableViewCell(style: .subtitle, reuseIdentifier: nil)
        genderCell.textLabel?.text = L10n.helloactivityGender.localized()
        genderCell.detailTextLabel?.text = String(describing: currentUser.gender).localized()
        
        let genderPicker = ListPickerController(items: [Gender.male, Gender.female])
        genderPicker.setPopupPresentation()
        
        genderPicker.setOnPickerWillDisplayItem({ String(describing:$0).localized() })
        genderPicker.setOnPickerDidFinish({ [unowned self] (pickedGender) in
            print("Completion called on main thread:\(Thread.isMainThread)")
            currentUser.gender = pickedGender
            PersistenceController.sharedInstance.saveUser(user: currentUser)
            self.dismiss(animated: true)
        })
        genderPicker.setOnPickerDidCancel({ [unowned self] in
            self.dismiss(animated: true)
        })
        
        genderCell.setOnSelectionHandler({ [unowned self] in
            self.present(genderPicker, animated: true, completion: nil)
        })
        
        let diabetesCell = SettingsTableViewCell(style: .subtitle, reuseIdentifier: nil)
        diabetesCell.textLabel?.text = L10n.helloactivitySpinnerDiabetesType.localized()
        diabetesCell.detailTextLabel?.text = String(describing: currentUser.diabetes)
        
        return [countryCell, ageCell, genderCell, diabetesCell]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        // We don't include the 'About' section if we are in welcome mode
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingsStaticCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return settingsStaticCells[indexPath.row]
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? SettingsTableViewCell {
            selectedCell.onSelection?()
        }
    }

}

