//
//  NoticecellTV.swift
//  StudentAdmissionSqLite
//
//  Created by DCS on 10/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NoticecellTV: UITableViewCell {

    private let Mylabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    public let mybtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Eyes"), for: .normal)
        btn.layer.cornerRadius = 15
        return btn
    }()
    private let myview:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:1  ,green: 0.598 ,blue: 0.227 ,alpha: 0.4)
        
        return view
    }()
    func setupTodoCellWith(title name:String ,  index:Int,and state:Bool){
        
        Mylabel.text = name.components(separatedBy: ".").first
        mybtn.tag = index
       
        setupUI(at: index, with: state)
    }
    
    private func setupUI(at index:Int, with state:Bool) {
        contentView.addSubview(myview)
        contentView.addSubview(Mylabel)
        contentView.addSubview(mybtn)
        
        myview.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height)
        Mylabel.frame = CGRect(x: 10, y:10, width: 140, height: 40)
        mybtn.frame = CGRect(x: contentView.width - 50, y: 10, width: 30, height: 30)
        
    }
    

}
