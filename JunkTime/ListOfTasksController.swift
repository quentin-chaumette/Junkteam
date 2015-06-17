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
	var catTotalTime = 0
	var tasksList:NSMutableArray = NSMutableArray()
	
	var tasksListNotFiltered:NSMutableArray = NSMutableArray()
	
	@IBOutlet var categoryTotalTime: UILabel!
	
	var taskTotalTime = 0
	
	var sessionsList:NSMutableArray=NSMutableArray()
	
	override func viewDidAppear(animated: Bool) {
		
		var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()

		// ————––––––– CALCULATE TOTAL TIME OF CATEGORY ––––––––––––––
		catTotalTime = 0
		
		if let abc = (userDefaults.objectForKey("sessionsList") as? NSMutableArray){
			var sessionsList = userDefaults.objectForKey("sessionsList") as! NSMutableArray
			var categoryTitle = CategoriesData.objectForKey("categoryTitle") as? String
			
			for session in  sessionsList{
				var taskCategoryNotFiltered = session.objectForKey("categoryOfThisSession") as? String
				
				if (taskCategoryNotFiltered == categoryTitle){
					catTotalTime += Int(session.objectForKey("sessionTime") as! CFTimeInterval)
				}
				else{	}
			}
		}

		
		categoryTotalTime.text = TimeFormatter.cleanTimeFormat(catTotalTime)
		// ————––––––––————–––––––————–––––––————–––––––————–––––––————–––––––—––
		
		
		var tasksListFromUserDefaults:NSMutableArray? = userDefaults.objectForKey("tasksList") as? NSMutableArray
		
		if ((tasksListFromUserDefaults) != nil){
			tasksListNotFiltered = tasksListFromUserDefaults!
		}
		
		tasksList = NSMutableArray()
		
		// ————––––––– TASK FILTER : TREATMENT TO DISPLAY ONLY TASKS OF THE CATEGORY ––––––––––––––
		
		var thisCategory = CategoriesData.objectForKey("categoryTitle") as? String
		
		for task in tasksListNotFiltered {
			var taskCategoryNotFiltered = task.objectForKey("categoryOfThisTask") as? String
			
			if (taskCategoryNotFiltered == thisCategory){
				tasksList.addObject(task)										  // we create a new list of filtered tasks (wich belong to the category)
			}
		}
		// ————––––––––————–––––––————–––––––————–––––––————–––––––————–––––––—––
		
		self.tableView.reloadData()
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		var btn = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "backBtnClicked")
		self.navigationController?.navigationBar.topItem?.backBarButtonItem=btn
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
		
		// ————––––––– CALCULATE TOTAL TIME OF TASK ––––––––––––––
		taskTotalTime = 0
		var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
		
		if let abc = (userDefaults.objectForKey("sessionsList") as? NSMutableArray){
			sessionsList = userDefaults.objectForKey("sessionsList") as! NSMutableArray
			var taskTitle = taskItem.objectForKey("taskTitle") as? String
			
			for session in  sessionsList{
				var taskOfThisSession = session.objectForKey("taskOfThisSession") as? String
				
				if (taskOfThisSession == taskTitle){
					taskTotalTime += Int(session.objectForKey("sessionTime") as! CFTimeInterval)
				}
				else{	}
			}
		}
		// ————––––––––————–––––––————–––––––————–––––––————–––––––————–––––––—––
		
		cell.configureCellWith(taskItem, taskTotalTime: taskTotalTime)
		
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
			// Delete the row from the data source
			var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
			var tasksListFromUserDefaults:NSMutableArray = userDefaults.objectForKey("tasksList") as! NSMutableArray
			var sessionsListFromUserDefaults:NSMutableArray = userDefaults.objectForKey("sessionsList") as! NSMutableArray
			var objectToDelete=tasksList.objectAtIndex(indexPath.row) as! NSDictionary
	
			/*
// –––––––––––– DELETE THE SESSIONS OF THE DELETED TASK ––––––––––––––––––
			for session in  sessionsListFromUserDefaults{
				var taskOfRecordedSession = session.objectForKey("taskOfThisSession") as! String
				var taskToDelete = objectToDelete.objectForKey("taskTitle") as! String
				var categoryOfRecordedSession = session.objectForKey("categoryOfThisSession") as! String
				var categoryOfTaskToDelete = objectToDelete.objectForKey("categoryOfThisTask") as! String

				println("that session in the for = = = = = = = = = ")
				println(session)
				
				if (taskOfRecordedSession == taskToDelete && categoryOfRecordedSession == categoryOfTaskToDelete){
					// will not be added in the new list that replace the old one
					println("that session to delete !! ")
					sessionsListFromUserDefaults.removeObject(session)

				}
				else{
					println("ELSE ")
				}
			}
			userDefaults.removeObjectForKey("sessionsList")
			userDefaults.setObject(sessionsListFromUserDefaults, forKey: "sessionsList")
			userDefaults.synchronize()
			
// –––––––––––– DELETE TASK IN USER DEFAULTS ––––––––––––––––––
			for task in  tasksListFromUserDefaults{
				var taskRecordedDate = task.objectForKey("dateOfTaskCreation") as! NSDate
				var taskToDeleteDate = objectToDelete.objectForKey("dateOfTaskCreation") as! NSDate

				if (taskRecordedDate == taskToDeleteDate){
				        // will not be added in the new list that replace the old one
					println("that task to delete !! ")
					tasksListFromUserDefaults.removeObject(task)
					userDefaults.removeObjectForKey("tasksList")
					userDefaults.setObject(tasksListFromUserDefaults, forKey: "tasksList")
					userDefaults.synchronize()
				}
				else{
					println("ELSE ")
				}
			}


// ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
		*/
			tasksList.removeObjectAtIndex(indexPath.row)
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
		if (segue.identifier == "showEvent"){
			var selectedIndexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
			var eventController:EventController = segue.destinationViewController as! EventController
			eventController.TasksData = tasksList.objectAtIndex(selectedIndexPath.row) as! NSDictionary
			eventController.CategoryContainer = (CategoriesData.objectForKey("categoryTitle") as? String)!
		}
		else if (segue.identifier == "goToAddTask"){
			var addTaskController:AddTaskController = segue.destinationViewController as! AddTaskController
			addTaskController.CategoryContainer = (CategoriesData.objectForKey("categoryTitle") as? String)!
		}
	}
	
	
}
