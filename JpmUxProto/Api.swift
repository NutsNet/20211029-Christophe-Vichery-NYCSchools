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
    
    private var queue = DispatchQueue(label: "api.queue")
    
    static let share = Api()
    
    override init() {
        super.init()
    }
    
    func getSchools(offset: Int, limit: Int, escap:@escaping () -> Void) {
        let school_name = client.query(dataset: "s3k6-pzi2")
        
        queue.async {
            school_name.offset(offset).limit(limit).get { result in
                //print(result)
                escap()
            }
        }
    }
}
