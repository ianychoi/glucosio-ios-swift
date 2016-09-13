//
//  ViewController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 13/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    fileprivate struct StoryboardIdentifiers {
    
        static let settingCellIdentifier = "SettingsCell"
        
    }

    var welcomeMode: Bool = false
    
    fileprivate let user: User = PersistenceController.sharedInstance.currentUser
    
    fileprivate lazy var aboutKeys: [String] = {
    
        let about = [
            L10n.preferencesVersion,
            L10n.preferencesTerms,
            L10n.preferencesPrivacy
        ]
        
        return about
    }()
    
    @IBOutlet fileprivate weak var stackView: UIStackView!
    
    @IBOutlet fileprivate weak var welcomeView: UIView!
    
    @IBOutlet fileprivate weak var helloLabel: UILabel!
    
    @IBOutlet fileprivate weak var introLabel: UILabel!
    
    @IBOutlet fileprivate weak var settingsTableView: UITableView! {
        didSet {
//            settingsTableView.dataSource = self
//            settingsTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//extension SettingsViewController: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // We don't include the 'About' section if we are in welcome mode
//        return (welcomeMode == true) ? 1 : 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        let retVal: Int
//        
//        switch section {
//            
//        case 0: retVal = settings.count
//        
//        case 1: retVal = aboutKeys.count
//        
//        default: retVal = 5
//        }
//        
//        return retVal
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell: UITableViewCell
//        
//        if let _cell = tableView.dequeueReusableCell(withIdentifier: StoryboardIdentifiers.settingCellIdentifier) {
//          
//            cell = _cell
//        } else {
//
//            cell = UITableViewCell(style: .value1, reuseIdentifier: StoryboardIdentifiers.settingCellIdentifier)
//        }
//        
//        configureCell(cell, at: indexPath)
//        
//        return cell
//    }
//    
//    fileprivate func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
//        
//        cell.textLabel?.minimumScaleFactor = 0.25
//        cell.textLabel?.adjustsFontSizeToFitWidth = true;
//        cell.textLabel?.numberOfLines = 2;
//        cell.textLabel?.font = GLUCFont.regular
//        cell.textLabel?.text = nil
//        
//        cell.detailTextLabel?.font = GLUCFont.regular
//        cell.detailTextLabel?.text = nil
//        
//        cell.accessoryType = .none
//        
//        let section = indexPath.section
//        let row = indexPath.row
//        
//        switch section {
//        case 0:
//            
//            cell.textLabel?.text = titleForPreferenceKey(settings[row])?.localized()
//            
//            let value = valueForPreferenceKey(settings[row])
//            
//            let localizedValue: String
//            
//            if let _localizable = value as? Localizable {
//                
//                localizedValue = _localizable.localizedDescription
//            }
//            else if let _stringValue = value as? String {
//                
//                localizedValue = _stringValue.localized()
//            }
//            else {
//            
//                localizedValue = String(describing: value)
//            }
//        
//            cell.detailTextLabel?.text = localizedValue
//            
//        case 1:
//            cell.textLabel?.text = aboutKeys[row].localized()
//        default: return
//        }
//        
//    }
//    
//}
//
//extension SettingsViewController: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
//
//}

