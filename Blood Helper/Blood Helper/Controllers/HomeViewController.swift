//
//  HomeViewController.swift
//  Blood Helper
//
//  Created by MacOS on 07/04/23.
//

import UIKit
import MessageUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate{
   
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var buttonStack: UIStackView!
    
    @IBOutlet weak var homeBUtton: UIButton!
    
    @IBOutlet weak var ContactPerson: UIButton!
    
    @IBOutlet weak var MoreButton: UIButton!
    
    
    var userdetails = [UserDetails]()
    
    let search = UISearchController(searchResultsController: ResultViewController())
    
    var bloodtype = ""
   
    var countryCode = "+91"
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        userdetails = Database().getData()
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
      
        // Do any additional setup after loading the view.
        profileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    
       
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddContactsViewController") as! AddContactsViewController
    
        controller.modalPresentationStyle = .pageSheet
        self.present(controller, animated: true)
        
    }
 
    
    // Tableview Delegates Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userdetails.count
    }
    
    fileprivate func BloodtypeIdentify(_ indexPath: IndexPath, _ cell: ProfileTableViewCell) {
        bloodtype = userdetails[indexPath.row].bloodType!
        if bloodtype ==  "A+"{
            cell.profileBloodImage.image = UIImage(named: "a+")
        }else if bloodtype == "A-"{
            cell.profileBloodImage.image = UIImage(named: "a-")
        }else if bloodtype == "B+" {
            cell.profileBloodImage.image = UIImage(named: "b+")
        }else if bloodtype == "B-" {
            cell.profileBloodImage.image = UIImage(named: "b-")
        }else if bloodtype == "O+" {
            cell.profileBloodImage.image = UIImage(named: "o+")
        }else if bloodtype == "O-"{
            cell.profileBloodImage.image = UIImage(named: "o-")
        }else if bloodtype == "AB+"{
            cell.profileBloodImage.image = UIImage(named: "ab+")
        }else if bloodtype == "AB-" {
            cell.profileBloodImage.image = UIImage(named: "ab-")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
  
        cell.name.text = userdetails[indexPath.row].name
        
        BloodtypeIdentify(indexPath, cell)
        cell.callButton.tag = indexPath.row
        cell.shareButton.tag = indexPath.row
        cell.messageButton.tag = indexPath.row
        cell.frame = CGRectMake(0, 0, self.profileTableView.frame.size.width, cell.frame.size.height)
        
        cell.callButton.addTarget(self, action: #selector(callDonar), for: .touchUpInside)
        cell.shareButton.addTarget(self, action: #selector(shareSheet), for: .touchUpInside)
        cell.messageButton.addTarget(self, action: #selector(messageSheet), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        if let controller = (storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController){
            
            print("userdetails \(userdetails[indexPath.row])")
            
            controller.userName = userdetails[indexPath.row].name!
            controller.userPhone = userdetails[indexPath.row].mobile!
            controller.userGender = userdetails[indexPath.row].gender!
            controller.userAvailability = userdetails[indexPath.row].available ?? "novalue"
        
            bloodtype = userdetails[indexPath.row].bloodType!
                if bloodtype ==  "A+"{
                    controller.userBloodImage = UIImage(named: "a+")!
                }else if bloodtype == "A-"{
                    controller.userBloodImage = UIImage(named: "a-")!
                }else if bloodtype == "B+" {
                    controller.userBloodImage = UIImage(named: "b+")!
                }else if bloodtype == "B-" {
                    controller.userBloodImage = UIImage(named: "b-")!
                }else if bloodtype == "O+" {
                    controller.userBloodImage = UIImage(named: "o+")!
                }else if bloodtype == "O-"{
                    controller.userBloodImage = UIImage(named: "o-")!
                }else if bloodtype == "AB+"{
                    controller.userBloodImage = UIImage(named: "ab+")!
                }else if bloodtype == "AB-" {
                    controller.userBloodImage = UIImage(named: "ab-")!
                }
            let transition = CATransition.init()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
            transition.type = CATransitionType.moveIn //Transition you want like Push, Reveal
            transition.subtype = CATransitionSubtype.fromRight // Direction like Left to Right, Right to Left
            transition.delegate = self
            view.window!.layer.add(transition, forKey: kCATransition)
            self.navigationController?.pushViewController(controller, animated: true)
            self.present(controller, animated: true)
        }
            
            
    }
    
    
    @IBAction func homeButtonPressed(_ sender: Any) {
       
    }
    @IBAction func contactButtonPressed(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
    }
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
        
    }
    
    @objc func callDonar(_ sender:UIButton){
        
        let number = userdetails[sender.tag].mobile
        
        call(mobile: number!)
        
    }
    
    
    @objc func shareSheet( _ sender :UIButton){
     
        let name = userdetails[sender.tag].name!
        let mNumber = userdetails[sender.tag].mobile!
        let bgroup = userdetails[sender.tag].bloodType!
        
        var message = "Please contact \(name) and their's mobile number is \(mNumber) for bloodgroup \(bgroup)"
        
        let share = UIActivityViewController(activityItems: [
            message
        ], applicationActivities: nil)
//
        self.present(share, animated: true)
    }
    
    @objc func messageSheet(_ sender:UIButton){
        
        let mobile = userdetails[sender.tag].mobile!
        
       
        
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
                self.whatsapp(mobile: mobile, PatientName: name!, PatientNumber: number!, PatientLocation: hospital!)

            }else{
                
                let alert = UIAlertController(title: "Empty Data", message: "Please fill the details", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
   
                self.present(alert, animated: true)
            }
            
            
        }))
 
        self.present(popup, animated: true)
        
        //MARK: Message Function
//        guard MFMessageComposeViewController.canSendText(), MFMessageComposeViewController.canSendAttachments(), MFMessageComposeViewController.canSendSubject() else{
//            print("Not able to send messages")
//            return
//        }
//
//        let compose = MFMessageComposeViewController()
//        compose.messageComposeDelegate = self
//        compose.recipients = [mobile]
//        compose.subject = "Need Your Help!"
//        self.present(compose, animated: true)

    }
   
    func call(mobile: String){
        if let phoneCallURL = URL(string: "tel://\(mobile)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
          }
    }
    
    func whatsapp(mobile: String, PatientName: String, PatientNumber: String, PatientLocation: String){
       
       var message = "Blood in Need for \(PatientName) and Their Contact Number is \(PatientNumber) and They are in \(PatientLocation)"
       
       let whatsappURL = "https://api.whatsapp.com/send?phone=\(countryCode)\(mobile)&text=\(message)"
       
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

//MARK: Message Delegates

//extension HomeViewController: MFMessageComposeViewControllerDelegate{
//    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
//
//        switch result{
//        case .cancelled:
//            print("Cancelled")
//
//        case .failed:
//            print("Failed")
//
//        case .sent:
//            print("Sent")
//        default:
//            print("Unknown")
//        }
//
//        controller.dismiss(animated: true)
//
//    }
//}


//MARK: Search Result Delegate
//extension HomeViewController: UISearchBarDelegate, UISearchResultsUpdating{
//    func updateSearchResults(for searchController: UISearchController) {
//        let user = Database()
//        var searchText = search.searchBar.text
//
//        if searchText != ""{
//            userdetails = user.searchData(name: searchController.title!)
//            print("User found")
//            profileTableView.reloadData()
//
//        }else{
//            print("User not found")
//            userdetails = user.getData()
//            profileTableView.reloadData()
//        }
//    }
//
//}

