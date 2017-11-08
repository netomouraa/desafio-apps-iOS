//
//  ViewController.swift
//  desafio-apps-iOS
//
//  Created by Neto Moura on 30/10/2017.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit

class CapaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewConteudo: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var imageViewHeaderNoticia: UIImageView!
    @IBOutlet weak var labelHeaderSecao: UILabel!
    @IBOutlet weak var labelHeaderTitulo: UILabel!
    
    var cache = NSCache<AnyObject, AnyObject>()
    var conteudos: [Capa]?
    var appConteudos: AppConteudos?
    var arrayNoticias = [Conteudos]()
    var imageViewCache: UIImageView?
//    var imageCache: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CapaViewController.TapGestureRecognizer(gestureRecognizer: )))
        viewHeader.addGestureRecognizer(tapGesture)
        
       resquestAPI()
    }

    func resquestAPI(){
        AppConteudos.conteudoRequest { (conteudos) -> () in
            self.conteudos = conteudos
            for item in conteudos {
                self.arrayNoticias = item.conteudos!
            }
            self.tableViewConteudo?.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNoticias.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticiaCell", for: indexPath) as! NoticiaTableViewCell
        
        let primeiraNoticia = self.arrayNoticias.first
        for link in (primeiraNoticia?.imagens!)!{
            self.imageViewHeaderNoticia.downloadedFrom(link: link.url!)
        }
        self.labelHeaderSecao.text = primeiraNoticia?.secao?.nome?.uppercased()
        self.labelHeaderTitulo.text = primeiraNoticia?.titulo
        
        let noticia = arrayNoticias[indexPath.row + 1]
        if (noticia.imagens?.isEmpty)! {
            cell.imageViewNoticia.image = UIImage(named: "naodisponivel.png")
        } else {
            for item in noticia.imagens! {
                if let image = cache.object(forKey: noticia.imagens?[0] as AnyObject) {
                    cell.imageViewNoticia.image = image as? UIImage
                }else {
                    cell.imageViewNoticia.image = nil
                    cell.imageViewNoticia.downloadedFrom(link: item.url!)
                    let image = imageViewCache?.downloadedFrom(link: item.url!)
                    self.cache.setObject(image as AnyObject, forKey: noticia.imagens?[0] as AnyObject)
                }
            }
        }
        cell.labelSecaoNoticia.text = noticia.secao?.nome?.uppercased()
        cell.labelTituloNoticia.text = noticia.titulo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableViewConteudo.deselectRow(at: indexPath, animated: false)

        let vc = DetalhesViewController(nibName: "DetalhesViewController", bundle: nil)
        vc.detalhes = self.arrayNoticias[indexPath.row + 1]
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @objc func TapGestureRecognizer(gestureRecognizer: UIGestureRecognizer) {
        let vc = DetalhesViewController(nibName: "DetalhesViewController", bundle: nil)
        vc.detalhes = self.arrayNoticias.first
//        vc.imageNoticia = self.imageViewHeaderNoticia.image
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}
