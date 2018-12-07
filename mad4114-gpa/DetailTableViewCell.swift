//
//  DetailTableViewCell.swift
//  mad4114-gpa
//
//  Created by Allan Im on 2018-12-06.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lbKey: UILabel!
    @IBOutlet weak var lbValue: UITextField!
    
    var editGrade: GradeEntity!
    
    var markPicker = UIPickerView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        pickUpMark(lbValue)
    }
    
    func pickUpMark(_ textField : UITextField){
        
        self.markPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.frame.size.width, height: 300))
        self.markPicker.backgroundColor = .white
        self.markPicker.delegate = self
        textField.inputView = self.markPicker
        
        if let markText = textField.text {
            markPicker.selectRow(StudentStore.rowMarkList(markText), inComponent: 0, animated: true)
        }
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.pickerDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.pickerCancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc private func pickerDoneClick() {
        let mark = StudentStore.markList[markPicker.selectedRow(inComponent: 0)]
        editGrade.gradePoint = mark.getPoint()
        lbValue.text = mark.rawValue
        lbValue.resignFirstResponder()
    }
    
    @objc func pickerCancelClick() {
        lbValue.resignFirstResponder()
    }

}


extension DetailTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return StudentStore.markList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return StudentStore.markList[row].rawValue
    }
    
}
