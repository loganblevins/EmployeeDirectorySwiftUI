//
//  EmployeeDirectoryApp.swift
//  EmployeeDirectory
//
//  Created by Logan Blevins on 1/13/23.
//

import SwiftUI

@main
struct EmployeeDirectoryApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(dataStore: RemoteStore()))
        }
    }
}
