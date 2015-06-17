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
		
//		var seconds = theTime
		var seconds = 63
		var affichage:String=String()
		
		if (theTime<1){
			affichage = "00:00:00";
		}
		else{
			var days = seconds/60/60/24
			var hours = seconds/60/60
			var minutes = seconds/60
			
			if(minutes<1){                      // si pas de minute, affichage en secondes :
				affichage = "" + "\(seconds)" + "s";
			}
			else{
				if(hours<1){		  // si moins d'une heure, min + secondes
					minutes = minutes-60*hours;
					seconds = seconds-60*minutes
					affichage = "" + "\(minutes)" + "h" + "\(seconds)"+"s";
				}
				else{			        // si plus d'une heure, heure + min + secondes
					hours=hours-24*days;
					affichage = "" + "\(days)" + "j";
				}
			}
		}
		
		return affichage
	}
	
}
