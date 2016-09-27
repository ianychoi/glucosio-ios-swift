//
//  GlucoseRange.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 06/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import Foundation
import UIKit

private let kRangeTypeKey = "glucose_range_type"
private let kRangeLowerBoundKey = "glucose_range_lower_bound"
private let kRangeUpperBoundKey = "glucose_range_upper_bound"

class GlucoseRange: NSObject, NSCoding {
    
    enum RangeType: Int {
        case ada = 0
        case aace = 1
        case ukNice = 2
        case custom = 3
    }
    
    let type: RangeType
    var lowerBound: Int
    var upperBound: Int
    
    class var ada: GlucoseRange {
        return GlucoseRange(type: .ada, lowerBound: 70, upperBound: 180)
    }

    class var aace: GlucoseRange {
        return GlucoseRange(type: .aace, lowerBound: 110, upperBound: 140)
    }
    
    class var ukNice: GlucoseRange {
        return GlucoseRange(type: .ukNice, lowerBound: 72, upperBound: 153)
    }
    
    convenience init(lowerBound lower: Int, upperBound upper: Int) {
        self.init(type: .custom, lowerBound: lower, upperBound: upper)
    }
    
    fileprivate init(type t: RangeType, lowerBound lower: Int, upperBound upper: Int) {
        type = t
        lowerBound = lower
        upperBound = upper
        super.init()
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        type = RangeType(rawValue: aDecoder.decodeInteger(forKey: kRangeTypeKey)) ?? .ada
        lowerBound = aDecoder.decodeInteger(forKey: kRangeLowerBoundKey)
        upperBound = aDecoder.decodeInteger(forKey: kRangeUpperBoundKey)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(type.rawValue, forKey: kRangeTypeKey)
        aCoder.encode(lowerBound, forKey: kRangeLowerBoundKey)
        aCoder.encode(upperBound, forKey: kRangeUpperBoundKey)
    }
    
    // MARK: - CustomStringConvertible
    
    override var description: String {
        
        switch self.type {
        case .ada: return L10n.helloactivitySpinnerPreferredRange1
        case .aace: return L10n.helloactivitySpinnerPreferredRange2
        case .ukNice: return L10n.helloactivitySpinnerPreferredRange3
        case .custom: return L10n.helloactivitySpinnerPreferredRange4
        }
    }
    
}

