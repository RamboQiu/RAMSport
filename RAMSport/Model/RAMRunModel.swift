//
//  RAMRunModel.swift
//  RAMSport
//
//  Created by rambo on 2020/2/19.
//  Copyright © 2020 rambo. All rights reserved.
//

import RealmSwift

/**
 * 一次运动记录
 */
class RAMRunModel: Object {
    /// 所属用户id
    @objc dynamic var userId = ""
    /// 运动发生的详细时间
    @objc dynamic var date = Date()
    /// 运动发生的年
    @objc dynamic var year = 0
    /// 运动发生的月
    @objc dynamic var month = 0
    /// 运动发生的日
    @objc dynamic var day = 0
    /// 运动轨迹
    @objc dynamic var gpxPath: RAMGPXModel? = RAMGPXModel()
    /// 运动距离
    @objc dynamic var distance = 0.0
    /// 运动时间
    @objc dynamic var time = 0
    /// 均速 每公里时间
    @objc dynamic var speed = 0
    /// 上升高度
    @objc dynamic var upDistance = 0.0
    /// 下降高度
    @objc dynamic var downDistance = 0.0
}
