//
//  TarefaViewCell.swift
//  CadastroVirtual
//
//  Created by Alan Fritsch on 14/04/19.
//  Copyright © 2019 Alan Fritsch. All rights reserved.
//

import UIKit

class TarefaViewCell: UITableViewCell {

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
    
}
