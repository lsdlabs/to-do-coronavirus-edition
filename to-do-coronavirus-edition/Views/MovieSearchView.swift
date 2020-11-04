//
//  MovieSearchView.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 11/3/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//

import SwiftUI

struct MovieSearchView: View {

    @ObservedObject var movieSearchState = MovieSearchState()

    var body: some View {
        NavigationView {

            List {
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))

            }
            .onAppear {
                //to-do: observation
            }
            .navigationBarTitle("Search")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}

import SwiftUI
import Combine
import Foundation

class MovieSearchState: ObservableObject {

    @Published var query = ""

}
