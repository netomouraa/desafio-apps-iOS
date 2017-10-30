//
//  ViewController.swift
//  desafio-apps-iOS
//
//  Created by Neto Moura on 30/10/2017.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewConteudo: UITableView!
//    var link = LinkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func request(){
        
        let urlString = "https://raw.githubusercontent.com/Infoglobo/desafio-apps/master/capa.json"

        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            
            
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
//
//                    if let conteudos = json["conteudos"] as! [String:Any] {
//                        guard let userObject = Noticia(dictionary:conteudos) else {
//                            print("Failed to create user from dictionary")
//                            return
//                        }
//                        // Do something with userObject
//                    }
//                }
//
//            } catch let parseError {
//
//            }
//
            if error != nil {
                print(error!)
            } else {
                do {
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
                    for item in jsonSerialized {
//                        let currentConditions = item["currently"] as! String
                    }


                    for (key, value) in jsonSerialized[0] {
                        print("ITEM: \(key) - \(value) ")
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticiaCell", for: indexPath) as! NoticiaTableViewCell

        return cell
    
    }
    

}

