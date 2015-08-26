//
//  TableViewController.swift
//  ParseSample01
//
//  Created by k on 2015/08/24.
//  Copyright (c) 2015年 FranLiber Inc. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TableViewController: PFQueryTableViewController {
    
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Configure the PFQueryTableView
        self.parseClassName = "Articles"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 30
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Articles")
        query.orderByAscending("createdAt")
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }

        // Extract values from the PFObject to display in the table cell
        if let title = object?["title"] as? String {
            cell.textLabel?.text = title
        }
        if let body = object?["body"] as? String {
            cell.detailTextLabel?.text = body
        }
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        // Get the new view controller using [segue destinationViewController].
        var detailScene = segue.destinationViewController as! DetailViewController

        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let row = Int(indexPath.row)
            detailScene.currentObject = (objects?[row] as? PFObject)
        }
    }

    override func viewDidAppear(animated: Bool) {

        // Refresh the table to ensure any data changes are displayed
        tableView.reloadData()
    }
    
    @IBAction func add(sender: UIBarButtonItem) {
        // MainThread
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("TableViewToDetailView", sender: self)
        }
    }
}


