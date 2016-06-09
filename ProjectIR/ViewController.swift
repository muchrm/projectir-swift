//
//  ViewController.swift
//  ProjectIR
//
//  Created by Pongpanot Chuaysakun on 11/9/2558 BE.
//  Copyright © 2558 Pongpanot Chuaysakun. All rights reserved.
//

import Cocoa

class ViewController: NSViewController ,NSTableViewDataSource , NSTableViewDelegate{
    var web_arr: [String]! {
        let LoadFile = NSBundle.mainBundle().URLForResource("Url", withExtension: "plist")
        let Data = NSArray(contentsOfURL: LoadFile!) as! [String]!
        NSBundle.mainBundle()
        return Data!
    }
    @IBOutlet var tableView: NSTableView!
    var arr_url : [String] = Array()
    var web_str : [String] = Array()
    var web_word : [WebWord] = Array()
    var data : WebWord = WebWord()
    let indexDoc = StoreIndex()
    let lemma = lemmalization()
    @IBOutlet weak var text: NSTextField!
    @IBOutlet weak var result: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getContentURL()
        indexDoc.saveIndex()
    }
    
    func getContentURL(){
        
        for var index = 0; index < web_arr.count ; ++index{
            if let url = NSURL(string: web_arr[index]) {
                do {
                    let content = try String(contentsOfURL: url, usedEncoding: nil)
                    let index1 = content.rangeOfString("<p>" )
                    let index2 = content.rangeOfString("<h3 class=\"about_author\">About the Author</h3>" )
                    let string = content.substringWithRange(Range<String.Index>(start: index1!.first!, end: index2!.first!))
                    //print(string)
                    web_str.append(string)
                    let link : String = web_arr[index]
                    //print(link)
                    data.link = link
                    getWord(web_str[index] , url: web_arr[index])
                } catch {
                    // contents could not be loaded
                }
            } else {
                // the URL was bad!
            }
        }
        
    }
    
    func  getWord( str : String , url:String){
        for token in lemma.stemming(str) {
            self.indexDoc.addIndexWithString(token, doc: url)
        }
    }
    
    
    @IBAction func searchText(sender: AnyObject) {
       // arr_url = indexDoc.findIndex(text.stringValue)
        arr_url = []
        var url:[String] = []
        let tokens = lemma.stemming(text.stringValue)
        if tokens.count != 1 {
            for token in tokens{
                if url.count == 0{
                    url = indexDoc.findIndex(token)
                }else{
                    let tmp = indexDoc.findIndex(token)
                    let set1 = Set(url)
                    let set2 = Set(tmp)
                    arr_url = Array(set1.intersect(set2))
                    url = arr_url
                }
            }
        }else{
            print(tokens[0])
            arr_url = indexDoc.findIndex(tokens[0])
            //print(arr_url)
        }
        self.tableView.reloadData()
        
    }
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return arr_url.count
    }
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 1
        let cellView = tableView.makeViewWithIdentifier("mycell", owner: self) as! TableViewCell
        
        // 2
        if tableColumn!.identifier == "BugColumn" {
            // 3
            cellView.textField!.stringValue = arr_url[row]
            return cellView
        }
        
        return cellView
    }
    func tableViewSelectionDidChange(notification: NSNotification) {
      let row = tableView.selectedRow
        let strURL = arr_url[row]
        if let checkURL = NSURL(string: strURL ) {
            if NSWorkspace.sharedWorkspace().openURL(checkURL) {
                print("url successfully opened")
            }
        } else {
            print("invalid url")
        }
    }
    

}

