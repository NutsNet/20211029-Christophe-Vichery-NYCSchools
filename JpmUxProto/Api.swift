//
//  Api.swift
//  JpmUxProto
//
//  Created by Christophe Vichery on 10/28/21.
//

import UIKit
import SwiftUI

class Api: NSObject {
    
    // API Key ID     : 5bnx7zh8x3ce54an2qah01zxb
    // API Key Secret : x6kvnr3tkg0yd8pow9rimgm87pkjpzzo8bxxybw4fft2d6t9q
    // App Token      : kxrLlGkyYy9OEFle4gtSFZKy2
    // Secret Token   : apv-W4OvX4s9rCRl1LeZysQN4taaUbXVGnkp
    let client = SODAClient(domain: "data.cityofnewyork.us", token: "kxrLlGkyYy9OEFle4gtSFZKy2")
    
    var apiArrSchools = [School]()
    
    var apiPageOfSchool = 0
    let apiPageLimit = 13
    
    static let share = Api()
    
    override init() {
        super.init()
    }
    
    func getSchools(escap:@escaping (String) -> Void) {
        let query = client.query(dataset: "s3k6-pzi2")
        
        let limit = self.apiPageLimit
        let offset = self.apiPageOfSchool*limit
        query.offset(offset).limit(limit).get { result in
            switch result {
            case .dataset(let dataset):
                if dataset.count > 0 {
                    for data in dataset {
                        let school = School()
                        
                        if let school_name = data["school_name"] as? String { school.school_name = school_name }
                        if let neighborhood = data["neighborhood"] as? String { school.neighborhood = neighborhood }
                        
                        self.apiArrSchools.append(school)
                    }
                    print(self.apiArrSchools.count)
                    self.apiPageOfSchool += 1
                    
                    escap("")
                }
                break
            case .error(let error):
                print("Error in getSchools: \(error.localizedDescription)")
                escap(error.localizedDescription)
                break
            }
        }
    }
}
