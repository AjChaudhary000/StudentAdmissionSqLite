//
//  NoticeViewVC.swift
//  StudentAdmissionSqLite
//
//  Created by DCS on 10/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NoticeViewVC: UIViewController {
    var id:Int?
    init(nid:Int) {
        super.init(nibName: nil, bundle: nil)
        id = nid
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var Sql = SqLiteHandler.shared
    var not:[Notice] = []
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
        view.backgroundColor = .green
        view.layer.cornerRadius = 20
        return view
    }()
    private let label2:UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textAlignment = .center
        return lb
    }()
    
    
    private let txt1:UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 10
        txt.layer.borderWidth = 2
        txt.layer.borderColor = UIColor.white.cgColor
        txt.placeholder = "Enter The Notice Detail"
        txt.isEnabled = false
        txt.textAlignment = .center
        txt.textColor = .white
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        view.addSubview(myview)
        view.addSubview(myimg)
        view.addSubview(mybtn)
        view.addSubview(label1)
        let name  = UserDefaults.standard.string(forKey: "name")
        label1.text = "Hey , \(name!)"
        view.addSubview(myview1)
        self.view.addSubview(self.label2)
        self.view.addSubview(self.txt1)
        not = Sql.Select_Notice_id(id: id!)
        self.label2.text = not[0].nname
        self.txt1.text = not[0].ndetail
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myview.frame = CGRect(x: 0, y: view.height / 8, width: view.width, height: view.height / 2 + 400)
        myimg.frame = CGRect(x: view.width / 2 - 50 , y:view.height / 8 - 30 , width: 100, height: 100)
        label1.frame = CGRect(x:view.width / 2 - 50   , y:myimg.bottom + 10 , width: 100, height: 40)
        mybtn.frame = CGRect(x: view.width - 100 , y: 25, width: 80, height: 30)
        myview1.frame = CGRect(x: 0, y: label1.bottom + 10, width: view.width, height: view.height / 2 + 200)
        label2.frame = CGRect(x: 20, y: view.height / 3 + 20, width: view.width, height: 40)
       
        txt1.frame = CGRect(x: 20, y: label2.bottom + 10 , width: view.width - 40, height: 200)
       
        
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
}
