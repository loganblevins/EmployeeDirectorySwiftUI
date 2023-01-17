//
//  ContentView.swift
//  EmployeeDirectory
//
//  Created by Logan Blevins on 1/15/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        if let status = viewModel.status {
            switch status {
            case .error(let error):
                ErrorView(message: error.localizedDescription, content: refreshButton)
            case .success:
                if viewModel.sortedEmployees().isEmpty {
                    emptyView
                } else {
                    populatedView
                }
            }
        } else {
            ProgressView()
        }
    }

    private var emptyView: some View {
        VStack {
            Text(L10n.HomeView.Message.empty)
                .font(.title)

            refreshButton
        }
        .padding()
    }

    private var populatedView: some View {
        List(viewModel.sortedEmployees(), id: \.uuid) { employee in
            RowView(employee: employee)
        }
        .navigationTitle(L10n.HomeView.title)
    }

    private struct ErrorView<Content: View>: View {
        let message: String
        let content: Content

        var body: some View {
            VStack {
                Text(.init(message))
                    .font(.title)

                content
            }
            .padding()
        }
    }

    private var refreshButton: some View {
        Button {
            viewModel.fetch()
        } label: {
            Text(.init(L10n.HomeView.Button.refresh))
                .font(.title3)
        }
        .buttonStyle(.borderedProminent)
    }
}
