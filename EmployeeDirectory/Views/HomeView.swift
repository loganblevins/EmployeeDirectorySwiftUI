//
//  HomeView.swift
//  EmployeeDirectory
//
//  Created by Logan Blevins on 1/13/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            ContentView()
                .environmentObject(viewModel)
        }
        .onAppear {
            viewModel.fetch()
        }
        .refreshable {
            viewModel.fetch()
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(dataStore: MockStore(employees: [anyEmployee(), anyEmployee(), anyEmployee()])))
    }
}
#endif
