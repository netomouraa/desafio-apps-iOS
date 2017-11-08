//
//  Noticia.swift
//  desafio-apps-iOS
//
//  Created by Neto Moura on 30/10/2017.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit

struct Capa: Decodable {
    var conteudos: [Conteudos]?
}

struct Conteudos: Decodable {
    var autores: [String]?
    var informePublicitario: Bool?
    var subTitulo: String?
    var texto: String?
    var videos: [Videos]?
    var atualizadoEm: String?
    var id: Int?
    var publicadoEm: String?
    var secao: Secao?
    var tipo: String?
    var titulo: String?
    var url: String?
    var urlOriginal: String?
    var imagens: [Imagens]?
}

struct Imagens: Decodable {
    var autor: String?
    var fonte: String?
    var legenda: String?
    var url: String?
}

struct News: Decodable {
    var conteudos: [Conteudos]?
    var produto: String?
}

struct Secao: Decodable {
    var nome: String?
    var url: String?
}

struct Videos: Decodable {
    var title: String?
}



