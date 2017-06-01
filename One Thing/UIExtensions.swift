//
//  UIExtensions.swift
//  One Thing
//
//  Created by Robert Hatfield on 6/1/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit

extension UIResponder {
    
    static var identifier : String {
        return String(describing: self)
    }

}
