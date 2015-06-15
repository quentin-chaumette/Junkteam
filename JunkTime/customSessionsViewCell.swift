//
//  customSessionsViewCell.swift
//  JunkTime
//
//  Created by Quentin CHAUMETTE on 15/06/2015.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class customSessionsViewCell: UITableViewCell {

	@IBOutlet var customSessionTitle: UILabel! = UILabel()
	@IBOutlet var customSessionDate: UILabel! = UILabel()
	@IBOutlet var customSessionTime: UILabel! = UILabel()
	
	func dateformatterDate(date: NSDate) -> NSString{
		var dateFormatter: NSDateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
		dateFormatter.timeZone = NSTimeZone.localTimeZone()
		return dateFormatter.stringFromDate(date)
	}
	
	func configureCellWith(sessionHere:NSDictionary){
		
		customSessionTitle.text = sessionHere.objectForKey("sessionTitle") as? String
		
		customSessionDate.text = dateformatterDate(sessionHere.objectForKey("dateOfSessionCreation") as! NSDate) as String

		var sessionTime = sessionHere.objectForKey("sessionTime") as! CFTimeInterval
		customSessionTime.text = String(format:"%.1f", sessionTime)
		
		
	}
}
