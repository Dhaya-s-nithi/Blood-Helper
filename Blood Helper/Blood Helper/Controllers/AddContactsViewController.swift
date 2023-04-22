//
//  AddContactsViewController.swift
//  Blood Helper
//
//  Created by MacOS on 18/04/23.
//

import UIKit

class AddContactsViewController: UIViewController {

    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var mobileField: UITextField!
    
    @IBOutlet weak var bloodTypeButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var bloodtypeview: UIView!
    
    @IBOutlet weak var bloodlabel: UILabel!
    
    
    var bloodGroup = ""
    
    var userdefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
        
        bloodtypeview.isHidden = true
        
        
    
    }
    
    func configureUI(){
        
        nameField.layer.cornerRadius = 8
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        nameField.attributedPlaceholder = NSAttributedString(string: "Fullname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        mobileField.layer.cornerRadius = 8
        mobileField.layer.borderWidth = 1
        mobileField.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        mobileField.attributedPlaceholder = NSAttributedString(string: "Mobile Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        bloodTypeButton.layer.cornerRadius = 8
        bloodTypeButton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        bloodTypeButton.layer.borderWidth = 1
        bloodTypeButton.setTitle("Blood Group", for: .normal)
        bloodTypeButton.setTitleColor(.black, for: .normal)
        
        bloodtypeview.layer.cornerRadius = 8
        
        saveButton.layer.cornerRadius = 8
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        
        self.dismiss(animated: true)
    }
    
    
    @IBAction func bloodtypeButtonPressed(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "BloodTypeViewController") as! BloodTypeViewController
        controller.modalPresentationStyle = .formSheet
        controller.blood_Delegate = self
        self.present(controller, animated: true)
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if((nameField.text != "") && (mobileField.text != "") && bloodGroup != "" ){
            createData()
            self.dismiss(animated: true)
        }else{
            
            let alert = UIAlertController(title: "Empty Data", message: "Please Fill all the fields", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true)
        }
 
    }
    
    func createData(){
        
        print("function called")

        Database().saveContactData(ContactName: nameField.text!, ContactPhone: mobileField.text!, ContactBloodGroup: bloodGroup)
        
        userdefaults.setValue(nameField.text, forKey: "ContactName")
        userdefaults.setValue(mobileField.text, forKey: "ContactPhone")
        userdefaults.setValue(bloodGroup, forKey: "ContactBloodGroup")
       print(bloodGroup)
    }
    
    
    
}


extension AddContactsViewController: BloodTypeViewControllerDelegate{
    func didvaluesgot(bloodgroup: String, availability: String, chance: Float) {
        
        bloodGroup = bloodgroup
        print(availability)
        bloodtypeview.isHidden = false
        
        bloodlabel.text = bloodGroup
    }
}
