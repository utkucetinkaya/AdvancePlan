//
//  NSObject+Ext.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 1.12.2023.
//

import Foundation

// MARK: - Name Of Class
extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}
