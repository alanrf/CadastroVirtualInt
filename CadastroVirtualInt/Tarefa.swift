//
//  Tarefa.swift
//  CadastroVirtual
//
//  Created by Alan Fritsch on 14/04/19.
//  Copyright © 2019 Alan Fritsch. All rights reserved.
//

import Foundation

public class Tarefa {
    var dataCriacao = Date()
    var titulo : String
    var descricao : String
    var dataLimite : Date
    var responsavel : String
    
    init(titulo : String, descricao : String, dataLimite : Date, responsavel : String) {
        self.titulo = titulo
        self.descricao = descricao
        self.dataLimite = dataLimite
        self.responsavel = responsavel
    }
    
    func toString() -> String {
        return "Titulo: \(titulo), Responsavel: \(responsavel), data limite: \(dataLimite)"
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}
