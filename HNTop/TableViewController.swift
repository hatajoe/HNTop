//
//  TableViewController.swift
//  HNTop
//
//  Created by hatanakayusuke on 2/26/16.
//  Copyright © 2016 hatanakayusuke. All rights reserved.
//

import UIKit
import APIKit

struct ListData {
    var ID: Int
    var Author: String
    var Score: Int
    var Time: Int
    var Title: String
    var Url: String
}

class TableViewController: UITableViewController {
    var List :[ListData]
    
    required init?(coder aDecoder:NSCoder) {
        self.List = []
        super.init(coder:aDecoder)
        // エンドポイント用のクラスを生成する
        let request = HNTopRequest()
        // WebAPIへのアクセス
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let response): // 成功時は、Weather型のデータが取得できる
                let sliced = response.IDList[0..<5]
                for ID in sliced {
                    let r = HNStoryRequest.init(ID: ID)
                    Session.sendRequest(r) { result in
                        switch result {
                        case .Success(let res): // 成功時は、Weather型のデータが取得できる
                            self.List.append(ListData(ID: res.ID, Author: res.Author, Score: res.Score, Time: res.Time, Title: res.Title, Url: res.Url))
                            self.tableView.reloadData()
                        case .Failure(let error): // 失敗した場合、NSError型となる
                            print("error: \(error)")
                        }
                    }
                }
            case .Failure(let error): // 失敗した場合、NSError型となる
                print("error: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return List.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let data=List[indexPath.row] as ListData
//        cell.textLabel?.text=data.Title
//        cell.detailTextLabel?.text=data.Author
        let l1 = cell.contentView.viewWithTag(1) as! UILabel
        l1.text = "\(data.Score)"
        let l2 = cell.contentView.viewWithTag(2) as! UILabel
        l2.text = data.Title
        let l3 = cell.contentView.viewWithTag(3) as! UILabel
        l3.text = data.Author
        let l4 = cell.contentView.viewWithTag(4) as! UILabel
        l4.text = "\(data.Time)"
        return cell
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="ShowPage" {
            if let indexPath=self.tableView.indexPathForSelectedRow{
                let data=List[indexPath.row] as ListData
                (segue.destinationViewController as! ViewController).detailItem = data
            }
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
}
