//
//  ViewController.swift
//  ClaimClient
//
//  Created by Steven Salvador on 11/24/20.
//  Copyright © 2020 Steven Salvador. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    /*func refreshScreen(pObj : Claims) {
        vals[0].text = pObj.claim_id
        vals[1].text = pObj.claim_title
        vals[2].text = pObj.claim_date
        vals[3].text = pObj.claim_isSolved
    }
 */

    var lbls = [UILabel]()
    var vals = [UITextField]()
    //var nextBtn : UIButton!
    //var cService : ClaimsService!
    
    let abutton = UIButton()
    let sMessage = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vGenerator = ClaimDetailSectionGenerator()
        let sView = vGenerator.generate()
        view.addSubview(sView)
              
        let bStackView = UIStackView()
        bStackView.spacing = 100
        abutton.setTitle("Add", for: .normal)
        abutton.setTitleColor(UIColor.black, for: .normal)
        abutton.backgroundColor = UIColor.orange
        abutton.addTarget(self, action: #selector(add(_:)), for: .touchUpInside)
        bStackView.addArrangedSubview(abutton)
        view.addSubview(bStackView)
              
              let cViews = sView.arrangedSubviews
              for sv in cViews {
                  let innerStackView = sv as! UIStackView
                  for ve in innerStackView.arrangedSubviews {
                      if ve is UITextField {
                          vals.append(ve as! UITextField)
                      }
                  }
              }
              
              for i in 0...vals.count-1 {
                  vals[i].translatesAutoresizingMaskIntoConstraints = false
                  let constr = vals[i].leadingAnchor.constraint(equalTo: vals[0].leadingAnchor)
                  constr.isActive = true
              }
              
              let sStackView = UIStackView()
              sStackView.axis = .horizontal
              sStackView.spacing = 20
              let status = UILabel()
              status.text = "Status:"
              sStackView.addArrangedSubview(status)
              sMessage.text = "<Status Message>"
              sStackView.addArrangedSubview(sMessage)
              view.addSubview(sStackView)
              
              sView.translatesAutoresizingMaskIntoConstraints = false
              let tCont = sView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
              let lCont = sView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
              let trCont = sView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
              tCont.isActive = true
              lCont.isActive = true
              trCont.isActive = true
              
              bStackView.translatesAutoresizingMaskIntoConstraints = false
              let bCnt1 = bStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
              let bCnt2 = bStackView.topAnchor.constraint(equalTo: sView.bottomAnchor)
              bCnt1.isActive = true
              bCnt2.isActive = true
              
              sStackView.translatesAutoresizingMaskIntoConstraints = false
              let sCnt1 = sStackView.topAnchor.constraint(equalTo: bStackView.bottomAnchor)
              let sCnt2 = sStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
              let sCnt3 = sStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
              sCnt1.isActive = true
              sCnt2.isActive = true
              sCnt3.isActive = true
        
    }
          
          @objc func add(_ sender : UIButton) {
              print("ADD button was clicked")
              let text1 = vals[0].text as String?
              let text2 = vals[1].text as String?
              let cService = ClaimsService()
              if text1! == "" && text2! == "" {
                  self.sMessage.text = "You did not enter any data"
              }
              else if text1! == "" {
                  self.sMessage.text = "You did not enter claim title"
              }
              else if text2! == "" {
                  self.sMessage.text = "You did not enter date"
              }
              else {
                let cObj = Claims(claim_title: text1!, claim_date: text2!)
                  cService.addClaim(cObj: cObj, completion: { value in
                      if value {
                          self.sMessage.text = "Claim \(text1!) was successfully created"
                        self.vals[0].text = ""
                        self.vals[1].text = ""
                      }
                      else {
                          self.sMessage.text = "Claim \(text1!) failed to be created"
                      }
                  })
            }
    }
}
