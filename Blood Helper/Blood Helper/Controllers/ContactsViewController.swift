//
//  ContactsViewController.swift
//  Blood Helper
//
//  Created by MacOS on 19/04/23.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var ContactTableView: UITableView!
    
    @IBOutlet weak var contactlabel: UILabel!
    
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
 
    
    var contactDetails = [PatientDetails]()
    
    var bloodtype = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var contactStore = CNContactStore()
    var contacts = [contactModel]()
    
    var countryCode = "+91"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        ContactTableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
        
        ContactTableView.delegate = self
        ContactTableView.dataSource = self
        
        contactlabel.isHidden = true
//        ContactTableView.isHidden = true
       
        contactDetails = Database().getContactData()
        
//
//        if contactDetails.count > 0{
//            ContactTableView.isHidden = false
//            contactlabel.isHidden = true
//        }
//
//        print("The Count is \(contactDetails.count)")
//
        
        
        contactStore.requestAccess(for: .contacts) { success, error in
            if success{
                print("Contacts Authorized")
            }else if error != nil{
                print(error!.localizedDescription)
            }
        }
        
        fetchContacts()
        
    }
    func fetchContacts(){
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: key)
        
        do{
               try? contactStore.enumerateContacts(with: request) { contact, stoppingPointer in
                let name = contact.givenName
                let familyName = contact.familyName
                let number = contact.phoneNumbers.first?.value.stringValue
                
                let contactToAppend = contactModel(givenName: name, familyName: familyName, contactNumber: number!)
                
                self.contacts.append(contactToAppend)
//                   self.contacts.append(contactDetails)
            }
        }
        catch{
            print(error.localizedDescription)
        }
        ContactTableView.reloadData()
        
    }
    
    
    

    
    @IBAction func homeButtonPressed(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    
    @IBAction func contactButtonPressed(_ sender: Any) {
        
        
    }
    
    
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contactsToDisplay = contacts[indexPath.row]
        
        let cell = ContactTableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        
        cell.tag = indexPath.row
        cell.ContactName.text = contactsToDisplay.givenName + " " + contactsToDisplay.familyName
        cell.ContactPhone.text = contactsToDisplay.contactNumber

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contactsToDisplay = contacts[indexPath.row]
        
        var mobile = contactsToDisplay.contactNumber
        
        let call = UIContextualAction(style: .normal, title: nil) { [self] _, _, _ in
            
            if let phoneCallURL = URL(string: "tel://\(mobile)") {
                
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }
        
        let message = UIContextualAction(style: .normal, title: nil) { [self] _, _, _ in
            
            
            let popup = UIAlertController(title: "Patient's Details", message: "Please Enter the Patient's Details Carefully!", preferredStyle: .alert)
            
            popup.addTextField()
            popup.addTextField()
            popup.addTextField()
            
            popup.textFields![0].placeholder = "Enter Patient's Name"
            popup.textFields![0].borderStyle = .roundedRect
            popup.textFields![0].layer.cornerRadius = 8
            popup.textFields![0].enablesReturnKeyAutomatically = true
            
            popup.textFields![1].placeholder = "Enter Patient's Mobile Number"
            popup.textFields![1].borderStyle = .roundedRect
            popup.textFields![1].layer.cornerRadius = 8
            popup.textFields![1].enablesReturnKeyAutomatically = true
            
            popup.textFields![2].placeholder = "Enter Patient's Hospital Name"
            popup.textFields![2].borderStyle = .roundedRect
            popup.textFields![2].layer.cornerRadius = 8
            popup.textFields![2].enablesReturnKeyAutomatically = true
            
            popup.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            popup.addAction(UIAlertAction(title: "Send", style: .default, handler: { action in
                
                // Getting Patient Details
                
                let name = popup.textFields![0].text
                let number = popup.textFields![1].text
                let hospital = popup.textFields![2].text
                
                // Sending Patient Detials to the Donar
                if((name != "") && (number != "") && (hospital != "")){
                    whatsapp(mobile: contactsToDisplay.contactNumber, PatientName: name!, PatientNumber: number!, PatientLocation: hospital!)
                    
                }else{
                    
                    let alert = UIAlertController(title: "Empty Data", message: "Please fill the details", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alert, animated: true)
                }
                
                
            }))
            
            self.present(popup, animated: true)
        }
    
        let share = UIContextualAction(style: .normal, title: nil) { [self] _, _, _ in
    
            let name = contactsToDisplay.givenName
            let mNumber = contactsToDisplay.contactNumber
        
            
                        var message = "Please contact \(name) and their's mobile number is \(mNumber)"
            
                        let share = UIActivityViewController(activityItems: [
                            message
                        ], applicationActivities: nil)
                //
                        self.present(share, animated: true)
            
            print("Share is present")
        }
            
            
            call.image = UIImage(systemName: "phone.fill")
            call.backgroundColor = #colorLiteral(red: 0.001803004649, green: 0.6715067625, blue: 0.399060905, alpha: 1)
            
            message.image = UIImage(systemName: "message.fill")
            message.backgroundColor = #colorLiteral(red: 0.550515861, green: 0.557579542, blue: 1, alpha: 1)
            
            share.image = UIImage(systemName: "square.and.arrow.up.fill")
            share.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.631372549, blue: 0.9490196078, alpha: 1)
            
            
            let swipe = UISwipeActionsConfiguration(actions: [call, message, share])
            
            return swipe
        }
    
    
    func whatsapp(mobile: String, PatientName: String, PatientNumber: String, PatientLocation: String){
       
        var contactNumber = mobile
        let removeCharacters: Set<Character> = ["-", " "]
        contactNumber.removeAll(where: { removeCharacters.contains($0) } )
        print(contactNumber)
        
       var message = "Blood in Need for \(PatientName) and Their Contact Number is \(PatientNumber) and They are in \(PatientLocation)"
       
       let whatsappURL = "https://api.whatsapp.com/send?phone=\(countryCode)\(contactNumber)&text=\(message)"
       
       let whatsappURLEncoded = whatsappURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
       
       let url = NSURL(string: whatsappURLEncoded!)
       
       if UIApplication.shared.canOpenURL(url! as URL){
           print("Opening whatsapp")
           
           UIApplication.shared.open(url! as URL, options: [:]){ status in
               print("Opened whatsapp")
 
           }
       }else{
           print("Can't open whatsapp")
       }
   }

}



struct contactModel: Codable{
    let givenName: String
    let familyName: String
    let contactNumber : String
}


