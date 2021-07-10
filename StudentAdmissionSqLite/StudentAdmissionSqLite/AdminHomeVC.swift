//
//  AdminHomeVC.swift
//  StudentAdmissionSqLite
//
//  Created by DCS on 08/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AdminHomeVC: UIViewController {
    private let myview : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()

    public let mybtn : UIButton = {
        let btn = UIButton()
         btn.setImage(UIImage(named: "logout"), for: .normal)
        
         btn.addTarget(self, action: #selector(logout), for: .touchUpInside)
        btn.layer.cornerRadius = 15
        return btn
    }()
    private let  myimg:UIImageView   = {
        let img = UIImageView(image:UIImage( named: "userimage"))
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 50
        img.clipsToBounds = true
        return img
    }()
    private let label1:UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textAlignment = .center
        return lb
    }()
    private let myview1 : UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        return view
    }()
    private let label2:UILabel = {
        let lb = UILabel()
        lb.text = "Add Student"
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        
        return lb
    }()
    public let mybtn1 : UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(AddStud), for: .touchUpInside)
        btn.layer.cornerRadius = 30
        return btn
    }()
    private let myview2 : UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        return view
    }()
    private let label3:UILabel = {
        let lb = UILabel()
        lb.text = "Student Details"
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        
        return lb
    }()
    public let mybtn2 : UIButton = {
        let btn = UIButton()
       btn.setImage(UIImage(named: "list"), for: .normal)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(StudentDetails), for: .touchUpInside)
        btn.layer.cornerRadius = 30
        return btn
    }()
    private let myview3: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        return view
    }()
    private let label4:UILabel = {
        let lb = UILabel()
        lb.text = "Add Notice"
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        
        return lb
    }()
    public let mybtn3 : UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(AddNotice), for: .touchUpInside)
        btn.layer.cornerRadius = 30
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          view.backgroundColor = UIColor.blue
        view.addSubview(myview)
        view.addSubview(myimg)
         view.addSubview(mybtn)
        view.addSubview(label1)
        let name  = UserDefaults.standard.string(forKey: "name")
        label1.text = "Hey , \(name!)"
        view.addSubview(myview1)
        view.addSubview(label2)
        view.addSubview(mybtn1)
        view.addSubview(myview2)
        view.addSubview(label3)
        view.addSubview(mybtn2)
        view.addSubview(myview3)
        view.addSubview(label4)
        view.addSubview(mybtn3)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myview.frame = CGRect(x: 0, y: view.height / 8, width: view.width, height: view.height / 2 + 400)
        myimg.frame = CGRect(x: view.width / 2 - 50 , y:view.height / 8 - 30 , width: 100, height: 100)
        label1.frame = CGRect(x:view.width / 2 - 50   , y:myimg.bottom + 10 , width: 100, height: 40)
        mybtn.frame = CGRect(x: view.width - 100 , y: 25, width: 80, height: 30)
        myview1.frame = CGRect(x: 20, y: label1.bottom + 20, width: view.width - 40, height: 130)
         label2.frame = CGRect(x:40    , y:label1.bottom + 30 , width:view.width, height: 40)
        mybtn1.frame = CGRect(x: view.width - 90 , y: label2.bottom + 10, width: 60, height: 60)
        myview2.frame = CGRect(x: 20, y: mybtn1.bottom + 20, width: view.width - 40, height: 130)
        label3.frame = CGRect(x:40    , y:mybtn1.bottom + 30 , width:view.width, height: 40)
        mybtn2.frame = CGRect(x: view.width - 90 , y: label3.bottom + 10, width: 60, height: 60)
        myview3.frame = CGRect(x: 20, y: mybtn2.bottom + 20, width: view.width - 40, height: 130)
        label4.frame = CGRect(x:40    , y:mybtn2.bottom + 30 , width:view.width, height: 40)
        mybtn3.frame = CGRect(x: view.width - 90 , y: label4.bottom + 10, width: 60, height: 60)
    }
    @objc func logout(){
        UserDefaults.standard.setValue(nil, forKey: "LoginTokenKey")
        UserDefaults.standard.setValue(nil, forKey: "id")
        
            let vc = LoginVC()
            let nv = UINavigationController(rootViewController: vc)
            nv.modalPresentationStyle = .fullScreen
            nv.setNavigationBarHidden(true, animated: false)
            present(nv,animated: false)
        
    }
    @objc func AddStud(){
        let vc = AddStudent()
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        nv.setNavigationBarHidden(true, animated: true)
        present(nv,animated: true)
        
    }
    @objc func StudentDetails(){
        let vc = StudentDetailsVC()
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        nv.setNavigationBarHidden(true, animated: true)
        present(nv,animated: true)
    }
    @objc func AddNotice(){
        let vc = AddNoticeVC()
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        nv.setNavigationBarHidden(true, animated: true)
        present(nv,animated: true)
    }
}
