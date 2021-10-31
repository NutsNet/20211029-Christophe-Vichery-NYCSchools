//
//  SchoolTableViewCell.swift
//  JpmUxProto
//
//  Created by Christophe Vichery on 10/29/21.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    let tool = Tool.share
    
    let schoolTvcBackVi = UIView()
    let schoolTvcIv = UIImageView()
    let schoolTvcNameLb = UILabel()
    let schoolTvcInfoLb = UILabel()
    
    var dw: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Self
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        
        // Back
        var dh: CGFloat = 80
        if tool.device == .iPad || tool.device == .xPad { dh = 128 }
        
        dw = tool.currentDeviceWt - 48
        
        schoolTvcBackVi.backgroundColor = .white
        schoolTvcBackVi.contentMode = UIView.ContentMode.scaleAspectFill
        schoolTvcBackVi.translatesAutoresizingMaskIntoConstraints = false
        schoolTvcBackVi.layer.shadowColor = UIColor.black.cgColor
        schoolTvcBackVi.layer.shadowOffset = CGSize.zero
        schoolTvcBackVi.layer.shadowOpacity = 0.15
        schoolTvcBackVi.layer.shadowRadius = 4
        schoolTvcBackVi.layer.cornerRadius = 8
        addSubview(schoolTvcBackVi)
        
        let wtSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: dw)
        let htSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: dh)
        let hcSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let vtSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 24)
        let vbSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([wtSchoolTvcBackViCst, htSchoolTvcBackViCst, hcSchoolTvcBackViCst, vtSchoolTvcBackViCst, vbSchoolTvcBackViCst])
        
        // School image
        schoolTvcIv.image = UIImage(named: "school")
        schoolTvcIv.backgroundColor = UIColor(rgb: 0xeeeeee)
        schoolTvcIv.translatesAutoresizingMaskIntoConstraints = false
        schoolTvcIv.layer.shadowColor = UIColor.black.cgColor
        schoolTvcIv.layer.shadowOffset = CGSize.zero
        schoolTvcIv.layer.shadowOpacity = 0.15
        schoolTvcIv.layer.shadowRadius = 4
        schoolTvcIv.layer.cornerRadius = 4
        schoolTvcBackVi.addSubview(schoolTvcIv)
        
        let wtSchoolTvcIvCst = NSLayoutConstraint(item: schoolTvcIv, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: dh - 16)
        let htSchoolTvcIvCst = NSLayoutConstraint(item: schoolTvcIv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: dh - 16)
        let hlSchoolTvcIvCst = NSLayoutConstraint(item: schoolTvcIv, attribute: .left, relatedBy: .equal, toItem: schoolTvcBackVi, attribute: .left, multiplier: 1, constant: 8)
        let vtSchoolTvcIvCst = NSLayoutConstraint(item: schoolTvcIv, attribute: .top, relatedBy: .equal, toItem: schoolTvcBackVi, attribute: .top, multiplier: 1, constant: 8)
        NSLayoutConstraint.activate([wtSchoolTvcIvCst, htSchoolTvcIvCst, hlSchoolTvcIvCst, vtSchoolTvcIvCst])
        
        // Name
        var mul: CGFloat = 1
        if tool.device == .iPad || tool.device == .xPad { mul = 1.75 }
        
        schoolTvcNameLb.numberOfLines = 2
        schoolTvcNameLb.textColor = .darkGray
        schoolTvcNameLb.font =  UIFont(name: "Lato-Bold", size: 16*mul)
        schoolTvcNameLb.translatesAutoresizingMaskIntoConstraints = false
        schoolTvcNameLb.layer.shadowOffset = CGSize.zero
        schoolTvcNameLb.layer.shadowOpacity = 0.25
        schoolTvcNameLb.layer.shadowRadius = 2
        schoolTvcBackVi.addSubview(schoolTvcNameLb)
        
        let htSchoolTvcNameLbCst = NSLayoutConstraint(item: schoolTvcNameLb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (dh - 16)*2/3)
        let hlSchoolTvcNameLbCst = NSLayoutConstraint(item: schoolTvcNameLb, attribute: .left, relatedBy: .equal, toItem: schoolTvcIv, attribute: .right, multiplier: 1, constant: 8)
        let hrSchoolTvcNameLbCst = NSLayoutConstraint(item: schoolTvcNameLb, attribute: .right, relatedBy: .equal, toItem: schoolTvcBackVi, attribute: .right, multiplier: 1, constant: -8)
        let vtSchoolTvcNameLbCst = NSLayoutConstraint(item: schoolTvcNameLb, attribute: .top, relatedBy: .equal, toItem: schoolTvcIv, attribute: .top, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([htSchoolTvcNameLbCst, hlSchoolTvcNameLbCst, hrSchoolTvcNameLbCst, vtSchoolTvcNameLbCst])
        
        // Info
        schoolTvcInfoLb.textColor = .darkGray
        schoolTvcInfoLb.font =  UIFont(name: "Lato-Italic", size: 14*mul)
        schoolTvcInfoLb.translatesAutoresizingMaskIntoConstraints = false
        schoolTvcInfoLb.layer.shadowOffset = CGSize.zero
        schoolTvcInfoLb.layer.shadowOpacity = 0.25
        schoolTvcInfoLb.layer.shadowRadius = 2
        schoolTvcBackVi.addSubview(schoolTvcInfoLb)
        
        let htSchoolTvcInfoLbCst = NSLayoutConstraint(item: schoolTvcInfoLb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (dh - 16)/3)
        let hlSchoolTvcInfoLbCst = NSLayoutConstraint(item: schoolTvcInfoLb, attribute: .left, relatedBy: .equal, toItem: schoolTvcNameLb, attribute: .left, multiplier: 1, constant: 0)
        let hrSchoolTvcInfoLbCst = NSLayoutConstraint(item: schoolTvcInfoLb, attribute: .right, relatedBy: .equal, toItem: schoolTvcNameLb, attribute: .right, multiplier: 1, constant: 0)
        let vtSchoolTvcInfoLbCst = NSLayoutConstraint(item: schoolTvcInfoLb, attribute: .top, relatedBy: .equal, toItem: schoolTvcNameLb, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([htSchoolTvcInfoLbCst, hlSchoolTvcInfoLbCst, hrSchoolTvcInfoLbCst, vtSchoolTvcInfoLbCst])
    }
}
