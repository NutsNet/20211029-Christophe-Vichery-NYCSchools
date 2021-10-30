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
        schoolTvcBackVi.layer.cornerRadius = 8
        schoolTvcBackVi.layer.shadowColor = UIColor.black.cgColor
        schoolTvcBackVi.layer.shadowOffset = CGSize(width: 0, height: 0)
        schoolTvcBackVi.layer.shadowRadius = 4
        schoolTvcBackVi.layer.shadowOpacity = 0.15
        addSubview(schoolTvcBackVi)
        
        let wtSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: dw)
        let htSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: dh)
        let hcSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let vtSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 24)
        let vbSchoolTvcBackViCst = NSLayoutConstraint(item: schoolTvcBackVi, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([wtSchoolTvcBackViCst, htSchoolTvcBackViCst, hcSchoolTvcBackViCst, vtSchoolTvcBackViCst, vbSchoolTvcBackViCst])
    }
}
