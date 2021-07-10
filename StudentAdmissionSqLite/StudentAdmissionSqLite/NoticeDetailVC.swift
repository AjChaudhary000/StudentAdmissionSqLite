//
//  NoticeDetailVC.swift
//  StudentAdmissionSqLite
//
//  Created by DCS on 10/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NoticeDetailVC: UIViewController {
    private var dState = [Int]()
    var not:[Notice] = []
    
    var Sql = SqLiteHandler.shared
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
    private let tableview = UITableView()
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
        view.addSubview(tableview)
        setuptable()
        not = Sql.Select_Notice()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myview.frame = CGRect(x: 0, y: view.height / 8, width: view.width, height: view.height / 2 + 400)
        myimg.frame = CGRect(x: view.width / 2 - 50 , y:view.height / 8 - 30 , width: 100, height: 100)
        label1.frame = CGRect(x:view.width / 2 - 50   , y:myimg.bottom + 10 , width: 100, height: 40)
        mybtn.frame = CGRect(x: view.width - 100 , y: 25, width: 80, height: 30)
        myview1.frame = CGRect(x: 0, y: label1.bottom + 10, width: view.width, height: view.height / 2 + 200)
        tableview.frame = CGRect(x: 0, y: label1.bottom + 30, width: view.width,  height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
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

extension NoticeDetailVC :UITableViewDelegate,UITableViewDataSource {
    private func setuptable(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(NoticecellTV.self, forCellReuseIdentifier: "notes")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return not.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "notes", for: indexPath) as! NoticecellTV
        
        cell.setupTodoCellWith(title: not[indexPath.row].nname, index: indexPath.row,and: (dState.contains(indexPath.row) ? true : false))
        
        cell.mybtn.addTarget(self, action: #selector(viewpage), for:.touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    @objc private func viewpage (_ sender : UIButton){
        
        let vc = NoticeViewVC(nid: not[sender.tag].nid)
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        nv.setNavigationBarHidden(true, animated: true)
        present(nv,animated: true)
    }

}
