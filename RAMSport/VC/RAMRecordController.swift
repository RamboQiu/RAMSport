//
//  RAMUserRecordController.swift
//  RAMSport
//
//  Created by rambo on 2020/2/16.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import RealmSwift

class RAMRecordController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!

    var notificationToken: NotificationToken?
    var realm: Realm!
    var objectsBySection = [Results<RAMRunModel>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        realm = try! Realm()
        
        notificationToken = realm.observe { [unowned self] _, _ in
            self.tableView.reloadData()
        }
        
        let sortedObjects = realm.objects(RAMMonthRunModel.self).sorted(byKeyPath: "date", ascending: false)
        for monthRunModel in sortedObjects {
            let groupByMonthObjects = realm.objects(RAMRunModel.self).filter("year == \(monthRunModel.year) && month == \(monthRunModel.month)").sorted(byKeyPath: "date", ascending: false)
            objectsBySection.append(groupByMonthObjects)
        }
    }

    func setupUI() {
        tableView.register(RAMRecordTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(RAMRecordSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")

//        self.title = "GroupedTableView"
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BG Add", style: .plain, target: self, action: #selector(TableViewController.backgroundAdd))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TableViewController.add))
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsBySection[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectsBySection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RAMRecordTableViewCell

        let object = objectsBySection[indexPath.section][indexPath.row]
        cell.titleLabel.text = "星期日 下午跑"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        cell.timeLabel.text = dateFormatter.string(from: object.date)
        cell.descLabel.text = "\(object.distance) \(object.speed) \(object.time)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? RAMRecordSectionHeaderView
        let object = objectsBySection[section].first!
        headerView?.titleLabel.text = "\(object.year)年\(object.month)月"
        headerView?.descLabel.text = "1次跑步 7.95公里 6‘41’‘/公里"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}
