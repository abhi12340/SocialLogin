//
//  ViewController.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 08/10/20.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController  {
    
    private lazy var  googleLoginButton :  GIDSignInButton = {
        $0.sizeToFit()
        $0.clipsToBounds = true
        return $0
    }(GIDSignInButton())
    
    private lazy var  facebook :  FBLoginButton = {
        $0.sizeToFit()
        $0.clipsToBounds = true
        $0.delegate = self
        $0.permissions = ["public_profile", "email"]
        return $0
    }(FBLoginButton())
    
    
    private lazy var userNameLabel : UILabel = {
        $0.font = UIFont(name: "helvetica", size: 15)
        $0.text = "username"
        return $0
    }(UILabel())
    
    private lazy var username : UITextField = {
        $0.placeholder = "username"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.minimumFontSize = 20
        return $0
    }(UITextField())
    
    
    private lazy var passwordLabel : UILabel = {
        $0.font = UIFont(name: "helvetica", size: 15)
        $0.text = "password"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    
    private lazy var password : UITextField = {
        $0.placeholder = "password"
        $0.textColor = UIColor.black
        return $0
    }(UITextField())
    
    private let nestedStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupview()
        navigationItem.title = "Task Application"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "click", style: .done, target: self, action: #selector(barButtonClick(_:)))
        setupLoginGoogle()
        setupFacebook()
    }
    
    func removeResponder() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    func setupLoginGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @objc func barButtonClick(_ sender : UIBarButtonItem) {
        navigationController?.pushViewController(EmployeeController(), animated: true)
    }
    
    @objc func tapped(_ sender : UITapGestureRecognizer) {
        resignFirstResponder()
    }
    
    func setupFacebook() {
        if let token = AccessToken.current,
                !token.isExpired {
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["field" : "email , name" ], tokenString: token.tokenString, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(result ?? "")")
            }
                // User is logged in, do work such as go to next view controller.
        }
    }
    
    func setupview() {
        
        
        username.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 20))
        
        let inputFieldStackView = UIStackView(arrangedSubviews: [userNameLabel,username,passwordLabel,password])
        inputFieldStackView.axis = .vertical
        inputFieldStackView.alignment = .leading
        inputFieldStackView.distribution = .fillEqually
        inputFieldStackView.spacing = 10
        
        let socialLoginStackView = UIStackView(arrangedSubviews: [googleLoginButton , facebook])
        socialLoginStackView.axis = .horizontal
        socialLoginStackView.alignment = .top
        socialLoginStackView.distribution = .fillEqually
        socialLoginStackView.spacing = 10
        
        nestedStackView.addArrangedSubview(inputFieldStackView)
        nestedStackView.addArrangedSubview(socialLoginStackView)
        nestedStackView.axis = .vertical
        nestedStackView.alignment = .leading
        nestedStackView.distribution = .fill
        nestedStackView.spacing = 40
        nestedStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nestedStackView)
        NSLayoutConstraint.activate([nestedStackView.safeAreaLayoutGuide.topAnchor.constraint(equalTo:              view.safeAreaLayoutGuide.topAnchor , constant: 10),
                                     nestedStackView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor ,constant:-10),
            nestedStackView.leadingAnchor.constraint(equalTo:  view.leadingAnchor , constant: 18),
            nestedStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -18)])
    }

}


extension LoginViewController :  LoginButtonDelegate  {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["field" : "email , name"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(result ?? "")")
        }

    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
}

