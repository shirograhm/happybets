//
//  inittests.swift
//  happytests
//
//  Created by Xavier Graham on 6/12/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation
import Firebase

class inittests: NSObject {
    override init() {
        // Configure Firebase app for testing
        FirebaseApp.configure()
    }
}
