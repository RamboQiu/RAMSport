//
//  RAMGPXModel.swift
//  RAMSport
//
//  Created by rambo on 2020/2/14.
//  Copyright © 2020 rambo. All rights reserved.
//
// https://www.topografix.com/GPX/1/1/ gpx格式定义

import UIKit

/**
 * An email address. Broken into two parts (id and domain) to help prevent email harvesting.
 */
class RAMGPXEmailModel: NSObject {
    var id: String = "qiujunyun"
    var domain: String = "163.com"
 }

/**
 * A person or organization.
 */
class RAMGPXPersonModel: NSObject {
    var name: String = "Rambo"
    var email: RAMGPXEmailModel?
}

/**
 * InfoRAMtion about the GPX file, author, and copyright restrictions goes in the metadata section. Providing rich, meaningful infoRAMtion about your GPX files allows others to search for and use your GPS data.
 */
class RAMGPXMetadataModel: NSObject {
    var name: String = ""
    var desc: String = ""
    var author: RAMGPXPersonModel?
}

/**
 * wpt represents a waypoint, point of interest, or named feature on a map.
 */
class RAMGPXWptModel: NSObject {
    /// 纬度 The latitude of the point. Decimal degrees, WGS84 datum.
    var lat: Double = 0.0
    /// 经度 The longitude of the point. Decimal degrees, WGS84 datum.
    var lon: Double = 0.0
    /// 海拔 单位m Elevation (in meters) of the point.
    var ele: Double = 0.0
    /// The GPS name of the waypoint. This field will be transferred to and from the GPS. GPX does not place restrictions on the length of this field or the characters contained in it. It is up to the receiving application to validate the field before sending it to the GPS.
    var name: String = ""
    /// 到达这里的速度
    var speed: Double = 0.0
}

/**
 * wpt represents a waypoint, point of interest, or named feature on a map.
 */
class RAMGPXTrkptModel: NSObject {
    /// 纬度 The latitude of the point. Decimal degrees, WGS84 datum.
    var lat: Double = 0.0
    /// 经度 The longitude of the point. Decimal degrees, WGS84 datum.
    var lon: Double = 0.0
    /// 海拔 单位m Elevation (in meters) of the point.
    var ele: Double = 0.0
    /// Creation/modification timestamp for element. Date and time in are in Univeral Coordinated Time (UTC), not local time! Conforms to ISO 8601 specification for date/time representation. Fractional seconds are allowed for millisecond timing in tracklogs. 1970-01-01T00:00:00Z
    var time: String = ""
    /// 到达这里的速度
    var speed: Double = 0.0
}

/**
 * trk represents a track - an ordered list of points describing a path.
 */
class RAMGPXTrkModel: NSObject {
    /// GPS name of track.
    var name: String = ""
    /// A Track Segment holds a list of Track Points which are logically connected in order. To represent a single GPS track where GPS reception was lost, or the GPS receiver was turned off, start a new Track Segment for each continuous span of track data.
    var trkseg: [RAMGPXTrkptModel]?
}

/**
 * 一个gpx文件对象
 */
class RAMGPXModel: NSObject {
    /// Metadata about the file.
    var metadata: RAMGPXMetadataModel?
    /// A list of waypoints
    var wpt: [RAMGPXWptModel]?
    var trk: [RAMGPXTrkModel]?
}
