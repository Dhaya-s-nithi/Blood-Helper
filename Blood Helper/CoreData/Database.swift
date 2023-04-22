//
//  Database.swift
//  Blood Helper
//
//  Created by MacOS on 11/04/23.
//

import Foundation
import CoreData
import UIKit


class Database{
    
    static var shareInstance = Database()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveData(name: String, phone: String, password: String, ConfirmPassword: String, gender: String, bloodtype: String, available: String){
       
        let userdetails = NSEntityDescription.insertNewObject(forEntityName: "UserDetails", into: context) as! UserDetails
        userdetails.name = name
        userdetails.mobile = phone
        userdetails.password = password
        userdetails.conformPassword = ConfirmPassword
        userdetails.gender = gender
        userdetails.bloodType = bloodtype
        userdetails.available = available
        
        print("Saved value: \(available)");
        
        do{
            try context.save()
            
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getData() -> [UserDetails]{
        var userdetails = [UserDetails]()
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "UserDetails")
        do{
            userdetails = try context.fetch(request) as! [UserDetails]
           
            
        }catch let error{
            print(error.localizedDescription)
        }
        print(userdetails)
        
        return userdetails
    }
    
    
    func searchData(name: String) -> [UserDetails]{
        
        var userdetails = [UserDetails]()
 
        let fetchRequest:NSFetchRequest = UserDetails.fetchRequest()
        let predicate = NSPredicate(format: "userName contains %@", name)
        fetchRequest.predicate = predicate
        
        do{
            userdetails = try context.fetch(fetchRequest)
           
            
        }catch let error{
            print(error.localizedDescription)
        }
        print(userdetails)
        return userdetails
    }
    
    
    func saveContactData(ContactName: String, ContactPhone: String, ContactBloodGroup: String){
       
        let contactUserDetials = NSEntityDescription.insertNewObject(forEntityName: "PatientDetails", into: context) as! PatientDetails
        
        contactUserDetials.cName = ContactName
        contactUserDetials.cPhone = ContactPhone
        contactUserDetials.cBloodGroup = ContactBloodGroup
       
        
        do{
            try context.save()
            
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getContactData() -> [PatientDetails]{
        var contactUserDetials = [PatientDetails]()
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "PatientDetails")
        do{
            contactUserDetials = try context.fetch(request) as! [PatientDetails]
           
            
        }catch let error{
            print(error.localizedDescription)
        }
        print(contactUserDetials)
        
        return contactUserDetials
    }
    
    
    func save(){
        
        
        do{
            
            try self.context.save()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
}
