//
//  AddCategoryController.swift
//  JunkTime
//
//  Created by Quentin CHAUMETTE on 09/06/2015.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class AddCategoryController: UIViewController {
	
	@IBOutlet weak var titleTextField: UITextField! = UITextField()

	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func addButtonTapped(sender: AnyObject) {
		var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
		var categoryList:NSMutableArray? = userDefaults.objectForKey("categoryList") as? NSMutableArray
		var dataSet:NSMutableDictionary = NSMutableDictionary()
		let date = NSDate()
		var categoryTime = "00:00:00"
		
		dataSet.setObject(titleTextField.text, forKey: "categoryTitle")
		dataSet.setObject(date, forKey: "dateOfCatCreation")
		dataSet.setObject(categoryTime, forKey: "categoryTime")

		if ((categoryList) != nil){	  // data already available
			var newMutableList:NSMutableArray = NSMutableArray()
			for dict:AnyObject in categoryList!{
				newMutableList.addObject(dict as! NSDictionary)
			}
			userDefaults.removeObjectForKey("categoryList")
			newMutableList.addObject(dataSet)
			userDefaults.setObject(newMutableList, forKey: "categoryList")
			
		}
		else{			   // this is the first todo item in the list
			userDefaults.removeObjectForKey("categoryList")
			categoryList = NSMutableArray()
			categoryList!.addObject(dataSet)
			userDefaults.setObject(categoryList, forKey: "categoryList")
			
		}
		
		userDefaults.synchronize()
		
		self.navigationController!.popToRootViewControllerAnimated(true)
		
		
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
