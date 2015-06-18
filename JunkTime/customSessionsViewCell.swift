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
	

	
	func configureCellWith(sessionHere:NSDictionary){
		
		customSessionTitle.text = sessionHere.objectForKey("sessionTitle") as? String
		
		customSessionDate.text = TimeFormatter.dateformatterDateAndHour(sessionHere.objectForKey("dateOfSessionCreation") as! NSDate) as String

		var sessionTime = sessionHere.objectForKey("sessionTime") as! CFTimeInterval
		
		var totalTime = TimeFormatter.cleanTimeFormat(Int(sessionTime))
		
		customSessionTime.text = totalTime
		
	}
}
