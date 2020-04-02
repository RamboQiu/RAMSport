//
//  RAMDetailController.swift
//  RAMSport
//
//  Created by rambo on 2020/2/19.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import SnapKit

enum RAMDetailFrom: Int {
    case running
    case record
}

class RAMDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var staticList = [RAMStaticTableCellData]()
    
    var from: RAMDetailFrom = .record

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if from == .running {
            if var array = self.navigationController?.viewControllers {
                array.remove(at: array.count - 2)
                self.navigationController?.viewControllers = array
            }
            
        }
        setUI()
        
    }
    
    func setUI() {
        applyWhiteNavigationBarStyle()
        
        let dateData = RAMStaticTableCellData()
        dateData.cellClass = RAMDetailDateTableViewCell.self
        dateData.cellIdentifier = NSStringFromClass(dateData.cellClass!)
        tableView.register(dateData.cellClass, forCellReuseIdentifier: dateData.cellIdentifier!)
        dateData.cellCustomSEL = #selector(custom(dateCell:with:))
        dateData.cellHeight = RAMDetailDateTableViewCell.cellHeight()
        staticList.append(dateData)
        
        let infoData = RAMStaticTableCellData()
        infoData.cellClass = RAMDetailInfoTableViewCell.self
        infoData.cellIdentifier = NSStringFromClass(infoData.cellClass!)
        tableView.register(infoData.cellClass, forCellReuseIdentifier: infoData.cellIdentifier!)
        infoData.cellCustomSEL = #selector(custom(infoCell:with:))
        infoData.cellHeight = RAMDetailInfoTableViewCell.cellHeight()
        staticList.append(infoData)
        
        let mapData = RAMStaticTableCellData()
        mapData.cellClass = RAMDetailMapTableViewCell.self
        mapData.cellIdentifier = NSStringFromClass(mapData.cellClass!)
        tableView.register(mapData.cellClass, forCellReuseIdentifier: mapData.cellIdentifier!)
        mapData.cellCustomSEL = #selector(custom(mapCell:with:))
        mapData.cellHeight = RAMDetailMapTableViewCell.cellHeight()
        staticList.append(mapData)
    }
    
    @objc func custom(dateCell cell: RAMDetailDateTableViewCell, with data:RAMStaticTableCellData) {
        cell.timeLabel.text = "2020/2/2 - 16:31"
        cell.titleTextField.text = "星期日 下午跑"
    }
    
    @objc func custom(infoCell cell: RAMDetailInfoTableViewCell, with data:RAMStaticTableCellData) {
        cell.distance = 1217.999
        cell.speedLabel.text = "6'52''"
        cell.timeLabel.text = "52:23"
        cell.kaluliLabel.text = "2323232322"
        cell.upLabel.text = "24m"
        cell.downLabel.text = "24m"
    }
    
    @objc func custom(mapCell cell: RAMDetailMapTableViewCell, with data:RAMStaticTableCellData) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staticList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let staticData = staticList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: staticData.cellIdentifier!, for: indexPath)
        cell.selectionStyle = .none
        if let sel = staticData.cellCustomSEL {
            perform(sel, with: cell, with: staticData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return staticList[indexPath.row].cellHeight
    }
    
}
