//
//  TarefaTableViewController.swift
//  CadastroVirtual
//
//  Created by Alan Fritsch on 14/04/19.
//  Copyright © 2019 Alan Fritsch. All rights reserved.
//

import UIKit

class TarefaTableViewController: UITableViewController {

    var gerenciadorTarefa = GerenciadorTarefa()
    
    @IBAction func unwindToTarefaList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! TarefaViewController
        
        if let tarefa = sourceViewController.tarefa {
            if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                gerenciadorTarefa.tarefas[selectedIndexPath.row] = tarefa
                tableView.reloadRows(at: [selectedIndexPath],
                                     with: .none)
            } else {
                let newIndexPath = IndexPath(row: gerenciadorTarefa.tarefas.count,
                                             section: 0)
                gerenciadorTarefa.tarefas.append(tarefa)
                tableView.insertRows(at: [newIndexPath],
                                     with: .automatic)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gerenciadorTarefa.tarefas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? TarefaViewCell else {
            fatalError("Could not dequeue a cell")
        }

        let tarefa = gerenciadorTarefa.tarefas[indexPath.row]
        cell.lbTitulo.text = tarefa.titulo
        cell.lbData.text = Tarefa.dateFormatter.string(from: tarefa.dataLimite)

        return cell
    }
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gerenciadorTarefa.tarefas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let tarefaViewController = segue.destination
                as! TarefaViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let tarefaSelecionada = gerenciadorTarefa.tarefas[indexPath.row]
            tarefaViewController.tarefa = tarefaSelecionada
        }
    }
    
    
    

}
