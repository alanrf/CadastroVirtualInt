//
//  TarefaTableViewController.swift
//  CadastroVirtual
//
//  Created by Alan Fritsch on 14/04/19.
//  Copyright © 2019 Alan Fritsch. All rights reserved.
//

import UIKit
import CoreData

class TarefaTableViewController: UITableViewController {

    
    //var gerenciadorTarefa = GerenciadorTarefa()
    fileprivate var tarefasDB : [NSManagedObject] = []
    
    @IBAction func unwindToTarefaList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! TarefaViewController

        //TODO sera trocado pela chamada de salvar no DB
        if let tarefaDetalhe = sourceViewController.tarefa {
            if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                let tarefaDB = tarefasDB[selectedIndexPath.row] as! TarefaDB
                updateTarefaDB(tarefa: tarefaDetalhe, tarefaDB: tarefaDB)
            } else {
                saveTarefaDB(tarefa: tarefaDetalhe)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTarefasFromDB()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefasDB.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? TarefaViewCell else {
            fatalError("Could not dequeue a cell")
        }

        let tarefa = tarefasDB[indexPath.row]
        cell.lbTitulo.text = tarefa.value(forKeyPath: "titulo") as? String
        cell.lbData.text = Tarefa.dateFormatter.string(from: (tarefa.value(forKeyPath: "dataLimite") as? Date)!)

        return cell
    }
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTarefaDB(index: indexPath.row)
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
            let tarefaSelecionada = tarefasDB[indexPath.row]
            
            let tarefa = Tarefa(titulo: (tarefaSelecionada.value(forKeyPath: "titulo") as? String)!,
                                descricao: (tarefaSelecionada.value(forKeyPath: "descricao") as? String)!,
                                dataLimite: (tarefaSelecionada.value(forKeyPath: "dataLimite") as? Date)!,
                                responsavel: (tarefaSelecionada.value(forKeyPath: "responsavel") as? String)!)
            
            tarefaViewController.tarefa = tarefa
        }
    }
    
    // MARK: - Custom methods
    func getTarefasFromDB() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TarefaDB")
            do {
                tarefasDB = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Não foi possível buscar a entidade TarefasDB \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveTarefaDB(tarefa : Tarefa) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "TarefaDB",
                                                in: managedContext)!
        
        let tarefaDB = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
        tarefaDB.setValue(tarefa.titulo, forKeyPath: "titulo")
        tarefaDB.setValue(tarefa.descricao, forKeyPath: "descricao")
        tarefaDB.setValue(tarefa.responsavel, forKeyPath: "responsavel")
        tarefaDB.setValue(tarefa.dataCriacao, forKeyPath: "dataCriacao")
        tarefaDB.setValue(tarefa.dataLimite, forKeyPath: "dataLimite")
        
        do {
            try managedContext.save()
            tarefasDB.append(tarefaDB)
        } catch let error as NSError {
            print("Erro ao salvar: \(error), \(error.userInfo)")
        }
    }
    
    func updateTarefaDB(tarefa : Tarefa, tarefaDB : TarefaDB) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        tarefaDB.setValue(tarefa.titulo, forKeyPath: "titulo")
        tarefaDB.setValue(tarefa.descricao, forKeyPath: "descricao")
        tarefaDB.setValue(tarefa.responsavel, forKeyPath: "responsavel")
        //tarefaDB.setValue(tarefa.dataCriacao, forKeyPath: "dataCriacao")
        tarefaDB.setValue(tarefa.dataLimite, forKeyPath: "dataLimite")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Erro ao atualizar: \(error), \(error.userInfo)")
        }
    }
    
    func deleteTarefaDB(index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            managedContext.delete(tarefasDB[index])
            tarefasDB.remove(at: index)
            try managedContext.save()
        } catch let error as NSError {
            print("Erro ao atualizar: \(error), \(error.userInfo)")
        }
    }
    

}
