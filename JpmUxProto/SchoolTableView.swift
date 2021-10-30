//
//  SchoolTableView.swift
//  JpmUxProto
//
//  Created by Christophe Vichery on 10/29/21.
//

import UIKit

class SchoolTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let tool = Tool.share
    
    let schoolTvRc = UIRefreshControl()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        // View
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = .clear
        refreshControl = schoolTvRc
        showsVerticalScrollIndicator = false
        contentInsetAdjustmentBehavior = .never
        rowHeight = UITableView.automaticDimension
        translatesAutoresizingMaskIntoConstraints = false
        register(SchoolTableViewCell.self as AnyClass, forCellReuseIdentifier: "SchoolTableViewCell")
        
        // Refreash
        schoolTvRc.addTarget(self, action: #selector(tablevRefresh(_:)), for: .valueChanged)
    }
    
    @objc private func tablevRefresh(_ sender: Any) {
        schoolTvRc.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = UIView()
        return head
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tool.orientation == .landscape {
            return 64
        } else {
            if tool.device == .xPhone {
                return 96
            } else {
                return 64
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot = UIView()
        return foot
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SchoolTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "SchoolTableViewCell", for: indexPath) as? SchoolTableViewCell)!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
