//
//  LocalPreferences.swift
//  Jirassic
//
//  Created by Cristian Baluta on 23/04/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import Foundation

enum LocalPreferences: String, RCPreferencesProtocol {
    
    case launchAtStartup = "launchAtStartup"
    case usePercents = "usePercents"
    case useDuration = "useDuration"
    case firstLaunch = "firstLaunch"
    case wizardStep = "wizardStep"
    case settingsActiveTab = "settingsActiveTab"
    case settingsJiraUrl = "settingsJiraUrl"
    case settingsJiraUser = "settingsJiraUser"
    case settingsJiraProjectId = "settingsJiraProjectId"
    case settingsJiraProjectKey = "settingsJiraProjectKey"
    case settingsJiraProjectIssueKey = "settingsJiraProjectIssueKey"
    case settingsHookupCmdName = "settingsHookupCmdName"
    case settingsHookupAppName = "settingsHookupAppName"
    case settingsGitPaths = "settingsGitPaths"
    case settingsGitAuthors = "settingsGitAuthors"
    case enableGit = "enableGit"
    case enableJira = "enableJira"
    case enableRoundingDay = "enableRoundingDay"
    case enableHookup = "enableHookup"
    case enableCocoaHookup = "enableCocoaHookup"
    case enableHookupCredentials = "enableHookupCredentials"
    
    func defaultValue() -> Any {
        switch self {
        case .launchAtStartup:          return false
        case .usePercents:              return true
        case .useDuration:              return false
        case .firstLaunch:              return true
        case .wizardStep:               return WizardStep.shell.rawValue
        case .settingsActiveTab:        return SettingsTab.tracking.rawValue
        case .settingsJiraUrl:          return ""
        case .settingsJiraUser:         return ""
        case .settingsJiraProjectId:    return ""
        case .settingsJiraProjectKey:   return ""
        case .settingsJiraProjectIssueKey:return ""
        case .settingsHookupCmdName:    return ""
        case .settingsHookupAppName:    return ""
        case .settingsGitPaths:         return ""
        case .settingsGitAuthors:       return ""
        case .enableGit:                return false
        case .enableJira:               return true
        case .enableRoundingDay:        return false
        case .enableHookup:             return false
        case .enableCocoaHookup:        return false
        case .enableHookupCredentials:  return false
        }
    }
}
