//
//  LoginViewController.swift
//  Blood Helper
//
//  Created by MacOS on 06/04/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    
    @IBOutlet var loginview: UIView!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var user:UserDetails?
    
    var verificationId:String = ""
   
    var result = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneField.delegate = self
        passwordField.delegate = self
        
        
        configureUI()

        if UserDefaults.standard.bool(forKey: "IsUserLoggedIn") == true {
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: false)
        }
        // Do any additional setup after loading the view.
    }
    
    func configureUI(){
        loginview.layer.cornerRadius = 8
        loginview.layer.shadowColor = UIColor.gray.cgColor
        loginview.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginview.layer.shadowRadius = 10
        loginview.layer.shadowOpacity = 0.4
        loginview.layer.shadowPath = nil
        
        phoneField.layer.cornerRadius = 8
        phoneField.layer.borderWidth = 1
        phoneField.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        
        passwordField.layer.cornerRadius = 8
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        
        loginButton.layer.cornerRadius = 8
        
        
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        controller.modalPresentationStyle = .fullScreen
        //        controller.modalTransitionStyle =
        self.present(controller, animated: true)
        
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {

        if phoneField.hasText == false && passwordField.hasText == false{
            alert(title: "Empty Fields", message: "Please fill all the fields")
        }else{
            
            CheckForUserNameAndPasswordMatch(mobile: phoneField.text!, password: passwordField.text!)
        }
    }
    func CheckForUserNameAndPasswordMatch( mobile: String, password : String){
        let app = UIApplication.shared.delegate as! AppDelegate
        
        let context = app.persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetails")
        
        let predicate = NSPredicate(format: "mobile = %@", mobile)
        
        fetchrequest.predicate = predicate
        do
        {
            result = try context.fetch(fetchrequest) as NSArray
            
            if result.count>0
            {
                let objectentity = result.firstObject as! UserDetails
                
                if objectentity.mobile == mobile && objectentity.password == password
                {
                    UserDefaults.standard.set(true, forKey: "IsUserLoggedIn")
                    
                    let controller = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
                }
                else
                {
                    alert(title: "Wrong mobile number or password", message: "Please enter correct phone number or password")
                }
            }else{
                alert(title: "User not found", message: "Please register to continue!")
            }
        }
        
        catch
        {
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }
        
    }
    
    
    func alert(title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
}


extension LoginViewController: UISearchTextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       if textField == passwordField{
            passwordField.resignFirstResponder()
        }
        return true
    }
}
