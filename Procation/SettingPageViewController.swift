//
//  SettingPageViewController.swift
//  Procation
//
//  Created by Jayme on 2021-10-04.
//  Copyright © 2021 VJGuo. All rights reserved.
//

import UIKit
import ContactsUI
class SettingPageViewController: UIViewController, CNContactPickerDelegate {
    public var mycompletionHandler: ((String?)->Void)?

    @IBOutlet weak var ContactName1: UILabel!
    @IBOutlet weak var phoneNum1: UILabel!
    @IBOutlet weak var phoneLabel1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        mycompletionHandler?(ContactName1.text)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func selectContact1(_ sender: UIButton) {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    //TODO:pass ContactName{1..3} and phoneNum{1..3} and phoneLabel1{1..3} as parameters into contactPicker
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let lastName = contact.familyName
        let firstName = contact.givenName
        ContactName1.text = firstName + " "+lastName
        //print("LastName：\(lastName)")
        //print("FirstName：\(firstName)")
        //0:mobile
        let phone = contact.phoneNumbers[0]
        
        let phoneLabel = CNLabeledValue<NSString>.localizedString(forLabel: phone.label ?? "mobilee")
        let phoneValue = phone.value.stringValue
        
        phoneLabel1.text = phoneLabel
        phoneNum1.text = phoneValue
        //print("\(phoneLabel):\(phoneValue)")
       // testLabel.text = lastName + firstName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
