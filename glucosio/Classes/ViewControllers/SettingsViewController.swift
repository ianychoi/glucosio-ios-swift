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
            settingsTableView.rowHeight = 50.0
            settingsTableView.tableHeaderView = UIView()
            settingsTableView.tableFooterView = UIView()
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
        cell.textLabel!.font = GLUCFont.regular.withSize(titleFontSize)
        cell.detailTextLabel!.font = GLUCFont.regular.withSize(subtitleFontSize)
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        return cell
    }
    
    
    fileprivate func createSettingsCells() -> [UITableViewCell] {
        
        let user = PersistenceController.sharedInstance.currentUser
        
        let locale = NSLocale.current as NSLocale
        
        var currentCountry: String?  {
            return locale.displayName(forKey: .countryCode, value: user.country)
        }
        
        let countryCell = subtitleCell(withTitle: L10n.helloactivityCountry.localized, subtitle: currentCountry)
        countryCell.setOnSelectionHandler { [unowned self] in
            let countryPicker = ListPickerController(items: NSLocale.isoCountryCodes)
            countryPicker.setPopupPresentation()
            countryPicker.setOnPickerWillDisplayItem({
                locale.displayName(forKey: .countryCode, value: $0) ?? String(describing: $0)
                })
            countryPicker.setOnPickerDidFinish({ [unowned self, countryCell] pickedCountry in
                user.country = pickedCountry
                countryCell.detailTextLabel?.text = currentCountry
                PersistenceController.sharedInstance.saveUser(user: user)
                self.dismiss(animated: true)
                })
            countryPicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(countryPicker, animated: true)
        }
        
        
        var currentAge: String? {
            return String(describing: user.age)
        }
        
        let ageCell = subtitleCell(withTitle: L10n.helloactivityAge.localized, subtitle: currentAge)
        ageCell.setOnSelectionHandler({ [unowned self] in
            let agePicker = TextPickerController()
            agePicker.setPopupPresentation()
            agePicker.textField.placeholder = "Type your age".localized
            agePicker.textField.keyboardType = .decimalPad
            agePicker.setOnPickerDidFinish({ [unowned self, ageCell] text in
                user.age = Int(text)!
                ageCell.detailTextLabel?.text = currentAge
                PersistenceController.sharedInstance.saveUser(user: user)
                self.dismiss(animated: true)
                })
            agePicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(agePicker, animated: true)
            })
        
        var currentGender: String {
            return String(describing: user.gender).localized
        }
        
        let genderCell = subtitleCell(withTitle: L10n.helloactivityGender.localized, subtitle: currentGender)
        genderCell.setOnSelectionHandler({ [unowned self] in
            let genderPicker = ListPickerController(items: [Gender.male, Gender.female])
            genderPicker.setPopupPresentation()
            genderPicker.setOnPickerWillDisplayItem({ String(describing:$0).localized })
            genderPicker.setOnPickerDidFinish({ [unowned self, genderCell] pickedGender in
                user.gender = pickedGender
                genderCell.detailTextLabel?.text = currentGender
                PersistenceController.sharedInstance.saveUser(user: user)
                self.dismiss(animated: true)
                })
            genderPicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(genderPicker, animated: true)
            })
        
        var currentDiabetes: String {
            return String(describing: user.diabetes).localized
        }
        
        let diabetesCell = subtitleCell(withTitle: L10n.helloactivitySpinnerDiabetesType.localized, subtitle: currentDiabetes)
        diabetesCell.setOnSelectionHandler({ [unowned self] in
            let diabetesPicker = ListPickerController(items: [Diabetes.type1, Diabetes.type2])
            diabetesPicker.setPopupPresentation()
            diabetesPicker.setOnPickerWillDisplayItem({ String(describing:$0).localized })
            diabetesPicker.setOnPickerDidFinish({ [unowned self, diabetesCell] pickedDiabetes in
                user.diabetes = pickedDiabetes
                diabetesCell.detailTextLabel?.text = currentDiabetes
                PersistenceController.sharedInstance.saveUser(user: user)
                self.dismiss(animated: true)
                })
            diabetesPicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(diabetesPicker, animated: true)
            })
        
        var currentGlucoseUnit: String {
            return String(describing: user.preferredBloodGlucoseUnitOfMeasure).localized
        }
        
        let glucoseUnitCell = subtitleCell(withTitle: L10n.helloactivitySpinnerPreferredUnit.localized, subtitle: currentGlucoseUnit)
        glucoseUnitCell.setOnSelectionHandler({ [unowned self] in
            let glucoseUnitPicker = ListPickerController(items: [GlucoseUnitOfMeasure.mg_dL, GlucoseUnitOfMeasure.mmol_L])
            glucoseUnitPicker.setPopupPresentation()
            glucoseUnitPicker.setOnPickerWillDisplayItem({ String(describing:$0).localized })
            glucoseUnitPicker.setOnPickerDidFinish({ [unowned self, glucoseUnitCell] pickedUnit in
                user.preferredBloodGlucoseUnitOfMeasure = pickedUnit
                glucoseUnitCell.detailTextLabel?.text = currentGlucoseUnit
                PersistenceController.sharedInstance.saveUser(user: user)
                self.dismiss(animated: true)
                })
            glucoseUnitPicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(glucoseUnitPicker, animated: true)
            })
        
        var currentA1CUnit: String {
            return String(describing: user.preferredA1CUnitOfMeasure).localized
        }
        
        let a1CUnitCell = subtitleCell(withTitle: "Preferred A1C Unit", subtitle: currentA1CUnit)
        a1CUnitCell.setOnSelectionHandler({ [unowned self] in
            let a1CUnitPicker = ListPickerController(items: [A1CUnitOfMeasure.percentage, A1CUnitOfMeasure.mmol_mol])
            a1CUnitPicker.setPopupPresentation()
            a1CUnitPicker.setOnPickerWillDisplayItem({ String(describing:$0).localized })
            a1CUnitPicker.setOnPickerDidFinish({ [unowned self, a1CUnitCell] pickedUnit in
                user.preferredA1CUnitOfMeasure = pickedUnit
                a1CUnitCell.detailTextLabel?.text = currentA1CUnit
                PersistenceController.sharedInstance.saveUser(user: user)
                self.dismiss(animated: true)
                })
            a1CUnitPicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(a1CUnitPicker, animated: true)
            })
        
        var currentWeightUnit: String {
            return String(describing: user.preferredBodyWeightUnitOfMeasure).localized
        }
        
        let weightUnitCell = subtitleCell(withTitle: "Preferred Weight Unit".localized, subtitle: currentWeightUnit)
        weightUnitCell.setOnSelectionHandler({ [unowned self] in
            let weightUnitPicker = ListPickerController(items: [BodyWeightUnitOfMeasure.kilograms, BodyWeightUnitOfMeasure.pounds])
            weightUnitPicker.setPopupPresentation()
            weightUnitPicker.setOnPickerWillDisplayItem({ String(describing:$0).localized })
            weightUnitPicker.setOnPickerDidFinish({ [unowned self, weightUnitCell] pickedUnit in
                user.preferredBodyWeightUnitOfMeasure = pickedUnit
                weightUnitCell.detailTextLabel?.text = currentWeightUnit
                PersistenceController.sharedInstance.saveUser(user: user)
                self.dismiss(animated: true)
                })
            weightUnitPicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(weightUnitPicker, animated: true)
        })
        
        var currentRangeLowerBound: String {
            return String(describing: user.preferredGlucoseRange.lowerBound)
        }
        
        let minRangeCell = subtitleCell(withTitle: L10n.helloactivityPreferredRangeMin.localized, subtitle: currentRangeLowerBound)
        minRangeCell.setOnSelectionHandler({ [unowned self] in
            let lowerBoundPicker = TextPickerController()
            lowerBoundPicker.setPopupPresentation()
            lowerBoundPicker.textField.placeholder = "Type custom lower bound".localized
            lowerBoundPicker.textField.keyboardType = .decimalPad
            lowerBoundPicker.setOnPickerDidFinish({ [unowned self, minRangeCell] text in
                user.preferredGlucoseRange.lowerBound = Int(text)!
                minRangeCell.detailTextLabel?.text = currentRangeLowerBound
                PersistenceController.sharedInstance.saveUser(user: user)
                self.dismiss(animated: true)
                })
            lowerBoundPicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(lowerBoundPicker, animated: true)
        })
        
        var currentRangeUpperBound: String {
            return String(describing: user.preferredGlucoseRange.upperBound)
        }
        
        let maxRangeCell = subtitleCell(withTitle: L10n.helloactivityPreferredRangeMax.localized, subtitle: currentRangeUpperBound)
        maxRangeCell.setOnSelectionHandler({ [unowned self] in
            let upperBoundPicker = TextPickerController()
            upperBoundPicker.setPopupPresentation()
            upperBoundPicker.textField.placeholder = "Type custom upper bound".localized
            upperBoundPicker.textField.keyboardType = .decimalPad
            upperBoundPicker.setOnPickerDidFinish({ [unowned self, maxRangeCell] text in
                user.preferredGlucoseRange.upperBound = Int(text)!
                maxRangeCell.detailTextLabel?.text = currentRangeUpperBound
                PersistenceController.sharedInstance.saveUser(user: user)
                self.dismiss(animated: true)
                })
            upperBoundPicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(upperBoundPicker, animated: true)
            })
        
        var currentRange: String {
            return String.init(describing: user.preferredGlucoseRange).localized
        }
        
        let rangeCell = subtitleCell(withTitle: L10n.helloactivitySpinnerPreferredRange.localized, subtitle: currentRange)
        rangeCell.setOnSelectionHandler({ [unowned self] in
            let rangePicker = ListPickerController(items: [GlucoseRange.ada,
                                                           GlucoseRange.aace,
                                                           GlucoseRange.ukNice,
                                                           GlucoseRange(lowerBound: GlucoseRange.ada.lowerBound, upperBound: GlucoseRange.ada.upperBound)])
            rangePicker.setPopupPresentation()
            rangePicker.setOnPickerWillDisplayItem({ String(describing:$0).localized })
            rangePicker.setOnPickerDidFinish({ [unowned self] pickedRange in
                user.preferredGlucoseRange = pickedRange
                rangeCell.detailTextLabel?.text = currentRange
                PersistenceController.sharedInstance.saveUser(user: user)
                
                let isEnabled = (pickedRange.type == .custom)
                minRangeCell.isEnabled = isEnabled
                maxRangeCell.isEnabled = isEnabled
                
                self.dismiss(animated: true)
                })
            rangePicker.setOnPickerDidCancel({ [unowned self] in
                self.dismiss(animated: true)
                })
            
            self.present(rangePicker, animated: true)
            })
        
        if user.preferredGlucoseRange.type != .custom {
            minRangeCell.isEnabled = false
            maxRangeCell.isEnabled = false
        }
        
        return [countryCell, ageCell, genderCell, diabetesCell, glucoseUnitCell, a1CUnitCell, weightUnitCell, rangeCell, minRangeCell, maxRangeCell]
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

