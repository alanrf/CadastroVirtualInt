//
//  TarefaViewController.swift
//  CadastroVirtual
//
//  Created by Alan Fritsch on 14/04/19.
//  Copyright © 2019 Alan Fritsch. All rights reserved.
//

import UIKit

class TarefaViewController: UITableViewController {
    
    var isPickerHidden = true
    var tarefa : Tarefa?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = tarefa {
            navigationItem.title = "Atualizar Tarefa"
            
            edTitulo.text = todo.titulo
            edResponsavel.text = todo.responsavel
            datePickerDataLimite.date = todo.dataLimite
            edDescricao.text = todo.descricao
        } else {
            datePickerDataLimite.date = Date().addingTimeInterval(24*60*60)
        }
        atualizaDataLimite(date: datePickerDataLimite.date)
        atualizaEstadoBotaoSalvar()
    }

    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let titulo = edTitulo.text!
        let dataLimite = datePickerDataLimite.date
        let descricao = edDescricao.text!
        let responsavel = edResponsavel.text!
        
        tarefa = Tarefa(titulo: titulo, descricao: descricao, dataLimite: dataLimite, responsavel: responsavel)
        
//        self.btSalvar.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//        
//        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
//            self.btSalvar.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
//        }, completion: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt
        indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
        case [2,0]: //Data Limite
            return isPickerHidden ? normalCellHeight :
            largeCellHeight
            
        case [3,0]: //Descricao
            return largeCellHeight
        default: return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        switch (indexPath) {
        case [2,0]:
            isPickerHidden = !isPickerHidden
            
            lbDataLimite.textColor =
                isPickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default: break
        }
    }
    
    func atualizaDataLimite(date: Date) {
        lbDataLimite.text = Tarefa.dateFormatter.string(from: date)
    }
    
    func atualizaEstadoBotaoSalvar() {
        let text = edTitulo.text ?? ""
        btSalvar.isEnabled = !text.isEmpty
    }
    
    @IBOutlet weak var edTitulo: UITextField!
    @IBOutlet weak var edResponsavel: UITextField!
    @IBOutlet weak var lbDataLimite: UILabel!
    @IBOutlet weak var datePickerDataLimite: UIDatePicker!
    @IBOutlet weak var edDescricao: UITextView!
    @IBOutlet weak var btSalvar: UIBarButtonItem!
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        atualizaDataLimite(date: datePickerDataLimite.date)
    }
    
    
    @IBAction func edTituloAlterado(_ sender: UITextField) {
        atualizaEstadoBotaoSalvar()
    }
}
