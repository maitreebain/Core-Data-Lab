//
//  UserViewController.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/13/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

protocol UserDelegate: AnyObject {
    func didCreateUser(_ viewController: UserViewController, user: User)
}

class UserViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobPicker: UIDatePicker!
    
    weak var delegate: UserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dobPicker.maximumDate = Date()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        guard let username = nameTextField.text, !username.isEmpty else { print("no username")
            return}
        
        let date = dobPicker.date
        
        let user = CoreDataManager.shared.createUser(for: username, dob: date)
        
        delegate?.didCreateUser(self, user: user)
        
    }
    
}
