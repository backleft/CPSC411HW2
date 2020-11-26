//
//  ClaimDetailSectionGenerator.swift
//  ClaimClient
//
//  Created by Steven Salvador on 11/25/20.
//  Copyright © 2020 Steven Salvador. All rights reserved.
//

import UIKit

class ClaimDetailSectionGenerator {
    
    func generate() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        
        let stackView1 = UIStackView()
        stackView1.distribution = .fill
        
        let title = UILabel()
        title.text = "Please Enter Claim Information"
        title.textAlignment = .center
        title.font = UIFont(name:"Georgia-Bold", size: 18)
        stackView1.addArrangedSubview(title)
        stackView.addArrangedSubview(stackView1)
        
        var vGenerator = FieldValueViewGenerator(n: "Claim Title")
        var sView = vGenerator.generate()
        stackView.addArrangedSubview(sView)
        vGenerator = FieldValueViewGenerator(n: "Claim Date")
        sView = vGenerator.generate()
        stackView.addArrangedSubview(sView)
        

        stackView1.translatesAutoresizingMaskIntoConstraints = false
        let sv1Cnt1 = stackView1.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor)
        let sv1Cnt2 = stackView1.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor)
        let sv1Cnt3 = stackView1.trailingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.trailingAnchor)
        sv1Cnt1.isActive = true
        sv1Cnt2.isActive = true
        sv1Cnt3.isActive = true

        
        return stackView
        
    }
}
