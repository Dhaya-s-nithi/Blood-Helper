//
//  BloodTypeViewController.swift
//  Blood Helper
//
//  Created by MacOS on 07/04/23.
//

import UIKit

protocol BloodTypeViewControllerDelegate{
    func didvaluesgot(bloodgroup: String, availability: String, chance: Float)
}


class BloodTypeViewController: UIViewController {
    
    @IBOutlet weak var Abutton: UIButton!
    
    @IBOutlet weak var Bbutton: UIButton!
    
    @IBOutlet weak var Obutton: UIButton!
    
    @IBOutlet weak var ABbutton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet var BloodButton: [UIButton]!
    
    @IBOutlet weak var AvailableView: UIView!
    
    @IBOutlet weak var AlwaysAvailableButton: UIButton!
    
    @IBOutlet weak var PartiallyAvailableButton: UIButton!
    
    var bloodtype:String = ""
    var bloodName:String = ""
    
    var blood = ""
    
    var blood_Delegate: BloodTypeViewControllerDelegate?
    
    var available = ""
    var availablePercentage = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        SetupRadioButton()
    }
    
    func SetupRadioButton(){
        plusButton.layer.borderColor = UIColor.gray.cgColor
        plusButton.layer.borderWidth = 2
        plusButton.layer.cornerRadius = 8
        
        minusButton.layer.borderColor = UIColor.gray.cgColor
        minusButton.layer.borderWidth = 2
        minusButton.layer.cornerRadius = 8
        
        Abutton.layer.borderColor = UIColor.gray.cgColor
        Abutton.layer.borderWidth = 2
        Abutton.layer.cornerRadius = 8
        
        Bbutton.layer.borderColor = UIColor.gray.cgColor
        Bbutton.layer.borderWidth = 2
        Bbutton.layer.cornerRadius = 8
        
        Obutton.layer.borderColor = UIColor.gray.cgColor
        Obutton.layer.borderWidth = 2
        Obutton.layer.cornerRadius = 8
        
        ABbutton.layer.borderColor = UIColor.gray.cgColor
        ABbutton.layer.borderWidth = 2
        ABbutton.layer.cornerRadius = 8
    }
    
    //MARK: Configure View
    
    func configureUI(){
        Abutton.layer.cornerRadius = 8
        Bbutton.layer.cornerRadius = 8
        Obutton.layer.cornerRadius = 8
        
        ABbutton.layer.cornerRadius = 8
        
        plusButton.layer.cornerRadius = 8
        
        minusButton.layer.cornerRadius = 8
        minusButton.titleLabel?.font = .systemFont(ofSize: 23)
        
        confirmButton.layer.cornerRadius = 8
        
        Abutton.setTitle("A", for: .normal)
        Bbutton.setTitle("B", for: .normal)
        Obutton.setTitle("O", for: .normal)
        ABbutton.setTitle("AB", for: .normal)
        
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        plusButton.setTitle("+", for: .normal)
        plusButton.backgroundColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        plusButton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        plusButton.setTitleColor(.white, for: .normal)
        
        bloodtype = "+"
        
        minusButton.titleLabel?.textColor = UIColor.black
        
        minusButton.layer.borderColor = UIColor.gray.cgColor
        minusButton.layer.borderWidth = 2
        minusButton.layer.cornerRadius = 8
        minusButton.backgroundColor = .systemGray6
        debugPrint(bloodtype)
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        minusButton.setTitle("-", for: .normal)
        minusButton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        minusButton.backgroundColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
        minusButton.setTitleColor(.white, for: .normal)
        
        bloodtype = "-"
        
        plusButton.titleLabel?.textColor = UIColor.black
        
        //  plusButton.setTitleColor(UIColor.black, for: .normal)
        plusButton.layer.borderColor = UIColor.gray.cgColor
        plusButton.layer.borderWidth = 2
        plusButton.layer.cornerRadius = 8
        plusButton.backgroundColor = .systemGray6
        debugPrint(bloodtype)
    }
    
    
    
    @IBAction func BloodButtonPressed(_ sender: UIButton) {
        
        bloodName = sender.currentTitle!
        
        if sender.tag == 0{
            Abutton.backgroundColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
            Abutton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
            Abutton.setTitleColor(.white, for: .normal)
            
            Bbutton.layer.borderColor = UIColor.gray.cgColor
            Bbutton.backgroundColor = .systemGray6
            Bbutton.titleLabel?.textColor = UIColor.black
            Bbutton.layer.borderWidth = 2
            Bbutton.layer.cornerRadius = 8
            
            Obutton.layer.borderColor = UIColor.gray.cgColor
            Obutton.backgroundColor = .systemGray6
            Obutton.titleLabel?.textColor = UIColor.black
            Obutton.layer.borderWidth = 2
            Obutton.layer.cornerRadius = 8
            
            ABbutton.layer.borderColor = UIColor.gray.cgColor
            ABbutton.backgroundColor = .systemGray6
            ABbutton.titleLabel?.textColor = UIColor.black
            ABbutton.layer.borderWidth = 2
            ABbutton.layer.cornerRadius = 8
            
        }else if sender.tag == 1{
            Bbutton.backgroundColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
            Bbutton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
            Bbutton.setTitleColor(.white, for: .normal)
            
            Abutton.layer.borderColor = UIColor.gray.cgColor
            Abutton.backgroundColor = .systemGray6
            Abutton.titleLabel?.textColor = UIColor.black
            Abutton.layer.borderWidth = 2
            Abutton.layer.cornerRadius = 8
            
            Obutton.layer.borderColor = UIColor.gray.cgColor
            Obutton.backgroundColor = .systemGray6
            Obutton.titleLabel?.textColor = UIColor.black
            Obutton.layer.borderWidth = 2
            Obutton.layer.cornerRadius = 8
            
            ABbutton.layer.borderColor = UIColor.gray.cgColor
            ABbutton.backgroundColor = .systemGray6
            ABbutton.titleLabel?.textColor = UIColor.black
            ABbutton.layer.borderWidth = 2
            ABbutton.layer.cornerRadius = 8
            
        }else if sender.tag == 2{
            Obutton.backgroundColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
            Obutton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
            Obutton.setTitleColor(.white, for: .normal)
            
            Abutton.layer.borderColor = UIColor.gray.cgColor
            Abutton.backgroundColor = .systemGray6
            Abutton.titleLabel?.textColor = UIColor.black
            Abutton.layer.borderWidth = 2
            Abutton.layer.cornerRadius = 8
            
            Bbutton.layer.borderColor = UIColor.gray.cgColor
            Bbutton.backgroundColor = .systemGray6
            Bbutton.titleLabel?.textColor = UIColor.black
            Bbutton.layer.borderWidth = 2
            Bbutton.layer.cornerRadius = 8
            
            ABbutton.layer.borderColor = UIColor.gray.cgColor
            ABbutton.backgroundColor = .systemGray6
            ABbutton.titleLabel?.textColor = UIColor.black
            ABbutton.layer.borderWidth = 2
            ABbutton.layer.cornerRadius = 8
        }else if sender.tag == 3{
            ABbutton.backgroundColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
            ABbutton.layer.borderColor = #colorLiteral(red: 0.8449582458, green: 0, blue: 0.1959564686, alpha: 1)
            ABbutton.setTitleColor(.white, for: .normal)
            
            Abutton.layer.borderColor = UIColor.gray.cgColor
            Abutton.backgroundColor = .systemGray6
            Abutton.titleLabel?.textColor = UIColor.black
            Abutton.layer.borderWidth = 2
            Abutton.layer.cornerRadius = 8
            
            Bbutton.layer.borderColor = UIColor.gray.cgColor
            Bbutton.backgroundColor = .systemGray6
            Bbutton.titleLabel?.textColor = UIColor.black
            Bbutton.layer.borderWidth = 2
            Bbutton.layer.cornerRadius = 8
            
            Obutton.layer.borderColor = UIColor.gray.cgColor
            Obutton.backgroundColor = .systemGray6
            Obutton.titleLabel?.textColor = UIColor.black
            Obutton.layer.borderWidth = 2
            Obutton.layer.cornerRadius = 8
        }
    }
    
    
    @IBAction func AvailabilityButtonPressed(_ sender: UIButton) {
        if sender.tag == 1{
            AlwaysAvailableButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            PartiallyAvailableButton.setImage(UIImage(systemName: "circle"), for: .normal)
            available = "Always Available"
            availablePercentage = 100.0
        }else if sender.tag == 2{
            PartiallyAvailableButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            AlwaysAvailableButton.setImage(UIImage(systemName: "circle"), for: .normal)
            available = "Partially Available"
            availablePercentage = 50.0
        }else
        {
            AlwaysAvailableButton.setImage(UIImage(systemName: "circle"), for: .normal)
            PartiallyAvailableButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        blood = bloodName+bloodtype
        print(blood)
        
        if((bloodName != "") && (bloodtype != "")){
            if available != ""{
                blood_Delegate?.didvaluesgot(bloodgroup: blood, availability: available, chance: Float(availablePercentage))
                
                self.dismiss(animated: true)
            }else{
                alert(title: "Invalid Data", message: "Please confirm your availability!")
            }
            
        }
        else{
            alert(title: "Invalid Data", message: "Please select both Blood Group and Blood Type!")
        }
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension BloodTypeViewController{
    
    func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
