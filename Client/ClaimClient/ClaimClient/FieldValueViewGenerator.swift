//
//  FieldValueViewGenerator.swift
//  ClaimClient
//
//  Created by Steven Salvador on 11/25/20.
//  Copyright © 2020 Steven Salvador. All rights reserved.
//

import UIKit


// This class is used to prefill the label fields needed
class FieldValueViewGenerator {
    var lblName : String!
    
    init(n:String) {
        lblName = n
    }

//this will generate the labels needed
func generate() -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.spacing = 5
    

    
    let lbl = UILabel()
    lbl.text = lblName
    lbl.backgroundColor = UIColor.orange
    stackView.addArrangedSubview(lbl)
    let val = UITextField()
    val.text = "Enter Information Here"
    val.backgroundColor = UIColor.cyan
    stackView.addArrangedSubview(val)
    
    return stackView
    
    }
}

