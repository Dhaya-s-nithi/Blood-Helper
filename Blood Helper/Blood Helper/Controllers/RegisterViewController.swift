//
//  RegisterViewController.swift
//  Blood Helper
//
//  Created by MacOS on 06/04/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var registerview: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var genderView: UIView!
    
    @IBOutlet weak var bloodtypeview: UIView!
    @IBOutlet weak var genderlabel: UILabel!
    @IBOutlet weak var namefield: UITextField!
    
    @IBOutlet weak var femalebutton: UIButton!
    @IBOutlet weak var malebutton: UIButton!
    @IBOutlet weak var phonefield: UITextField!
    
    @IBOutlet weak var otpfield: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var cpasswordfield: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var bloodgroupbutton: UIButton!
    
    @IBOutlet weak var bloodlabel: UILabel!
    
    @IBOutlet weak var availabilityView: UIView!
    @IBOutlet weak var availabilityProgressView: UIProgressView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var gender: String = ""
    
    var bloodtype = ""
    
    var userAvailable:String = ""
    
    let userdefaults = UserDefaults.standard
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureUI()
        SetupRadioButton()
        print(gender)
        bloodtypeview.isHidden = true
        
        availabilityProgressView.progress = 0.0
        
        namefield.delegate = self
        phonefield.delegate = self
        passwordField.delegate = self
        cpasswordfield.delegate = self
        

    }
    
    
    func SetupRadioButton(){
        malebutton.layer.borderColor = UIColor.gray.cgColor
        malebutton.layer.borderWidth = 1
        malebutton.layer.cornerRadius = 8
       
        malebutton.setTitle("Male", for: .normal)
        malebutton.setTitleColor(.black, for: .normal)
        
        femalebutton.layer.borderColor = UIColor.gray.cgColor
        femalebutton.layer.borderWidth = 1
        femalebutton.layer.cornerRadius = 8
        femalebutton.setTitleColor(.black, for: .normal)
        femalebutton.setTitle("Female", for: .normal)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        
        if ((namefield.hasText == true) && (phonefield.hasText == true) && (passwordField.hasText == true) && (cpasswordfield.hasText == true) && (gender != nil) && (bloodtype != nil) && (availabilityProgressView != nil)){
            if((passwordField.text) == (cpasswordfield.text)){
                createData()
                let controller  = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }else{
                alert(title: "Password not match", message: "Please check both the passwords are same!")
            }
        }else{
            alert(title: "Fields are empty", message: "Please fill all the fields")
        }
        
        print(userdefaults.string(forKey: "Phone"))
        
    }
   
    @IBAction func bloodgroupButtonPressed(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "BloodTypeViewController") as! BloodTypeViewController
        controller.blood_Delegate = self
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
    }
    
    
    @IBAction func femalebuttonPressed(_ sender: Any) {
        
        femalebutton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        femalebutton.backgroundColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        femalebutton.setTitleColor(.white, for: .normal)
        femalebutton.layer.borderWidth = 2
        femalebutton.layer.cornerRadius = 8
        
        
        gender = "Female"
        
        malebutton.layer.borderColor = UIColor.gray.cgColor
        malebutton.titleLabel?.textColor = UIColor.black
        malebutton.layer.borderWidth = 1
        malebutton.layer.cornerRadius = 8
        malebutton.backgroundColor = .white
        
        print(gender)
      
        
    }
    
    @IBAction func malebuttonPressed(_ sender: Any) {
      
        malebutton.layer.cornerRadius = 8
        malebutton.layer.borderWidth = 2
        malebutton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        malebutton.backgroundColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        malebutton.setTitleColor(.white, for: .normal)
        
        gender = "Male"
        
        femalebutton.layer.borderColor = UIColor.gray.cgColor
        femalebutton.layer.borderWidth = 1
        femalebutton.titleLabel?.textColor = UIColor.black
        femalebutton.layer.cornerRadius = 8
        femalebutton.backgroundColor = .white
        print(gender)
       
    }
    
    
    func configureUI(){
        registerview.layer.cornerRadius = 8
        registerview.layer.shadowColor = UIColor.gray.cgColor
        registerview.layer.shadowOffset = CGSize(width: 5, height: 5)
        registerview.layer.shadowRadius = 10
        registerview.layer.shadowOpacity = 0.4
        registerview.layer.shadowPath = nil
        
        namefield.layer.cornerRadius = 8
        namefield.layer.borderWidth = 1
        namefield.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        namefield.attributedPlaceholder = NSAttributedString(string: "Fullname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        phonefield.layer.cornerRadius = 8
        phonefield.layer.borderWidth = 1
        phonefield.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        phonefield.attributedPlaceholder = NSAttributedString(string: "Mobile Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        otpfield.layer.cornerRadius = 8
        otpfield.layer.borderWidth = 1
        otpfield.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        otpfield.attributedPlaceholder = NSAttributedString(string: "OTP", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        passwordField.layer.cornerRadius = 8
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        cpasswordfield.layer.cornerRadius = 8
        cpasswordfield.layer.borderWidth = 1
        cpasswordfield.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        cpasswordfield.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
   
        genderView.layer.cornerRadius = 8
        genderView.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        genderView.layer.borderWidth = 1
        
        bloodgroupbutton.layer.cornerRadius = 8
        bloodgroupbutton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        bloodgroupbutton.layer.borderWidth = 1
        bloodgroupbutton.setTitle("Blood Group", for: .normal)
        bloodgroupbutton.setTitleColor(.black, for: .normal)
        
        registerButton.layer.cornerRadius = 8
        
        bloodtypeview.layer.cornerRadius = 8
       
        availabilityView.layer.cornerRadius = 8
        availabilityView.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        availabilityView.layer.borderWidth = 1
        
        genderlabel.textColor = .black
        
    }
    
    
    func createData(){
        
        print("function called")

        Database().saveData(name: namefield.text!, phone: phonefield.text!, password: passwordField.text!, ConfirmPassword: cpasswordfield.text!, gender: gender, bloodtype: bloodtype, available: userAvailable)
        
        userdefaults.setValue(phonefield.text, forKey: "Phone Number")
        
    }
    
    func alert(title:String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        controller.modalPresentationStyle = .automatic
        self.present(controller, animated: true)
    }
    
}


extension RegisterViewController: BloodTypeViewControllerDelegate{
    
    
    
    func didvaluesgot(bloodgroup: String, availability: String, chance: Float) {
        
        bloodtype = bloodgroup
        print(bloodtype)
        print("\(availability)")
        userdefaults.setValue(availability, forKey: "BloodAvailable")
        bloodlabel.text = "\(bloodtype)"
        bloodtypeview.isHidden = false
       userAvailable = availability
        
        print(availability)
        print(userAvailable)
        print(chance)
        if chance == 100.0{
            availabilityProgressView.progress = 1.0
        }else if chance == 50.0{
            availabilityProgressView.progress = 0.5
        }else{
            availabilityProgressView.progress = 0.4
        }
    }
    
}


extension RegisterViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let count = 10
        
        if textField == phonefield{
            let allowedChars = "9876543210"
            let charsSet = CharacterSet(charactersIn: allowedChars)
            let typedChars = CharacterSet(charactersIn: string)
            let numbers = charsSet.isSuperset(of: typedChars)
            
            return numbers
        }

        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == namefield{
            phonefield.becomeFirstResponder()
        }else if textField == otpfield{
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            cpasswordfield.becomeFirstResponder()
        }else if textField == cpasswordfield{
            cpasswordfield.resignFirstResponder()
        }
        return false
    }
}


protocol RegisterViewControllerdelegate{
    
    func sendBloodValue(bloodgroup: String)
    
}
