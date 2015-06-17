//
//  CategoriesController.swift
//  JunkTime
//
//  Created by Quentin CHAUMETTE on 09/06/2015.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class CategoriesController: UITableViewController {
	
	
	var categoriesItems:NSMutableArray = NSMutableArray()
	var categoryTotalTime = 0
	var sessionsList:NSMutableArray=NSMutableArray()
	
	override func viewDidAppear(animated: Bool) {			    // called every time the view appears ( different than viewDidLoad() wich is only at init)

		
		var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
		
		var categoriesListFromUserDefaults:NSMutableArray? = userDefaults.objectForKey("categoryList") as? NSMutableArray
		
		var sessionsList:NSMutableArray? = userDefaults.objectForKey("sessionsList") as? NSMutableArray
	
		var tasksList:NSMutableArray? = userDefaults.objectForKey("tasksList") as? NSMutableArray
		
		if ((categoriesListFromUserDefaults) != nil){
			categoriesItems = categoriesListFromUserDefaults!
		}
		self.tableView.reloadData()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.leftBarButtonItem = self.editButtonItem()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoriesItems.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! customViewCell
		var categoriesItem:NSDictionary = categoriesItems.objectAtIndex(indexPath.row) as! NSDictionary
		
		// ————––––––– CALCULATE TOTAL TIME OF CATEGORY ––––––––––––––
		categoryTotalTime = 0
		var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
		
		if let abc = (userDefaults.objectForKey("sessionsList") as? NSMutableArray){
			sessionsList = userDefaults.objectForKey("sessionsList") as! NSMutableArray
			var categoryTitle = categoriesItem.objectForKey("categoryTitle") as? String
			
			for session in  sessionsList{
				var taskCategoryNotFiltered = session.objectForKey("categoryOfThisSession") as? String
				
				if (taskCategoryNotFiltered == categoryTitle){
					categoryTotalTime += Int(session.objectForKey("sessionTime") as! CFTimeInterval)
				}
				else{	}
			}
		}
		// ————––––––––————–––––––————–––––––————–––––––————–––––––————–––––––—––
		
		cell.configureCellWith(categoriesItem, totalTime: categoryTotalTime)
		
		return cell
	}
	
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return NO if you do not want the specified item to be editable.
		return true
	}
	
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			categoriesItems.removeObjectAtIndex(indexPath.row)
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		} else if editingStyle == .Insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	
	/*
	// Override to support rearranging the table view.
	override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
	
	}
	*/

	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	// Return NO if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "GoInCategory"){
			var selectedIndexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
			var listOfTasksController:ListOfTasksController = segue.destinationViewController as! ListOfTasksController
			listOfTasksController.CategoriesData = categoriesItems.objectAtIndex(selectedIndexPath.row) as! NSDictionary
		}
	}
}
