//
//  MovieSearchView.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 11/3/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

struct MovieSearchView: View {

    @ObservedObject var movieSearchState = MovieSearchState()

    var body: some View {
        NavigationView {

            List {
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
//published properties can have a debounce (look into)
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

class MovieSearchState: ObservableObject {

    @Published var query = ""
    @Published var movies: [Movie]?

    private var cancellable: AnyCancellable?

    let movieService: MovieService

    var isEmptyResults: Bool {
        !self.query.isEmpty && self.movies != nil && self.movies!.isEmpty
    }

    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }

    func startObservation() {
        guard cancellable == nil else { return }

        self.cancellable = self.$query
            .map { [weak self] text in
                self?.movies = nil
                return text
        }.debounce(for: 2.0, scheduler: DispatchQueue.main)
            .sink { [weak self] in self?.search(query: $0)
        }
    }

    func search(query: String) {
        self.movies = nil

        guard !query.isEmpty else {
            return
        }

        self.movieService.searchMovie(query: query) {[weak self] (result) in
            guard let self = self, self.query == query else { return }

            switch result {
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                print(error)
            }
        }
    }

//    deinit {
//        self.cancellable?.cancel()
//        self.cancellable = nil
//    }

}
