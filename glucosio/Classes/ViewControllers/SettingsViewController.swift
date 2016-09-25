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
            settingsTableView.allowsMultipleSelection = false
            settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        }
    }
    
    fileprivate lazy var settingsCells: [UITableViewCell] = {
        return self.createSettingsCells()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: Private methods
    
    fileprivate func subtitleCell(withTitle title: String?, subtitle: String?) -> SettingsTableViewCell {
        let cell = SettingsTableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        // Setting a selection style other than .none avoid this: http://stackoverflow.com/questions/21075540/presentviewcontrolleranimatedyes-view-will-not-appear-until-user-taps-again/30787046#30787046
        cell.selectionStyle = .default
        
        //Get defualt label font size
        let titleFontSize = cell.textLabel!.font.pointSize
        let subtitleFontSize = cell.detailTextLabel!.font.pointSize
        
        //Set Glucosio defalt font
        cell.textLabel?.font = GLUCFont.regular.withSize(titleFontSize)
        cell.detailTextLabel?.font = GLUCFont.regular.withSize(subtitleFontSize)
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        return cell
    }
    
    
    fileprivate func createSettingsCells() -> [UITableViewCell] {
        
        let currentUser = PersistenceController.sharedInstance.currentUser
        
        let countryCell = SettingsTableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let countryPicker = ListPickerController(items: [String]())
        
        let ageCell = subtitleCell(withTitle: L10n.helloactivityAge.localized(), subtitle: String(describing: currentUser.age))
        ageCell.setOnSelectionHandler({             let agePicker = TextPickerController()
            agePicker.setPopupPresentation()
            agePicker.textField.placeholder = "Tipe your age".localized()
            agePicker.textField.keyboardType = .decimalPad
            agePicker.setOnPickerDidFinish({ text in
                currentUser.age = Int(text)!
                PersistenceController.sharedInstance.saveUser(user: currentUser)
                self.dismiss(animated: true)
            })
            agePicker.setOnPickerDidCancel({
                self.dismiss(animated: true)
            })
            
            self.present(agePicker, animated: true, completion: nil)
            })
        
        let genderCell = subtitleCell(withTitle: L10n.helloactivityGender.localized(), subtitle: String(describing: currentUser.gender).localized())
        genderCell.setOnSelectionHandler({
            let genderPicker = ListPickerController(items: [Gender.male, Gender.female])
            genderPicker.setPopupPresentation()
            genderPicker.setOnPickerWillDisplayItem({ String(describing:$0).localized() })
            genderPicker.setOnPickerDidFinish({ pickedGender in
                currentUser.gender = pickedGender
                PersistenceController.sharedInstance.saveUser(user: currentUser)
                self.dismiss(animated: true)
            })
            genderPicker.setOnPickerDidCancel({
                self.dismiss(animated: true)
            })
            
            self.present(genderPicker, animated: true, completion: nil)
            })
        
        
        let diabetesCell = subtitleCell(withTitle: L10n.helloactivitySpinnerDiabetesType.localized(), subtitle: String(describing: currentUser.diabetes).localized())
        diabetesCell.setOnSelectionHandler({
            let diabetesPicker = ListPickerController(items: [Diabetes.type1, Diabetes.type2])
            diabetesPicker.setPopupPresentation()
            diabetesPicker.setOnPickerWillDisplayItem({ String(describing:$0).localized() })
            diabetesPicker.setOnPickerDidFinish({ pickedDiabetes in
                currentUser.diabetes = pickedDiabetes
                PersistenceController.sharedInstance.saveUser(user: currentUser)
                self.dismiss(animated: true)
            })
            diabetesPicker.setOnPickerDidCancel({
                self.dismiss(animated: true)
            })
            
            self.present(diabetesPicker, animated: true, completion: nil)
            })
        
        
        return [countryCell, ageCell, genderCell, diabetesCell]
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // We don't include the 'About' section if we are in welcome mode
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingsCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return settingsCells[indexPath.row]
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Use of async dispatch resolve this: http://stackoverflow.com/questions/21075540/presentviewcontrolleranimatedyes-view-will-not-appear-until-user-taps-again/30787046#30787046
        DispatchQueue.main.async {
            if let selectedCell = tableView.cellForRow(at: indexPath) as? SettingsTableViewCell {
                selectedCell.onSelection?()
            }
        }
    }
    
}

