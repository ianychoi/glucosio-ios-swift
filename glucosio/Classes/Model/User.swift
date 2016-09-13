//
//  User.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 17/08/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import Foundation

let kGLUCUserPreferenceKey = "user"
private let kGLUCUserCountryPreferenceKey = "country"
private let kGLUCUserAgePropertyKey = "age"
private let kGLUCUserGenderPropertyKey = "gender"
private let kGLUCUserDiabetesTypePropertyKey = "diabetes"
private let kGLUCUserPreferredBloodGlucoseUnitsPropertyKey = "preferredBloodGlucoseUnitOfMeasure"
private let kGLUCUserPreferredBodyWeightUnitsPropertyKey = "preferredBodyWeightUnitOfMeasure"
private let kGLUCUserPreferredA1CUnitsPropertyKey = "preferredA1CUnitOfMeasure"
private let kGLUCUserPreferredGlucoseRangePropertyKey = "preferredGlucoseRange"
private let kGLUCUserAllowResearchUsePropertyKey = "allowResearchUse"

class User: NSCoding {
    
    var country: String
    
    var age: Int
    
    var gender: Gender
    
    var diabetes: Diabetes
    
    var preferredBloodGlucoseUnitOfMeasure: GlucoseUnitOfMeasure
    
    var preferredBodyWeightUnitOfMeasure: BodyWeightUnitOfMeasure
    
    var preferredA1CUnitOfMeasure: A1CUnitOfMeasure
    
    var preferredGlucoseRange: GlucoseRange
    
    
    var allowResearchUse: Bool
    
    init() {
        let locale = NSLocale.current as NSLocale
        let defaultCountryCode = locale.object(forKey: .countryCode) as? String ?? "US"
            
        country = defaultCountryCode
        
        age = 0
        gender = .male
        diabetes = .type2
        preferredBloodGlucoseUnitOfMeasure = .mg_dL
        preferredBodyWeightUnitOfMeasure = .kilograms
        preferredA1CUnitOfMeasure = .percentage
        preferredGlucoseRange = GlucoseRange.ada
        allowResearchUse = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        country = aDecoder.decodeObject(forKey: kGLUCUserCountryPreferenceKey) as? String ?? ""
        age = aDecoder.decodeInteger(forKey: kGLUCUserAgePropertyKey)
        gender = Gender(rawValue: aDecoder.decodeInteger(forKey: kGLUCUserAgePropertyKey)) ?? .male
        diabetes = Diabetes(rawValue: aDecoder.decodeInteger(forKey: kGLUCUserDiabetesTypePropertyKey)) ?? .type2
        preferredBloodGlucoseUnitOfMeasure = GlucoseUnitOfMeasure(rawValue: aDecoder.decodeInteger(forKey: kGLUCUserPreferredBloodGlucoseUnitsPropertyKey)) ?? .mg_dL
        preferredBodyWeightUnitOfMeasure = BodyWeightUnitOfMeasure(rawValue: aDecoder.decodeInteger(forKey: kGLUCUserPreferredBodyWeightUnitsPropertyKey)) ?? .kilograms
        preferredA1CUnitOfMeasure = A1CUnitOfMeasure(rawValue: aDecoder.decodeInteger(forKey: kGLUCUserPreferredA1CUnitsPropertyKey)) ?? .percentage
        preferredGlucoseRange = aDecoder.decodeObject(forKey: kGLUCUserPreferredGlucoseRangePropertyKey) as? GlucoseRange ?? GlucoseRange.ada
        allowResearchUse = aDecoder.decodeBool(forKey: kGLUCUserAllowResearchUsePropertyKey)
        
    }
    
    func encode(with aCoder: NSCoder) {
        with(aCoder) {
            $0.encode(country, forKey: kGLUCUserCountryPreferenceKey)
            $0.encode(age, forKey: kGLUCUserAgePropertyKey)
            $0.encode(gender.rawValue, forKey: kGLUCUserAgePropertyKey)
            $0.encode(diabetes.rawValue, forKey: kGLUCUserDiabetesTypePropertyKey)
            $0.encode(preferredBloodGlucoseUnitOfMeasure.rawValue, forKey: kGLUCUserPreferredBloodGlucoseUnitsPropertyKey)
            $0.encode(preferredBodyWeightUnitOfMeasure.rawValue, forKey: kGLUCUserPreferredBodyWeightUnitsPropertyKey)
            $0.encode(preferredA1CUnitOfMeasure.rawValue, forKey: kGLUCUserPreferredA1CUnitsPropertyKey)
            $0.encode(preferredGlucoseRange, forKey: kGLUCUserPreferredGlucoseRangePropertyKey)
            $0.encode(allowResearchUse, forKey: kGLUCUserAllowResearchUsePropertyKey)
        }
    }
    
}

enum Gender: Int {
    
    case male = 0
    
    case female = 1
    
    case other = 2
    
}

extension Gender: CustomStringConvertible {
    
    var description: String {
        
        switch self {
            
        case .male: return L10n.helloactivityGenderList1
            
        case .female: return L10n.helloactivityGenderList2
            
        case .other: return L10n.helloactivityGenderList3
            
        }
    }
}
