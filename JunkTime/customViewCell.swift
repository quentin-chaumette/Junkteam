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


	
	func configureCellWith(categoriesItem:NSDictionary, totalTime:Int){
		
		customCategoryTitle.text = categoriesItem.objectForKey("categoryTitle") as? String
		
		customCategoryDate.text = TimeFormatter.dateformatterDate(categoriesItem.objectForKey("dateOfCatCreation") as! NSDate) as String

		var totalTime = TimeFormatter.cleanTimeFormat(totalTime)
		

		//customCategoryTime.text = categoriesItem.objectForKey("categoryTitle") as? String
		customCategoryTime.text = totalTime

	}
	
}