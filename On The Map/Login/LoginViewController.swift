//
//  LoginViewController.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 08/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    enum ViewState {
        case IDLE
        case LOADING
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setViewState(ViewState.IDLE)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        startLogin()
    }
    
    func startLogin() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        setViewState(ViewState.LOADING)
        AuthHandler.shared.makeLoginCall(email: email, password: password, onComplete: {error, response in
            DispatchQueue.main.async(execute: {
                self.setViewState(ViewState.IDLE)
                self.onLoginResult(error: error, response: response)
            })
        })
    }
    
    func onLoginResult(error: Error?, response: UdacityAuthResponse?) {
        if error != nil {
            // TODO Show appropriate alert
            return
        }
        
        // Process response
        
        
        // Start Home Screen
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
            present(viewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setViewState(_ viewState: ViewState) {
        switch viewState {
        case ViewState.IDLE:
            emailTextField.isEnabled = true
            passwordTextField.isEnabled = true
            loginButton.isEnabled = true
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            break
        case ViewState.LOADING:
            emailTextField.isEnabled = false
            passwordTextField.isEnabled = false
            loginButton.isEnabled = false
            indicatorView.isHidden = false
            indicatorView.startAnimating()
            break
        }
    }
}

