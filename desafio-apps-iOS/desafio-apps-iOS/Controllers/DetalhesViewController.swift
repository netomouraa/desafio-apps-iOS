//
//  DetailsViewController.swift
//  desafio-apps-iOS
//
//  Created by Neto Moura on 30/10/2017.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelSubtitulo: UILabel!
    @IBOutlet weak var labelAutor: UILabel!
    @IBOutlet weak var labelData: UILabel!
    @IBOutlet weak var imageViewNoticia: UIImageView!
    @IBOutlet weak var labelLegenda: UILabel!
    @IBOutlet weak var textViewTexto: UITextView!
    
    var detalhes: Conteudos?
//    var imageNoticia: UIImage?
//    var cache = NSCache<AnyObject, AnyObject>()
//    var imageViewCache: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detalhesNoticia()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func detalhesNoticia(){
        navigationItem.title = detalhes?.secao?.nome?.uppercased()

        
        self.labelTitulo.text = detalhes?.titulo
        self.labelSubtitulo.text = detalhes?.subTitulo
        
        var autor: String?
        if detalhes?.tipo == "linkExterno" || (detalhes?.autores?.isEmpty)! {
            autor = "AUTOR DESCONHECIDO"
        } else {
            autor = detalhes?.autores?[0]
        }
        
        if (detalhes?.imagens?.isEmpty)! {
            self.imageViewNoticia.image = UIImage(named: "naodisponivel.png")
        } else {
            for item in detalhes!.imagens! {
                self.imageViewNoticia.downloadedFrom(link: item.url!)
                self.labelLegenda.text = "\(item.legenda!). Foto: \(item.fonte!)"
            }
        }
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: "POR \(autor!.uppercased())")
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red: 60/255.0, green: 160/255.0, blue: 200.0/255.0, alpha: 1.0), range: NSRange(location:4,length:(autor?.characters.count)!))
        self.labelAutor.attributedText = myMutableString
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-0300"
        let date = dateFormatter.date(from: (detalhes?.publicadoEm)!)!
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from: date)
        
        let dataString = NSMutableAttributedString(string: "")
        let image1Attachment = NSTextAttachment()
        let imageWatch = UIImage(named: "watch.png")
        image1Attachment.image = imageWatch
        let image1String = NSAttributedString(attachment: image1Attachment)
        dataString.append(image1String)
        dataString.append(NSAttributedString(string: " \(dateString)"))
        self.labelData.attributedText = dataString
        
//        if imageNoticia != nil {
//        self.imageViewNoticia.image = imageNoticia
//        } else {
//            self.imageViewNoticia.image = UIImage(named: "naodisponivel.png")
//        }
//        self.labelLegenda.text = detalhes?.imagens
        self.textViewTexto.text = detalhes?.texto
    }

}
