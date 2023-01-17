//
//  RowView.swift
//  EmployeeDirectory
//
//  Created by Logan Blevins on 1/13/23.
//

import Foundation
import SwiftUI
import NukeUI

struct RowView: View {

    let employee: Employee

    var body: some View {
        HStack {
            if let imageUrl = employee.photoURLSmall {
                LazyImage(url: URL(string: imageUrl)) { state in
                    if let image = state.image {
                        image
                            .scaledToFit()
                            .frame(width: 50)
                            .clipShape(Circle())
                    } else {
                        ProgressView()
                            .scaledToFit()
                            .frame(width: 50)
                    }
                }

                VStack(alignment: .leading) {
                    Text(employee.fullName)
                        .font(.title)
                        .bold()

                    Text(employee.team)
                        .font(.headline)
                }
                .padding()
            }
        }
        .frame(height: 50)
    }
}

#if DEBUG
struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(employee: anyEmployee())
    }
}
#endif
