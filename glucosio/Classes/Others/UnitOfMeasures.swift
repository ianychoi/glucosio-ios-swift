//
//  UnitOfMeasures.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 17/08/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import Foundation

enum Diabetes: Int {

    case type1 = 0
    
    case type2 = 1
    
}

extension Diabetes: CustomStringConvertible {

    var description: String {
        
        switch self {
        
        case .type1: return L10n.helloactivitySpinnerDiabetesType1
            
        case .type2: return L10n.helloactivitySpinnerDiabetesType2
        
        }
    }

}

enum GlucoseUnitOfMeasure: Int {

    case mg_dL = 0
    
    case mmol_L = 1
    
}

extension GlucoseUnitOfMeasure: CustomStringConvertible {
    
    var description: String {
        
        switch self {
        
        case .mg_dL: return L10n.helloactivitySpinnerPreferredUnit1
            
        case .mmol_L: return L10n.helloactivitySpinnerPreferredUnit2
        
        }
    }
}

enum BodyWeightUnitOfMeasure: Int {

    case kilograms = 0
    
    case pounds = 1
    
}

extension BodyWeightUnitOfMeasure: CustomStringConvertible {

    // TODO: localize properly
    var description: String {
    
        switch self {
            
        case .kilograms: return "KILOGRAMS"
        
        case .pounds: return "POUNDS"
        
        }
    }
    
    var localizedDescription: String {
        
        return description.localized
    }
}

enum A1CUnitOfMeasure: Int {

    case percentage = 0
    
    case mmol_mol = 1
    
}

extension A1CUnitOfMeasure: CustomStringConvertible {
    
    // TODO: localize properly
    var description: String {
        
        switch self {
            
        case .percentage: return "Percentage"
            
        case .mmol_mol: return "mmol/mol"
            
        }
    }
}

