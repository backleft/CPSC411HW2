//
//  ClaimsService.swift
//  ClaimClient
//
//  Created by Steven Salvador on 11/24/20.
//  Copyright © 2020 Steven Salvador. All rights reserved.
//

import Foundation

struct Claims :  Codable {
    var claim_title : String
    var claim_date : String
}

class ClaimsService {


    func addClaim(cObj : Claims, completion: @escaping (Bool)->Void) {
        let requestUrl = "http://localhost:8020/ClaimsService/add"
        var request = URLRequest(url: NSURL(string: requestUrl)! as URL)
        let jsonData : Data! = try! JSONEncoder().encode(cObj)
        //
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //
        let task = URLSession.shared.uploadTask(with: request, from: jsonData){
            (data,response,error) in
            if let resp = data {
                //
                let respStr = String(bytes: resp, encoding: .utf8)
                print("The response data sent from server is \(respStr!)")
            } else if let respError = error {
                print("Server Error: \(respError)")
            }
        }
        task.resume()
    }
    

}
