//
//  NoticiaTableViewCell.swift
//  desafio-apps-iOS
//
//  Created by Neto Moura on 30/10/2017.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit

class NoticiaTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewNoticia: UIImageView!
    @IBOutlet weak var labelSecaoNoticia: UILabel!
    @IBOutlet weak var labelTituloNoticia: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
