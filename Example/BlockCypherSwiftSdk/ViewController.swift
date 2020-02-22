//
//  ViewController.swift
//  BlockCypherSwiftSdk
//
//  Created by s.bezpalyi@yandex.com on 02/21/2020.
//  Copyright (c) 2020 s.bezpalyi@yandex.com. All rights reserved.
//

import UIKit
import BlockCypherSwiftSdk

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Mark: Text Fields to show wallet details.
    @IBOutlet weak var edtBitcoinAddress: UITextField!
    @IBOutlet weak var edtPrivateKey: UITextField!
    @IBOutlet weak var edtPublicKey: UITextField!
    
    // Mark: Labels for Wallet Balance.
    @IBOutlet weak var lblReceived: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblConfirmed: UILabel!
    
    // Mark: Text Fields to create transaction.
    @IBOutlet weak var edtAddressToSend: UITextField!
    @IBOutlet weak var edtAmountInSatoshi: UITextField!
    @IBOutlet weak var edtSignToSignature: UITextField!
    @IBOutlet weak var edtSignature: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edtBitcoinAddress.delegate = self
        edtPrivateKey.delegate = self
        edtSignToSignature.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }

    // Mark: Actions
    @IBAction func onCreateWallet(_ sender: Any) {
        let addrAPI = AddressAPI.shared
        
        addrAPI.setLiveMode(live: false)
        
        addrAPI.generateAddressEndpoint(params: [:]) {
            [weak self] (addrKeyChain, status) in
            guard let weakSelf = self else {
                return
            }
            
            guard let addrKeyChain = addrKeyChain else {
                return
            }
            
            if status == 201 {
                DispatchQueue.main.async {
                    weakSelf.edtBitcoinAddress.text = addrKeyChain.address
                    weakSelf.edtPrivateKey.text = addrKeyChain.privateKey
                    weakSelf.edtPublicKey.text = addrKeyChain.publicKey
                }
            }
        }
    }
    
    @IBAction func onWalletRefresh(_ sender: Any) {
        guard let addr = edtBitcoinAddress.text else {
            self.showToast(message: "Create Wallet Please")
            return
        }
        
        if addr == "" {
            self.showToast(message: "Create Wallet Please")
            return
        }
        
        let addrAPI = AddressAPI.shared
        addrAPI.setLiveMode(live: false)
        addrAPI.addressBalanceEndpoint(address: addr, params: [:]) { [weak self] (addrDetail, status) in
            guard let weakSelf = self else {
                return
            }
            
            guard let addrDetail = addrDetail else {
                weakSelf.showToast(message: "Refresh failed")
                return
            }
            
            DispatchQueue.main.async {
                weakSelf.lblReceived.text = "\(addrDetail.total_received) satoshi"
                weakSelf.lblBalance.text = "\(addrDetail.balance) satoshi"
            }
        }
    }
    
    
    @IBAction func onSaveClicked(_ sender: Any) {
        UserDefaults.standard.set(self.edtBitcoinAddress.text ?? "", forKey: "address")
        UserDefaults.standard.set(self.edtPrivateKey.text ?? "", forKey: "privateKey")
        UserDefaults.standard.set(self.edtPublicKey.text ?? "", forKey: "publicKey")
    }
    
    @IBAction func onLoadClicked(_ sender: Any) {
        let userData = UserDefaults.standard
        self.edtBitcoinAddress.text = userData.string(forKey: "address")
        self.edtPrivateKey.text = userData.string(forKey: "privateKey")
        self.edtPublicKey.text = userData.string(forKey: "publicKey")
    }
    
    @IBAction func onCreateNewTransaction(_ sender: Any) {
        
    }
    
    @IBAction func sendTransaction(_ sender: Any) {
    }
    
    // Mark: Actions for Copy
    @IBAction func onCopyAddress(_ sender: Any) {
        UIPasteboard.general.string = edtBitcoinAddress.text
        self.showToast(message: "Address Copied to Clipboard")
    }
    
    @IBAction func onCopyPrivateKey(_ sender: Any) {
        UIPasteboard.general.string = edtPrivateKey.text
        self.showToast(message: "Private Key Copied to Clipboard")
    }
    
    @IBAction func onCopyPublicKey(_ sender: Any) {
        UIPasteboard.general.string = edtPublicKey.text
        self.showToast(message: "Public Key Copied to Clipboard")
    }
    
    @IBAction func onCopySignToSignature(_ sender: Any) {
        UIPasteboard.general.string = edtSignToSignature.text
        self.showToast(message: "Sign to Signature Copied to Clipboard")
    }
    
}


extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
