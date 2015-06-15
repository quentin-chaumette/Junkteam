//
//  customViewCell.swift
//  JunkTime
//
//  Created by Quentin CHAUMETTE on 14/06/2015.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class customViewCell: UITableViewCell {

	@IBOutlet var customCategoryTitle: UILabel! = UILabel()
	@IBOutlet var customCategoryDate: UILabel! = UILabel()
	@IBOutlet var customCategoryTime: UILabel! = UILabel()

	func dateformatterDate(date: NSDate) -> NSString{
		var dateFormatter: NSDateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
		dateFormatter.timeZone = NSTimeZone.localTimeZone()
		return dateFormatter.stringFromDate(date)
	}
	
	func configureCellWith(categoriesItem:NSDictionary){
		
		customCategoryTitle.text = categoriesItem.objectForKey("categoryTitle") as? String
		
		customCategoryDate.text = dateformatterDate(categoriesItem.objectForKey("dateOfCatCreation") as! NSDate) as String
		
		//customCategoryTime.text = categoriesItem.objectForKey("categoryTitle") as? String
		customCategoryTime.text = categoriesItem.objectForKey("categoryTime") as? String

	}
	
}