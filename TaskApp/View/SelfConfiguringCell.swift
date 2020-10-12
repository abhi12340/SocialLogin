//
//  SelfConfiguringCell.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 09/10/20.
//

import Foundation


protocol SelfConfiguringCell {
    static var reuseIdentifier : String { get }
    func configure(with employee : Datum)
}
