//
//  CreateReport.swift
//  Jirassic
//
//  Created by Baluta Cristian on 28/03/15.
//  Copyright (c) 2015 Cristian Baluta. All rights reserved.
//

import Foundation

let kEightHoursInSeconds: Double = 28800.0

class CreateReport: NSObject {

	var tasks = [Task]()
	
	convenience init (tasks: [Task]) {
		self.init()
		self.tasks = tasks
	}
	
	func round() {
		
		guard (tasks.first != nil) else {
			return
		}
		guard tasks.count > 1 else {
			return
		}
		
		// Group tasks with thesame id together
		groupByTaskId()
		
		// Calculate the excess time till 8 hrs
		let totalTime = tasks.last!.endDate.timeIntervalSinceDate(tasks.first!.endDate)
		let lunchDuration = self.lunchDuration
		let workedTime = totalTime - lunchDuration
		let missingTime = kEightHoursInSeconds - workedTime
		let extraTimePerTask = ceil(Double(Int(missingTime) / (tasks.count)))
		var extraTimeToAdd = extraTimePerTask
		RCLog(totalTime)
		RCLog(lunchDuration)
		RCLog(workedTime)
		RCLog(missingTime)
		RCLog(extraTimePerTask)
		
		// Round times and add the extra time
		for i in 0..<tasks.count-1 {
			var task = tasks[i]
			RCLog(task)
			if i > 0 {
				task.endDate = task.endDate.dateByAddingTimeInterval(extraTimeToAdd)
			}
			task.endDate = task.endDate.round()
			extraTimeToAdd += extraTimePerTask
			RCLog(task)
			tasks[i] = task
		}
		// Handle the last task and add the remaining time
		var task = tasks.last!
		task.endDate = tasks.first!.endDate.dateByAddingTimeInterval(kEightHoursInSeconds + self.lunchDuration)
		RCLog(task)
		tasks[tasks.count-1] = task
	}
	
	private func groupByTaskId() {
        var taskNumbers = [String]()
        for task in tasks {
            print(task)
//            taskNumbers.append(task.taskNumber!)
        }
	}
	
	var lunchDuration: NSTimeInterval {
		
		var lastTaskEndDate = tasks.first?.endDate
		for task in tasks {
			if task.taskType == TaskType.Lunch.rawValue {
				return task.endDate.timeIntervalSinceDate(lastTaskEndDate!)
			}
			lastTaskEndDate = task.endDate
		}
		return 0.0
	}
}
