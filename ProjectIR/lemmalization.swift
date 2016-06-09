//
//  lemmalization.swift
//  ProjectIR
//
//  Created by Pongpanot Chuaysakun on 11/25/2558 BE.
//  Copyright © 2558 Pongpanot Chuaysakun. All rights reserved.
//

import Foundation

class lemmalization {
    func stemming(var str : String ) ->[String]{
        str = "as " + str + " at"
        var tokens: [String] = []
        var pairs:[(String,String)] = []
        let options:NSLinguisticTaggerOptions = [.OmitWhitespace , .OmitPunctuation , .OmitOther] //ออปชั่นที่ต้องการใช้ใช้การตัดคำ ในที่นี้เราเลือก เว้นวรรค วรรคตอน และ symbol
        let schemes = NSLinguisticTagger.availableTagSchemesForLanguage("en") //เป็นการกำหนด schems ว่ามีออปชั่นอะไรบ้าง สำหรับภาษานี้
        let range = NSRange(location: 0, length: str.characters.count) //ขอบเขตของคำ
        let tagger = NSLinguisticTagger(tagSchemes:schemes, options: Int(options.rawValue))
        tagger.string = str
        //ฟังก์ชั่นนี้จะทำการตัดคำทีละคำ แล้วเอาไปทำงานตามที่ตั้งไว้ ในที่นี้เลือก lemme ซึ่งหมายถึง การทำ stem word
        tagger.enumerateTagsInRange(range, scheme: NSLinguisticTagSchemeLemma , options: options) { (tag: String?, tokenRange, range, stop) in
            if let tag = tag {
                //tag = self.deleteUnwantedWord(tag)
                let token = (str as NSString).substringWithRange(tokenRange)
                    if token.characters.count > 2{
                    //   self.indexDoc.addIndexWithString(tag, doc: url)
                        tokens.append(tag.lowercaseString)
                    }
                 let pair = (token, tag.lowercaseString)
                 pairs.append(pair)
            }
        }
        //print(pairs)
        return tokens
    }
    func deleteUnwantedWord(var string:String!) ->String!{
        string = string.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        string = string.stringByReplacingOccurrencesOfString("have", withString: "")
        /*string = string.stringByReplacingOccurrencesOfString(".", withString: "")
        string = string.stringByReplacingOccurrencesOfString("\"", withString: "")
        string = string.stringByReplacingOccurrencesOfString("(", withString: "")
        string = string.stringByReplacingOccurrencesOfString(")", withString: "")
        string = string.stringByReplacingOccurrencesOfString("\n", withString: "")
        string = string.stringByReplacingOccurrencesOfString("\t", withString: "")
        string = string.stringByReplacingOccurrencesOfString(",", withString: "")
        string = string.stringByReplacingOccurrencesOfString("?", withString: "")
        string = string.stringByReplacingOccurrencesOfString("{", withString: "")
        string = string.stringByReplacingOccurrencesOfString("}", withString: "")
        string = string.stringByReplacingOccurrencesOfString("*", withString: "")
        string = string.stringByReplacingOccurrencesOfString("[", withString: "")
        string = string.stringByReplacingOccurrencesOfString("]", withString: "")
        string = string.stringByReplacingOccurrencesOfString("$", withString: "")
        string = string.stringByReplacingOccurrencesOfString("#", withString: "")
        string = string.stringByReplacingOccurrencesOfString("!", withString: "")
        string = string.stringByReplacingOccurrencesOfString("%", withString: "")
        string = string.stringByReplacingOccurrencesOfString("\\", withString: "")
        string = string.stringByReplacingOccurrencesOfString("/", withString: "")
        string = string.stringByReplacingOccurrencesOfString("^", withString: "")
        string = string.stringByReplacingOccurrencesOfString("&", withString: "")
        string = string.stringByReplacingOccurrencesOfString("<", withString: "")
        string = string.stringByReplacingOccurrencesOfString(">", withString: "")
        string = string.stringByReplacingOccurrencesOfString("=", withString: "")
        string = string.stringByReplacingOccurrencesOfString("+", withString: "")
        string = string.stringByReplacingOccurrencesOfString(":", withString: " ")
        string = string.stringByReplacingOccurrencesOfString(";", withString: "")
        string = string.stringByReplacingOccurrencesOfString("'s", withString: " ")*/
        return string
    }
}