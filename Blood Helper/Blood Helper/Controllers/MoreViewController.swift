//
//  MoreViewController.swift
//  Blood Helper
//
//  Created by MacOS on 19/04/23.
//

import UIKit

class MoreViewController: UIViewController {

    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomStack: UIStackView!
    
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var seetingsLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutButton.layer.cornerRadius = 8
    }
    

    @IBAction func homeButtonPressed(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    @IBAction func contactButtonPressed(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    @IBAction func moreButtonPressed(_ sender: Any) {
      
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        let mainVC = UINavigationController(rootViewController: controller)
        
       
      
    }
    
    

}
