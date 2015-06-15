//
//  ListOfTasksController.swift
//  JunkTime
//
//  Created by Quentin CHAUMETTE on 09/06/2015.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class ListOfTasksController: UITableViewController {
	
	@IBOutlet var CategoryTitle: UILabel! = UILabel()
	
	var CategoriesData:NSDictionary = NSDictionary()
	
	var tasksList:NSMutableArray = NSMutableArray()
	
	var tasksListNotFiltered:NSMutableArray = NSMutableArray()
	
	
	
	
	
	override func viewDidAppear(animated: Bool) {

		var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
		
		var tasksListFromUserDefaults:NSMutableArray? = userDefaults.objectForKey("tasksList") as? NSMutableArray
		
		if ((tasksListFromUserDefaults) != nil){
			tasksListNotFiltered = tasksListFromUserDefaults!
		}
	
		tasksList = NSMutableArray()
		
// ————––––––– TASK FILTER : TREATMENT TO DISPLAY ONLY TASKS OF THE CATEGORY ––––––––––––––

		var belongToThisCategory = CategoriesData.objectForKey("categoryTitle") as? String

		for task in tasksListNotFiltered {
			var taskCategoryNotFiltered = task.objectForKey("categoryOfThisTask") as? String
			
			if (taskCategoryNotFiltered == belongToThisCategory){
				tasksList.addObject(task)										  // we create a new list of filtered tasks (wich belong to the category)
			}
		}
// ————––––––––————–––––––————–––––––————–––––––————–––––––————–––––––—––
		
		self.tableView.reloadData()
	}
	

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		 self.navigationItem.title = CategoriesData.objectForKey("categoryTitle") as? String
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasksList.count
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! customTasksViewCell
		

		
		var taskItem:NSDictionary = tasksList.objectAtIndex(indexPath.row) as! NSDictionary

		cell.configureCellWith(taskItem)
		
		
		  return cell
	}
	
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	// Return NO if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
	if editingStyle == .Delete {
	// Delete the row from the data source
	tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
	} else if editingStyle == .Insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
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
		if (segue.identifier == "showEvent"){
			var selectedIndexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
			var eventController:EventController = segue.destinationViewController as! EventController
			eventController.TasksData = tasksList.objectAtIndex(selectedIndexPath.row) as! NSDictionary
			
		}
		else if (segue.identifier == "goToAddTask"){
			var addTaskController:AddTaskController = segue.destinationViewController as! AddTaskController
			addTaskController.CategoryContainer = (CategoriesData.objectForKey("categoryTitle") as? String)!
		}
	}

	
}
