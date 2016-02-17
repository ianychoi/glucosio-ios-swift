//
//  Logger.swift
//  EBCoreDataStack
//
//  Created by Eugenio Baglieri on 10/09/15.
//  Copyright © 2015 Eugenio Baglieri. All rights reserved.
//

import Foundation

enum CDLogLevel {
    case DEBUG
    case INFO
    case WARNING
    case ERROR
}

extension CDLogLevel : CustomStringConvertible {
    
    var description: String {
        switch self {
        case .DEBUG: return "DEBUG"
        case .INFO: return "INFO"
        case .WARNING: return "WARNING"
        case .ERROR: return "ERROR"
        }
    }
    
}

class Logger {
    
    func debug(message: String) {
        self.log(.DEBUG, message: message)
    }
    
    func info(message: String) {
        self.log(.INFO, message: message)
    }
    
    func warning(message: String) {
        self.log(.WARNING, message: message)
    }
    
    func error(message: String) {
        self.log(.ERROR, message: message)
    }
    
    func error(error: NSError) {
        let message = "[DOMAIN: \(error.domain)][CODE: \(error.code)] \(error.localizedDescription)"
        self.log(.ERROR, message: message)
    }
    
    private func log(level: CDLogLevel, message: String) {
        NSLog("[CoreDataStack][\(level)]: \(message)")
    }
}

var log: Logger {
    return Logger()
}