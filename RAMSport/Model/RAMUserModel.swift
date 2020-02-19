//
//  RAMUserModel.swift
//  RAMSport
//
//  Created by rambo on 2020/2/19.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import RealmSwift

class RAMUserModel: Object {
    @objc dynamic var id = NSUUID().uuidString
    /// 用户创建时间
    @objc dynamic var date = Date()
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var sex = ""
    /// 头像图片data数据
    @objc dynamic var head: Data?
    /// 用户的所有运动记录
    let runs = List<RAMRunModel>()
}
