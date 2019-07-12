//
//  ContactViewController.swift
//  Core Data App
//
//  Created by Guangzu on 7/11/19.
//  Copyright © 2019 Guangzu. All rights reserved.
//

import UIKit
import CoreData

class ContactViewController: UIViewController {

  
    @IBOutlet weak var contactTableView: UITableView!
    
    let dateFormatter = DateFormatter()

    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        do{
        contacts = try managedContext.fetch(fetchRequest)
            
        contactTableView.reloadData()
        } catch{
            print("Fetch could not be performed")
        }
        
        
        
    }

    @IBAction func addNewContact(_ sender: Any) {
        performSegue(withIdentifier:"showContact", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleContactViewController,
            let selectedRow = self.contactTableView.indexPathForSelectedRow?.row else{
                return
        }
        
        destination.existingContact = contacts[selectedRow]
    }
    
    func deleteContract(at indexPath: IndexPath){
        let contact = contacts[indexPath.row]

        if let managedContext = contact.managedObjectContext{
            managedContext.delete(contact)

            do{
                try managedContext.save()

                self.contacts.remove(at: indexPath.row)

                contactTableView.deleteRows(at: [indexPath], with: .automatic)

            } catch {
                print("Delete failed")
                contactTableView.reloadRows(at: [indexPath], with: .automatic)
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

extension ContactViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactTableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath)
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name
        if let date = contact.date{
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteContract(at: indexPath)
        }
    }
}

extension ContactViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "showContact", sender:self)
    }
}
