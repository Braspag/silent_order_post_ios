//
//  ViewController.swift
//  Example
//
//  Created by Jeferson Nazario on 28/07/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtCvv: UITextField!
    @IBOutlet weak var swProtectedCard: UISwitch!
    @IBOutlet weak var swBinQuery: UISwitch!
    @IBOutlet weak var swZeroAuth: UISwitch!
    @IBOutlet weak var btnTest: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var txtResult: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTest.addTarget(self, action: #selector(testData), for: .touchUpInside)
    }

    @objc func testData() {
        loading.startAnimating()
        btnTest.setTitle("", for: .normal)
        
    }

}

