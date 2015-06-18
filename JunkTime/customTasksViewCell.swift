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
	

	
	func configureCellWith(taskItem:NSDictionary, taskTotalTime:Int){
		
		customTaskTitle.text = taskItem.objectForKey("taskTitle") as? String
		
		customTaskDate.text = TimeFormatter.dateformatterDateAndHour(taskItem.objectForKey("dateOfTaskCreation") as! NSDate) as String
		
		customTaskTime.text = TimeFormatter.cleanTimeFormat(taskTotalTime)
		
	}
	
}
