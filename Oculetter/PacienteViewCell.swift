//
//  PacienteViewCell.swift
//  Oculetter
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 Universidad de Almeria. All rights reserved.
//

import UIKit

class PacienteViewCell: UITableViewCell {
    
    //MARK: propiedades
    
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var edad: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
