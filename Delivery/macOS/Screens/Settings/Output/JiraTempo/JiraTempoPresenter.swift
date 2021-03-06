//
//  JiraTempoPresenter.swift
//  Jirassic
//
//  Created by Cristian Baluta on 01/02/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import Foundation

protocol JiraTempoPresenterInput: class {
    
    func setupUserInterface()
    func checkCredentials()
    func loadProjects()
    func loadProjectIssues (for projectKey: String)
    func save (url: String, user: String, password: String)
}

protocol JiraTempoPresenterOutput: class {
    
    func enableProgressIndicator (_ enabled: Bool)
    func showProjects (_ projects: [String], selectedProject: String)
    func showProjectIssues (_ issues: [String], selectedIssue: String)
    func showErrorMessage (_ message: String)
}

class JiraTempoPresenter {
    
    weak var userInterface: JiraTempoPresenterOutput?
    fileprivate var moduleJira = ModuleJiraTempo()
    fileprivate let localPreferences = RCPreferences<LocalPreferences>()
    fileprivate var existingPassword = ""
}

extension JiraTempoPresenter: JiraTempoPresenterInput {
    
    func checkCredentials() {
        loadProjects()
    }
    
    func setupUserInterface() {
        
        userInterface!.showErrorMessage("")
        existingPassword = Keychain.getPassword()
        
        let selectedProjectName = localPreferences.string(.settingsJiraProjectKey)
        let projects = selectedProjectName != "" ? [selectedProjectName] : []
        userInterface!.showProjects(projects, selectedProject: selectedProjectName)
        
        let selectedProjectIssueName = localPreferences.string(.settingsJiraProjectIssueKey)
        let issues = selectedProjectIssueName != "" ? [selectedProjectIssueName] : []
        userInterface!.showProjectIssues(issues, selectedIssue: selectedProjectIssueName)
    }
    
    func loadProjects() {
        
        userInterface!.enableProgressIndicator(true)
        userInterface!.showErrorMessage("")
        
        moduleJira.fetchProjects { [weak self] (projects) in
            
            DispatchQueue.main.async {
                
                guard let wself = self, let userInterface = wself.userInterface else {
                    return
                }
                userInterface.enableProgressIndicator(false)
                
                guard let projects = projects else {
                    userInterface.showErrorMessage("Error: Wrong credentials or server not reachable.")
                    return
                }
                let titles = projects.map { $0.key }
                let selectedProjectKey = wself.localPreferences.string(.settingsJiraProjectKey)
                
                userInterface.showProjects(titles, selectedProject: selectedProjectKey)
                if projects.count > 0 && selectedProjectKey != "" {
                    wself.loadProjectIssues(for: selectedProjectKey)
                }
            }
        }
    }
    
    func loadProjectIssues (for projectKey: String) {
        
        userInterface!.enableProgressIndicator(true)
        userInterface!.showErrorMessage("")
        
        moduleJira.fetchProjectIssues (projectKey: projectKey) { [weak self] (issues) in
            
            DispatchQueue.main.async {
                
                guard let wself = self, let userInterface = wself.userInterface else {
                    return
                }
                userInterface.enableProgressIndicator(false)
                
                guard let issues = issues else {
                    userInterface.showErrorMessage("Error: Server not reachable.")
                    return
                }
                let titles = issues.map { $0.key }
                
                userInterface.showProjectIssues(titles, selectedIssue: wself.localPreferences.string(.settingsJiraProjectIssueKey))
            }
        }
    }
    
    func save (url: String, user: String, password: String) {
        
        localPreferences.set(url, forKey: .settingsJiraUrl)
        localPreferences.set(user, forKey: .settingsJiraUser)
        if password != existingPassword {
            Keychain.setPassword(password)
            existingPassword = password
        }
    }
}
