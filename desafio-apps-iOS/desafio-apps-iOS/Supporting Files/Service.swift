//
//  Service.swift
//  desafio-apps-iOS
//
//  Created by Neto Moura on 08/11/2017.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import Foundation

struct AppConteudos: Decodable {
    static func conteudoRequest(_ completionHandler: @escaping ([Capa]) -> ()) {
        let urlString = "https://raw.githubusercontent.com/Infoglobo/desafio-apps/master/capa.json"
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            guard let data = data else { return }
            if let error = error {
                print(error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let conteudo = try decoder.decode([Capa].self, from: data)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    for itens in conteudo{
                        completionHandler([itens])
                    }
                })
            } catch let err {
                print("ERRO \(err)")
            }
        }) .resume()
    }
}
