//
//  SingleContactViewController.swift
//  Core Data App
//
//  Created by Guangzu on 7/11/19.
//  Copyright © 2019 Guangzu. All rights reserved.
//

import UIKit

class SingleContactViewController: UIViewController{

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var existingContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
        
        nameTextField.text = existingContact?.name
        
        if let phone = existingContact?.phone{
            phoneTextField.text = "\(phone)"
        }
        
        if let date = existingContact?.date{
            datePicker.date = date
        }
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
   
    @IBAction func saveContact(_ sender: Any) {
        let name = nameTextField.text
        let phoneText = phoneTextField.text ?? ""
        let phone = Int64(phoneText)
        let date = datePicker.date
        
        var contact:Contact?
        
        if let existingContact = existingContact{
            existingContact.name = name
            existingContact.phone = phone ?? 0
            existingContact.date  = date
            
            contact = existingContact
        } else{
            contact = Contact(name: name, phone: phone ?? 0, date: date)
        }
        
        
        if let contact = contact{
            do {
                let managedContext = contact.managedObjectContext
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("Phone number never be saved")
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension SingleContactViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
