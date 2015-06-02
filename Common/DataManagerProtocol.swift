//
//  DataManagerProtocol.swift
//  Jira-Logger
//
//  Created by Baluta Cristian on 01/05/15.
//  Copyright (c) 2015 Cristian Baluta. All rights reserved.
//

import Foundation

@objc protocol DataManagerProtocol: NSObjectProtocol {
	
	func queryData(completion: ([Task], NSError?) -> Void)
	func days() -> [Task]
	func tasksForDayOnDate(date: NSDate) -> [Task]
	func addNewTask(dateSart: NSDate?, dateEnd: NSDate?) -> Task
	func addNewWorkingDayTask(dateSart: NSDate?, dateEnd: NSDate?) -> Task
	func addScrumSessionTask(dateSart: NSDate?, dateEnd: NSDate?) -> Task
	func addLunchBreakTask(dateSart: NSDate?, dateEnd: NSDate?) -> Task
	func addInternalMeetingTask(dateSart: NSDate?, dateEnd: NSDate?) -> Task
//	func updateTask(task_id: String, notes: String)
}
