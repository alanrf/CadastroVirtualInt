//
//  TarefaViewCell.swift
//  CadastroVirtual
//
//  Created by Alan Fritsch on 14/04/19.
//  Copyright © 2019 Alan Fritsch. All rights reserved.
//

import UIKit

@objc protocol TarefaCellDelegate: class {
    func checkmarkTapped(sender: TarefaViewCell)
}

class TarefaViewCell: UITableViewCell {

    var delegate: TarefaCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var lbData: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    @IBAction func completeButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }

}
