//
//  SchoolTableView.swift
//  JpmUxProto
//
//  Created by Christophe Vichery on 10/29/21.
//

import UIKit

protocol SchoolTableViewDelegate {
    func mainGetData()
    func mainSchoolTvRefresh()
    func mainOpenSchool(school: School)
}

class SchoolTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var schoolTableViewDelegate: SchoolTableViewDelegate?
    
    let api = Api.share
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
        var rcDy: CGFloat = 0
        if tool.orientation == .landscape {
            rcDy = -64
        } else {
            if tool.device == .xPhone { rcDy = -96 } else { rcDy = -64 }
        }
        
        schoolTvRc.bounds = CGRect(x: schoolTvRc.bounds.origin.x, y: rcDy,
                                   width: schoolTvRc.bounds.size.width, height: schoolTvRc.bounds.size.height)
        schoolTvRc.addTarget(self, action: #selector(tablevRefresh(_:)), for: .valueChanged)
    }
    
    @objc private func tablevRefresh(_ sender: Any) {
        schoolTvRc.endRefreshing()
        schoolTableViewDelegate?.mainSchoolTvRefresh()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = UIView()
        return head
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tool.orientation == .landscape {
            return 64
        } else {
            if tool.device == .xPhone { return 96 } else { return 64 }
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
        return api.apiArrSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let school = api.apiArrSchools[indexPath.row]
        
        let cell:SchoolTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "SchoolTableViewCell", for: indexPath) as? SchoolTableViewCell)!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.schoolTvcNameLb.text = school.school_name
        cell.schoolTvcInfoLb.text = school.neighborhood
        
        if indexPath.row == api.apiArrSchools.count - 1 {
            schoolTableViewDelegate?.mainGetData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        schoolTableViewDelegate?.mainOpenSchool(school: api.apiArrSchools[indexPath.row])
    }
}
