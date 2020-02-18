//
//  RAMGPXAnalysis.swift
//  RAMSport
//
//  Created by rambo on 2020/2/14.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import SWXMLHash

class RAMGPXAnalysis: NSObject, XMLParserDelegate {
    
    var xml: XMLIndexer?
    
    lazy var gpxModel : RAMGPXModel = RAMGPXModel()
    /** 定义一个解析类 */
    lazy var xmlParser: XMLParser = XMLParser()
    /** 记录当前解析的节点 */
    var currentElementName: String?
    /** 记录当前解析的类的属性 */
    var currentParserDic: [String: String] = [:]
    /** 记录当前解析的类的数组 */
    var currentParserArray: [String] = []
    /** 接收解析出来的dic数据 */
    var modeDic: [String: String] = [:]
    /** 接收解析出来的array数据 */
    var modeArray: [String] = []
    
    override init() {
        super.init()
#if SWIFT_PACKAGE
        let path = NSString.path(withComponents: NSString(string: #file).pathComponents.dropLast() + ["letoursport30.gpx"])
#else
        let bundle = Bundle(for: RAMGPXAnalysis.self)
        let path = bundle.path(forResource: "letoursport30", ofType: "gpx")!
#endif
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        xml = SWXMLHash.lazy(data)
    }
    
    /// 获取解析到的XML数据
    ///
    /// - Returns: 包含EmoticonModel对象的数组
    func getGpxModel() -> RAMGPXModel{
//        //guard内部进行了获取XML文件路径的操作，需根据您的XML路径进行修改
//        //如果emjArray内元素个数不等于0，说明已经进行过XML解析、emjArray内有我们需要的值，则直接返回emjArray，否则继续
//        guard
//            gpxModel.trk == nil,
//            let path = Bundle.main.path(forResource: "letoursport8", ofType: "gpx")
//        else {
//            return gpxModel
//        }
//        //此处传入XML文件路径，用于XML解析，解析的过程在XMLParserDelegate回调中处理
//        let parser = XMLParser.init(contentsOf: URL.init(fileURLWithPath: path))
//        parser?.delegate = self
//        parser?.parse()
//        return gpxModel
        
        
        return RAMGPXModel()
        
    }
    
    func tloadMetaData() {
        for xmlIndexer in xml!["gpx"]["trk"]["trkseg"]["trkpt"].all {
            
            print("lat=\(String(describing: xmlIndexer.element?.attribute(by: "lat")?.text)), lon=\(xmlIndexer.element?.attribute(by: "lon")?.text ?? "")")
        }
    }
    
    //MARK:XMLParserDelegate的代理方法
    //解析到起始标签
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = elementName
        
        
        
//        print("elementName : \(elementName)")

//        switch elementName {
//        case "metadata":
//        case "wpt":
//        case "trk":
//        default:
//
//        }
//        if elementName == "Emoticon" {
//
////            let emoji = EmoticonModel.init(File: attributeDict["File"], ID: attributeDict["ID"], Tag: attributeDict["Tag"])
////            self.emjArray.append(emoji)
//        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElementName != nil {
            if isValidString(string) {
                
            }
        }
        print("string: \(string)")
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        print("CDATABlock: \(CDATABlock)")
    }
    
    func isValidString(_ string: Any?) -> Bool {
        if string != nil, string is String {
            if var strTmp = string as? String {
                strTmp = strTmp.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                return strTmp.count > 0
            }
            return false
        }
        return false
    }
}
