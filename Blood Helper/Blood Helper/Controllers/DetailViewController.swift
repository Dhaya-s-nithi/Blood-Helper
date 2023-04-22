//
//  DetailViewController.swift
//  Blood Helper
//
//  Created by MacOS on 11/04/23.
//

import UIKit


class DetailViewController: UIViewController, CAAnimationDelegate{
    
    @IBOutlet weak var bloodImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var availabilityLabel: UILabel!
    
    var user = Database()
    
    var userName = ""
    var userPhone = ""
    var userGender = ""
    var userBloodImage = UIImage()
    var userAvailability = ""
    var Chance = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showDetail()
        configureUI()
        
        print(UserDefaults.standard.string(forKey: "BloodAvailable"))
        
        // Do any additional setup after loading the view.
    }
 
    
    func showDetail(){
        
        name.text = userName
        phone.text = userPhone
        gender.text = userGender
        availabilityLabel.text = userAvailability
        bloodImage.image = userBloodImage
        
      
    }
    
    func configureUI(){
        
        detailView.layer.cornerRadius = 8
        detailView.layer.shadowColor = UIColor.gray.cgColor
        detailView.layer.shadowOffset = CGSize(width: 5, height: 5)
        detailView.layer.shadowRadius = 10
        detailView.layer.shadowOpacity = 0.4
        detailView.layer.shadowPath = nil
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        

        let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let transition = CATransition.init()
        transition.duration = 0.45
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.moveIn //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(controller, animated: true)
        self.dismiss(animated: true)
    }
    
}
