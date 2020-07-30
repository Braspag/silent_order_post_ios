//
//  ViewController.swift
//  Example
//
//  Created by Jeferson Nazario on 28/07/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

import UIKit
import BraspagSilentOrderPost

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
    
    private var sdk: SilentOrderPostProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sdk = SilentOrderPost.createInstance(environment: .sandbox)
        
        txtCardNumber.text = "4000000000001091"
        txtDate.text = "10/2029"
        txtCvv.text = "621"
        
        btnTest.addTarget(self, action: #selector(testData), for: .touchUpInside)
    }
    
    @objc func startSilentOrder() {
        getAccessToken(merchantId: "2A946384-03CB-4A38-A930-0A252B403380", onSuccess: { [weak self] (accessToken) in
            self?.makePost(accessToken: accessToken)
        }) { (error) in
            print(error)
            self.stopLoading()
        }
    }
    
    private func makePost(accessToken: String) {
        sdk.sendCardData(accessToken: accessToken,
                         cardHolderName: txtName.text!,
                         cardNumber: txtCardNumber.text!,
                         cardExpirationDate: txtDate.text!,
                         cardCvv: txtCvv.text!,
                         enableBinQuery: swBinQuery.isOn,
                         enableVerifyCard: swProtectedCard.isOn,
                         enableZeroAuth: swZeroAuth.isOn,
                         onValidation: { (results) -> Void? in
                            
                            results.forEach { (result) in
                                print(result.field + ": " + result.message)
                            }
        },
                         onSuccess: { (result) in
                            DispatchQueue.main.async {
                                self.stopLoading()
                                do {
                                    let jsonData = try JSONEncoder().encode(result)
                                    let json = String(data: jsonData, encoding: .utf8)
                                                        
                                    self.txtResult.text = json

                                } catch let ex {
                                    self.txtResult.text = ex.localizedDescription
                                }
                                
                                self.tableView.scrollToRow(at: IndexPath(item: 5, section: 0), at: .top, animated: true)
                            }
                            
        }) { (error) -> Void? in
            DispatchQueue.main.async {
                self.stopLoading()
                self.txtResult.text = error.errorMessage
            }
        }
    }
    
    func stopLoading() {
        self.loading.stopAnimating()
        btnTest.setTitle("Testar", for: .normal)
    }
    
    @objc func testData() {
        self.view.endEditing(true)
        
        txtResult.text = ""
        loading.startAnimating()
        btnTest.setTitle("", for: .normal)
        
        startSilentOrder()
        
    }
    
    private func getAccessToken(merchantId: String, onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        let url = "https://transactionsandbox.pagador.com.br/post/api/public/v1/accesstoken?merchantid=\(merchantId)"
        
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        
        guard let urlRequest: URL = URL(string: url) else { return }
        var request: URLRequest = URLRequest(url: urlRequest)
        request.httpMethod = "POST"
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        
        let task = session.dataTask(with: request, completionHandler: { (result, response, error) in
            print(response ?? "Nada")
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            guard let data = result else {
                onError(error!.localizedDescription)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromUpperCamelCase
                let decodableData = try decoder.decode(AccessTokenResponse.self, from: data)
                
                DispatchQueue.main.async {
                    onSuccess(decodableData.accessToken)
                }
            } catch let exception {
                onError(exception.localizedDescription)
            }
        })
        
        task.resume()
    }

}

