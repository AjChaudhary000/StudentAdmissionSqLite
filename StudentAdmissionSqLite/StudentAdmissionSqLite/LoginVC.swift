//
//  LoginVC.swift
//  StudentAdmissionSqLite
//
//  Created by DCS on 08/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
 var Sql = SqLiteHandler.shared
    var stud:[Student] = []
    private let myview : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    private let label1:UILabel = {
        let lb = UILabel()
        lb.text = "WelCome !"
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 35)
        return lb
    }()
    
    private let label2:UILabel = {
        let lb = UILabel()
        lb.text = "E-mail & Password "
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        return lb
    }()
    private let txt:UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 10
        txt.layer.borderWidth = 2
        txt.layer.borderColor = UIColor.blue.cgColor
        txt.placeholder = "Enter The E-mail & Username"
        txt.textAlignment = .center
        return txt
    }()
    private let label3:UILabel = {
        let lb = UILabel()
        lb.text = "Password "
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        return lb
    }()
    private let txt1:UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 10
        txt.layer.borderWidth = 2
        txt.layer.borderColor = UIColor.blue.cgColor
        txt.placeholder = "Enter The Password"
        txt.isSecureTextEntry  = true
        txt.textAlignment = .center
        return txt
    }()
    private let btn:UIButton = {
        let btn = UIButton()
        btn.setTitle("SignIn", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(loginpage), for: .touchUpInside)
        return btn
    }()
    private let btn1:UIButton = {
        let btn = UIButton()
        btn.setTitle("SignUp", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.blue.cgColor
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        UIView.animate(withDuration: 0.9){
            self.view.addSubview(self.myview)
            self.view.addSubview(self.label1)
            
            self.view.addSubview(self.label2)
            self.view.addSubview(self.txt)
            self.view.addSubview(self.label3)
            self.view.addSubview(self.txt1)
            self.view.addSubview(self.btn)
            self.view.addSubview(self.btn1)
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myview.frame = CGRect(x: 0, y: view.height / 3, width: view.width, height: view.height / 2 + 200)
        label1.frame = CGRect(x: 20, y: 100, width: 200, height: 40)
        label2.frame = CGRect(x: 20, y: view.height / 3 + 20, width: view.width, height: 40)
        txt.frame = CGRect(x: 20, y: label2.bottom + 5 , width: view.width - 40, height: 45)
        label3.frame = CGRect(x: 20, y: txt.bottom + 10, width: view.width, height: 40)
        txt1.frame = CGRect(x: 20, y: label3.bottom + 5 , width: view.width - 40, height: 45)
        btn.frame = CGRect(x: 20, y: txt1.bottom + 30, width: view.width - 40 , height: 45)
        btn1.frame = CGRect(x: 20, y: btn.bottom + 30, width: view.width - 40 , height: 45)
        
    }
    
    
    @objc func loginpage(){
        stud =  Sql.Select_Student(name:txt.text! , password:txt1.text!)
        print(stud.count)
        if stud.count == 1 {
            UserDefaults.standard.setValue("Login\(stud[0].name)", forKey: "LoginTokenKey")
            UserDefaults.standard.setValue(stud[0].sid, forKey: "id")
            UserDefaults.standard.setValue(stud[0].name, forKey: "name")
            
            self.dismiss(animated: true)
        }else{
            let alert = UIAlertController(title: "OPPS ! ", message: "UserName And Password Wrong ..", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            DispatchQueue.main.async {
                self.present(alert,animated: true,completion: nil)
            }
        }
    }
}
