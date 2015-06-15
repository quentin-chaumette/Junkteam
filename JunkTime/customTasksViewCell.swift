//
//  customTasksViewCell.swift
//  JunkTime
//
//  Created by Quentin CHAUMETTE on 14/06/2015.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class customTasksViewCell: UITableViewCell {
	
	@IBOutlet var customTaskTitle: UILabel! = UILabel()
	@IBOutlet var customTaskDate: UILabel! = UILabel()
	@IBOutlet var customTaskTime: UILabel! = UILabel()
	
	func dateformatterDate(date: NSDate) -> NSString{
		var dateFormatter: NSDateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
		dateFormatter.timeZone = NSTimeZone.localTimeZone()
		return dateFormatter.stringFromDate(date)
	}
	
	func configureCellWith(taskItem:NSDictionary){
		
		customTaskTitle.text = taskItem.objectForKey("taskTitle") as? String
		
		customTaskDate.text = dateformatterDate(taskItem.objectForKey("dateOfTaskCreation") as! NSDate) as String
		
		//customCategoryTime.text = taskItem.objectForKey("taskTime") as? String
		
		customTaskTime.text = "00:00:00"
		
	}
	
}
