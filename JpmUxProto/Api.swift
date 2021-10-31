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
    let apiPageLimit = 25
    
    static let share = Api()
    
    override init() {
        super.init()
    }
    
    // Get schools with pagination to update the array of schools
    func apiGetSchools(escap:@escaping () -> Void) {
        let limit = self.apiPageLimit
        let offset = self.apiPageOfSchool*limit
        
        let query = client.query(dataset: "s3k6-pzi2").offset(offset).limit(limit)
        
        query.get { result in
            switch result {
            case .dataset(let dataset):
                if dataset.count > 0 {
                    for data in dataset {
                        let school = School()
                        
                        if let dbn = data["dbn"] as? String { school.dbn = dbn }
                        if let school_name = data["school_name"] as? String { school.school_name = school_name }
                        if let neighborhood = data["neighborhood"] as? String { school.neighborhood = neighborhood }
                        if let location = data["location"] as? String { school.location = location }
                        if let website = data["website"] as? String { school.website = website }
                        if let school_email = data["school_email"] as? String { school.school_email = school_email }
                        if let phone_number = data["phone_number"] as? String { school.phone_number = phone_number }
                        if let overview_paragraph = data["overview_paragraph"] as? String { school.overview_paragraph = overview_paragraph }
                        
                        self.apiArrSchools.append(school)
                    }
                    
                    self.apiPageOfSchool += 1
                    
                    escap()
                }
                break
            case .error(let error):
                print("Error in getSchools: \(error.localizedDescription)")
                break
            }
        }
    }
    
    // Get SATs of a school only when opening the detail view controller
    // in  : dbn -> id of the school to get the right row
    // out : school object with only couple parameters
    //
    func apiGetSats(dbn: String, escap:@escaping (School) -> Void) {
        let query = client.query(dataset: "f9bf-2cp4").filterColumn("dbn", "\(dbn)")
        
        query.get { result in
            switch result {
            case .dataset(let dataset):
                let school = School()
                
                if dataset.count == 1 {
                    let data = dataset[0]
                    
                    if let dbn = data["dbn"] as? String { school.dbn = dbn }
                    if let school_name = data["school_name"] as? String { school.school_name = school_name }
                    if let num_of_sat_test_takers = data["num_of_sat_test_takers"] as? String { school.num_of_sat_test_takers = num_of_sat_test_takers }
                    if let sat_critical_reading_avg_score = data["sat_critical_reading_avg_score"] as? String { school.sat_critical_reading_avg_score = sat_critical_reading_avg_score }
                    if let sat_writing_avg_score = data["sat_writing_avg_score"] as? String { school.sat_writing_avg_score = sat_writing_avg_score }
                    if let sat_math_avg_score = data["sat_math_avg_score"] as? String { school.sat_math_avg_score = sat_math_avg_score }
                }
                
                escap(school)
                break
            case .error(let error):
                print("Error in getSats: \(error.localizedDescription)")
                escap(School())
                break
            }
        }
    }
}
