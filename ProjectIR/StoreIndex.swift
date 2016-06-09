//
//  StoreIndex.swift
//  ProjectIR
//
//  Created by Pongpanot Chuaysakun on 11/11/2558 BE.
//  Copyright © 2558 Pongpanot Chuaysakun. All rights reserved.
//

import Cocoa

class StoreIndex: NSObject {
    var index : [String:[String:Int]] = [:]
    override init() {
        super.init()
        index = loadFile()
    }
    func addIndexWithString(word:String! ,doc :String!){
        var page:[String:Int] = [:]
        if index[word] != nil{
            page = index[word]!
            if page[doc] != nil{
                page[doc] = page[doc]!+1
            }else{
                page[doc] = 1
            }
        }else{
            page[doc] = 1
        }
        index[word] = page
    }
    func loadFile() -> [String:[String:Int]]{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = paths.stringByAppendingPathComponent("/ProjectIR/ProjectIR/data.plist")
        let fileManager = NSFileManager.defaultManager()
        if (fileManager.fileExistsAtPath(path)){
            let save = NSDictionary(contentsOfFile: path)!
            return save["word"] as! [String:[String:Int]]
        }
        return [:]
    }
    func saveIndex(){
        saveGameData(index)
    }
    func saveGameData(index:[String:[String:Int]]) {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("/ProjectIR/ProjectIR/data.plist")
        let dict: NSMutableDictionary = ["word":index]
        dict.writeToFile(path, atomically: false)
    }
    func findIndex(word:String!) -> [String]{
        let docc = index[word] as [String:Int]!
        var t:[String] = []
        if docc != nil{
            for myKey in docc.keys {
                t.append(myKey)
            }
        }
        return t
    }

}
