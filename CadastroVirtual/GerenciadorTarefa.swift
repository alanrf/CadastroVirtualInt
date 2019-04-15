//
//  GerenciadorTarefa.swift
//  CadastroVirtual
//
//  Created by Alan Fritsch on 14/04/19.
//  Copyright © 2019 Alan Fritsch. All rights reserved.
//

import Foundation

public class GerenciadorTarefa {
    var tarefas = [Tarefa]()
    
    public func listaTarefas() {
        for tar in tarefas {
            print(tar.toString())
        }
    }
    
    public func procuraTarefa(tituloTarefa: String) -> Tarefa? {
        let pos = tarefas.first(where: {$0.titulo == tituloTarefa});
        if (pos != nil) {
            return pos
        } else {
            return nil
        }
    }
    
    public func ordenarPorDataLimite() {
        tarefas = tarefas.sorted(by: { ComparisonResult.orderedAscending == $0.dataLimite.compare($1.dataLimite) })
    }
}
