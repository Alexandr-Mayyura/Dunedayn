//
//  ViewController.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 14.07.2021.
//
import Foundation
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var imageLogoView: UIImageView!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func enterButton(_ sender: Any) {
    }
    
    let imageLogo = UIImage(named: "днд логотип гланый")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        imageLogoView.image = imageLogo
        registerForKeyboardNotification()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.returnKeyType = UIReturnKeyType.continue
        passwordTextField.returnKeyType = UIReturnKeyType.done
        
        addTapGestureToHideKeyboard()
        
           }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {
           case emailTextField:
            passwordTextField.becomeFirstResponder()
           case passwordTextField:
            textField.resignFirstResponder()
           default: break
               
           }
           return true
     }

    @IBAction func singUpButton(_ sender: Any) {
    }

    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
 
}

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
