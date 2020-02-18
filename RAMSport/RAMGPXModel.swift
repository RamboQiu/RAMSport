//
//  RAMGPXModel.swift
//  RAMSport
//
//  Created by rambo on 2020/2/14.
//  Copyright © 2020 rambo. All rights reserved.
//
// https://www.topografix.com/GPX/1/1/ gpx格式定义

import UIKit
import RealmSwift

/**
 * An email address. Broken into two parts (id and domain) to help prevent email harvesting.
 */
class RAMGPXEmailModel: Object {
    @objc dynamic var id = "qiujunyun"
    @objc dynamic var domain = "163.com"
 }

/**
 * A person or organization.
 */
class RAMGPXPersonModel: Object {
    @objc dynamic var name = "Rambo"
    @objc dynamic var email: RAMGPXEmailModel? = RAMGPXEmailModel()
}

/**
 * InfoRAMtion about the GPX file, author, and copyright restrictions goes in the metadata section. Providing rich, meaningful infoRAMtion about your GPX files allows others to search for and use your GPS data.
 */
class RAMGPXMetadataModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    @objc dynamic var author: RAMGPXPersonModel? = RAMGPXPersonModel()
}

/**
 * wpt represents a waypoint, point of interest, or named feature on a map.
 */
class RAMGPXWptModel: Object {
    /// 纬度 The latitude of the point. Decimal degrees, WGS84 datum.
    @objc dynamic var lat: Double = 0.0
    /// 经度 The longitude of the point. Decimal degrees, WGS84 datum.
    @objc dynamic var lon: Double = 0.0
    /// 海拔 单位m Elevation (in meters) of the point.
    @objc dynamic var ele: Double = 0.0
    /// The GPS name of the waypoint. This field will be transferred to and from the GPS. GPX does not place restrictions on the length of this field or the characters contained in it. It is up to the receiving application to validate the field before sending it to the GPS.
    @objc dynamic var name: String = ""
    /// A text description of the element. Holds additional information about the element intended for the user, not the GPS.
    @objc dynamic var desc: String = ""
    /// 到达这里的速度
    @objc dynamic var speed: Double = 0.0
    /// Creation/modification timestamp for element. Date and time in are in Univeral Coordinated Time (UTC), not local time! Conforms to ISO 8601 specification for date/time representation. Fractional seconds are allowed for millisecond timing in tracklogs. 1970-01-01T00:00:00Z
    @objc dynamic var time = Date()
}

/**
 * trk represents a track - an ordered list of points describing a path.
 */
class RAMGPXTrkModel: Object {
    /// GPS name of track.
    @objc dynamic var name: String = ""
    /// A Track Segment holds a list of Track Points which are logically connected in order. To represent a single GPS track where GPS reception was lost, or the GPS receiver was turned off, start a new Track Segment for each continuous span of track data.
    let trkseg = List<RAMGPXWptModel>()
}

/**
 * 一个gpx文件对象
 */
class RAMGPXModel: Object {
    /// Metadata about the file.
    @objc dynamic var metadata: RAMGPXMetadataModel? = RAMGPXMetadataModel()
    /// A list of waypoints
    let wpt = List<RAMGPXWptModel>()
    let trk = List<RAMGPXTrkModel>()
}

/**
 * 一次运动记录
 */
class RAMRunModel: Object {
    /// 运动发生时间
    @objc dynamic var date = Date()
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
