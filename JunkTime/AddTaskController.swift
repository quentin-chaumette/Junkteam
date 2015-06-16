//
//  AddTaskController.swift
//  JunkTime
//
//  Created by Quentin CHAUMETTE on 09/06/2015.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class AddTaskController: UIViewController {
	
	@IBOutlet var taskTitle: UITextField! = UITextField()
	
	var CategoryContainer:String = String()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		var btn = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "backBtnClicked")
		self.navigationController?.navigationBar.topItem?.backBarButtonItem=btn
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	
	@IBAction func AddTaskButton(sender: AnyObject) {	
		var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
		var tasksList:NSMutableArray? = userDefaults.objectForKey("tasksList") as? NSMutableArray
		var dataSet:NSMutableDictionary = NSMutableDictionary()
		let date = NSDate()
		var taskTime = "00:00:00"
		
		dataSet.setObject(taskTitle.text, forKey: "taskTitle")
		dataSet.setObject(date, forKey: "dateOfTaskCreation")
		dataSet.setObject(CategoryContainer, forKey: "categoryOfThisTask")
		dataSet.setObject(taskTime, forKey: "taskTime")
		
				
		if ((tasksList) != nil){	  // data already available
			var newMutableList:NSMutableArray = NSMutableArray()
			for dict:AnyObject in tasksList!{
				newMutableList.addObject(dict as! NSDictionary)
			}
			userDefaults.removeObjectForKey("tasksList")
			newMutableList.addObject(dataSet)
			userDefaults.setObject(newMutableList, forKey: "tasksList")
		}
		else{			   // this is the first todo item in the list
			
			userDefaults.removeObjectForKey("tasksList")
			tasksList = NSMutableArray()
			tasksList!.addObject(dataSet)
			userDefaults.setObject(tasksList, forKey: "tasksList")			
		}
		
		userDefaults.synchronize()
		
		//self.navigationController!.popToViewController(WorkTaskViewController(), animated: true)
		self.navigationController!.popViewControllerAnimated(true)
		
	}
	
	
	
	
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}