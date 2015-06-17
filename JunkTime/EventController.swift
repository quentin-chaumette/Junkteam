//
//  EventController.swift
//  JunkTime
//
//  Created by Quentin CHAUMETTE on 14/06/2015.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit
import QuartzCore

class EventController: UITableViewController {
	
	var TasksData:NSDictionary = NSDictionary()
	var CategoryContainer:String = String()
	var TaskContainer:String = String()
	
	@IBOutlet var numberOfEvents: UILabel!
	
	@IBOutlet var totalTimeOfThisTask: UILabel!
	
	var taskTotalTime = 0
	
	@IBOutlet var taskDateOfCreation: UILabel!
	
	@IBOutlet var SessionTitle: UITextField! = UITextField()
	
	var sessionsList:NSMutableArray = NSMutableArray()
	
	
	
	var sessionsListNotFiltered:NSMutableArray = NSMutableArray()
	
	// –––– CHRONO–––
	@IBOutlet var startStopButton: UIButton!
	@IBOutlet var saveButton: UIButton!
	@IBOutlet var numericDisplay: UILabel!
	var displayLink: CADisplayLink!
	var lastDisplayLinkTimeStamp: CFTimeInterval!
	// –––––––––––––––
	
	override func viewDidAppear(animated: Bool) {
		
		var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()

		// ————––––––– CALCULATE TOTAL TIME OF TASK ––––––––––––––
		taskTotalTime = 0
		
		
		if let abc = (userDefaults.objectForKey("sessionsList") as? NSMutableArray){
			sessionsList = userDefaults.objectForKey("sessionsList") as! NSMutableArray
			var taskTitle = TasksData.objectForKey("taskTitle") as? String
			
			for session in  sessionsList{
				var taskOfThisSession = session.objectForKey("taskOfThisSession") as? String
				
				if (taskOfThisSession == taskTitle){
					taskTotalTime += Int(session.objectForKey("sessionTime") as! CFTimeInterval)
				}
				else{	}
			}
		}
		var str = "\(taskTotalTime)"
		totalTimeOfThisTask.text = str
		// ————––––––––————–––––––————–––––––————–––––––————–––––––————–––––––—––
		
		
		var sessionsListFromUserDefaults:NSMutableArray? = userDefaults.objectForKey("sessionsList") as? NSMutableArray
		
		if ((sessionsListFromUserDefaults) != nil){
			sessionsListNotFiltered = sessionsListFromUserDefaults!
		}
		
		sessionsList = NSMutableArray()
		
		// ————––––––– SESSIONS FILTER : TREATMENT TO DISPLAY ONLY SESSIONS OF THE TASK/EVENT ––––––––––––––
		
		var thisTask = TasksData.objectForKey("taskTitle") as? String
		var thisCategory = TasksData.objectForKey("categoryOfThisTask") as? String
		
		for session in sessionsListNotFiltered {
			var taskOfThisSession = session.objectForKey("taskOfThisSession") as? String
			var categoryOfThisSession = session.objectForKey("categoryOfThisSession") as? String
			
			if (taskOfThisSession == thisTask && categoryOfThisSession == thisCategory){
				sessionsList.addObject(session)										  // we create a new list of filtered tasks (wich belong to the category)
			}
		}
		// ————––––––––————–––––––————–––––––————–––––––————–––––––————–––––––—–
		var sessionsListReversed:NSMutableArray =  NSMutableArray(array: sessionsList.reverseObjectEnumerator().allObjects).mutableCopy() as! NSMutableArray
		sessionsList = sessionsListReversed
		
	var date = dateformatterDate(TasksData.objectForKey("dateOfTaskCreation") as! NSDate) as String
		taskDateOfCreation.text = "since " + date
		
		
		self.tableView.reloadData()
	}
	
	func dateformatterDate(date: NSDate) -> NSString{
		var dateFormatter: NSDateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy"
		dateFormatter.timeZone = NSTimeZone.localTimeZone()
		return dateFormatter.stringFromDate(date)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		var btn = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "backBtnClicked")
		self.navigationController?.navigationBar.topItem?.backBarButtonItem=btn
		self.navigationItem.title = TasksData.objectForKey("taskTitle") as? String
		
		// –––––––– CHRONO ––––––––––––
		self.numericDisplay.text = "0.00"
		self.saveButton.setTitle("Save", forState: UIControlState.Normal)
		self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
		
		// Initializing the display link and directing it to call our displayLinkUpdate: method when an update is available //
		self.displayLink = CADisplayLink(target: self, selector: "displayLinkUpdate:")
		
		// Ensure that the display link is initially not updating //
		self.displayLink.paused = true;
		
		// Scheduling the Display Link to Send Notifications //
		self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
		
		// Initial timestamp //
		self.lastDisplayLinkTimeStamp = self.displayLink.timestamp
		// –––––––––––––––––––––––––––––
	}
	
	
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	
	
	
	@IBAction func startStopButtonPressed(sender: AnyObject) {
		self.displayLink.paused = !(self.displayLink.paused)
		
		var buttonText:String = "Stop"
		if self.displayLink.paused {
			if lastDisplayLinkTimeStamp > 0 {
				buttonText = "Resume"
			}
			else {
				buttonText = "Start"
			}
		}
		
		self.startStopButton.setTitle(buttonText, forState: UIControlState.Normal)
		
	}
	
	@IBAction func saveButtonPressed(sender: AnyObject) {
		
		var taskTitle = TasksData.objectForKey("taskTitle") as? String
		var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
		var sessionsList:NSMutableArray? = userDefaults.objectForKey("sessionsList") as? NSMutableArray
		var dataSet:NSMutableDictionary = NSMutableDictionary()
		let date = NSDate()
		var taskTime = lastDisplayLinkTimeStamp
		
		dataSet.setObject(SessionTitle.text, forKey: "sessionTitle")
		dataSet.setObject(date, forKey: "dateOfSessionCreation")
		dataSet.setObject(taskTitle!, forKey: "taskOfThisSession")
		dataSet.setObject(CategoryContainer, forKey: "categoryOfThisSession")
		dataSet.setObject(taskTime, forKey: "sessionTime")
		
		if ((sessionsList) != nil){	  // data already available
			var newMutableList:NSMutableArray = NSMutableArray()
			for dict:AnyObject in sessionsList!{
				newMutableList.addObject(dict as! NSDictionary)
			}
			userDefaults.removeObjectForKey("sessionsList")
			newMutableList.addObject(dataSet)
			userDefaults.setObject(newMutableList, forKey: "sessionsList")
		}
		else{			   // this is the first todo item in the list
			userDefaults.removeObjectForKey("sessionsList")
			sessionsList = NSMutableArray()
			sessionsList!.addObject(dataSet)
			userDefaults.setObject(sessionsList, forKey: "sessionsList")
		}
		
		SessionTitle.text = "";	    // clear text field to show that the session is saved
		//––––– CHRONO –––––
		self.displayLink.paused = true
		self.numericDisplay.text = "0,00"
		self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
		
		self.lastDisplayLinkTimeStamp = CFTimeInterval()
		//–––––––––––––––––––
		
		userDefaults.synchronize()
		viewDidAppear(true)
	}
	
	func displayLinkUpdate(sender: CADisplayLink) {
		self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration
		
		// Format the running tally to display on the last two significant digits //
		let formattedString:String = String(format: "%0.2f", self.lastDisplayLinkTimeStamp)
		
		// Display the formatted running tally //
		self.numericDisplay.text = formattedString;
	}
	
	
	
	
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		var nb = sessionsList.count
		numberOfEvents.text = String(nb) + " events"
		
		return nb
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("sessionCell", forIndexPath: indexPath) as! customSessionsViewCell
		
		var sessionHere:NSDictionary = sessionsList.objectAtIndex(indexPath.row) as! NSDictionary
		
		cell.configureCellWith(sessionHere)
		
		return cell
	}
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return NO if you do not want the specified item to be editable.
		return true
	}
	
	
	
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
			var sessionsListFromUserDefaults:NSMutableArray = userDefaults.objectForKey("sessionsList") as! NSMutableArray
			var sessionsListReversed:NSMutableArray =  NSMutableArray(array: sessionsList.reverseObjectEnumerator().allObjects).mutableCopy() as! NSMutableArray
			var objectToDelete=sessionsListReversed.objectAtIndex(indexPath.row) as! NSDictionary
			
			// –––––––––––– DELETE TASK IN USER DEFAULTS ––––––––––––––––––
			for session in  sessionsListFromUserDefaults{
				var sessionRecordedDate = session.objectForKey("dateOfSessionCreation") as! NSDate
				var sessionToDeleteDate = objectToDelete.objectForKey("dateOfSessionCreation") as! NSDate
				
				if (sessionRecordedDate == sessionToDeleteDate){
					// will not be added in the new list that replace the old one
					sessionsListFromUserDefaults.removeObject(session)
				}
				else{
				}
			}
			
			userDefaults.removeObjectForKey("sessionsList")
			userDefaults.setObject(sessionsListFromUserDefaults, forKey: "sessionsList")
			userDefaults.synchronize()
			
			sessionsList.removeObjectAtIndex(indexPath.row)
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
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	}
	*/
	
}
