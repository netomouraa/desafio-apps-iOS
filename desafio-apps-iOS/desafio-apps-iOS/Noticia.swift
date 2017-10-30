//
//  Noticia.swift
//  desafio-apps-iOS
//
//  Created by Neto Moura on 30/10/2017.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import Foundation

class Noticia {
    let token: String
    let agentId: Int
    let userId: Int
    
    init?(dictionary: [String:Any]) {
        
        guard let token = dictionary["token"] as? String,
        let agentId = dictionary["agent_id"] as? Int,
        let userId = dictionary["user_id"] as? Int
//        ...  // And so on
        else {
            return nil
        }
        
        self.token = token;
        self.agentId = agentId;
        self.userId = userId;
        
    }
}
