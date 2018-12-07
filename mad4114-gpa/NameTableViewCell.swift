//
//  NameTableViewCell.swift
//  mad4114-gpa
//
//  Created by Allan Im on 2018-12-07.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var txtName: UITextField!
    
    var editStudent: StudentEntity!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        txtName.addTarget(self, action: #selector(self.textFieldDidChange(sender:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(sender: UITextField){
        editStudent.name = sender.text
    }

}
