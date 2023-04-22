//
//  ViewController.swift
//  Blood Helper
//
//  Created by MacOS on 06/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var createaccountButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signinButton.layer.cornerRadius = 8
        
        configureUI()
    }

    
    func configureUI(){
        createaccountButton.layer.cornerRadius = 8
        createaccountButton.layer.borderColor = UIColor.white.cgColor
        createaccountButton.layer.borderWidth = 1
    }
    

    @IBAction func SignInButtonPressed(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
    }
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
}

