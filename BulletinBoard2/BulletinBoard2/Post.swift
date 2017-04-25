//
//  Post.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 4/25/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

struct Post {
    let body: String
    let date: Date
    
    init(body: String, date: Date = Date()) {
        self.body = body
        self.date = date
    }
}
