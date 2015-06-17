//
//  TimeFormatter.swift
//  JunkTime
//
//  Created by Quentin CHAUMETTE on 17/06/2015.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class TimeFormatter: UIView {
	
	class func cleanTimeFormat(theTime:Int)-> String{
		
		var seconds = theTime

		var affichage:String=String()
		
		if (theTime<1){
			affichage = "00:00:00"
		}
		else{
			var days = seconds/60/60/24
			var hours = seconds/60/60
			var minutes = seconds/60
			
			if(minutes<1){
				affichage = "\(seconds)" + "s"
			}
			else{
				if(hours<1){
					seconds = seconds-60*minutes
					affichage = "\(minutes)" + "m " + "\(seconds)"+"s"
				}
				else{
					seconds = seconds-60*minutes
					minutes = minutes-60*hours
					hours = hours-24*days
					if(days<1){
						affichage = "\(hours)" + "h " + "\(minutes)" + "m " + "\(seconds)"+"s"
					}
					else{
						affichage = "\(days)" + "d " + "\(hours)" + "h " + "\(minutes)" + "m " + "\(seconds)"+"s"
					}
				}
			}
		}
		
		return affichage
	}
	
}
