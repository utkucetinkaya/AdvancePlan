//
//  UIColor+Ext.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 6.12.2023.
//

import UIKit

extension UIColor {
    static var detailCellTint: UIColor {
        UIColor(named: "DetailCellTint") ?? .tintColor
    }

    static var listCellBackground: UIColor {
        UIColor(named: "ListCellBackground") ?? .secondarySystemBackground
    }

    static var listCellDoneButtonTint: UIColor {
        UIColor(named: "ListCellDoneButtonTint") ?? .tintColor
    }

    static var secondaryTint: UIColor {
        UIColor(named: "SecondaryTint") ?? .systemFill
    }

    static var thirdTint: UIColor {
        UIColor(named: "ThirdTint") ?? .quaternarySystemFill
    }

    static var navigationBackground: UIColor {
        UIColor(named: "NavigationBackground") ?? .secondarySystemBackground
    }

    static var primaryTint: UIColor {
        UIColor(named: "PrimaryTint") ?? .tintColor
    }

    static var defaultTagView: UIColor {
        UIColor(named: "DefaultTagView") ?? .systemGray
    }
}
