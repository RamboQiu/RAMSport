//
//  RAMMonthRunModel.swift
//  RAMSport
//
//  Created by rambo on 2020/2/19.
//  Copyright © 2020 rambo. All rights reserved.
//

import RealmSwift

class RAMMonthRunModel: Object {
    @objc dynamic var date = Date()
    /// 年份
    @objc dynamic var year = 0
    /// 月份
    @objc dynamic var month = 0
    /// 跑步次数
    @objc dynamic var count = 0
    /// 总公里
    @objc dynamic var distance = 0.0
    /// 总时间
    @objc dynamic var time = 0.0
    /// 月所有跑步
    let runs = List<RAMRunModel>()
}
