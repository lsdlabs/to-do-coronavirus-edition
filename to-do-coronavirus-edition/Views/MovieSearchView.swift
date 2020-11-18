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
                    
                ForEach(self.movieSearchState.movies, id: \.self) { movie in
                    Text(movie.title)
                }
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

final class MovieSearchState: ObservableObject {

    @Published var query = ""
    @Published var movies: [Movie] = []

    private var cancellable: AnyCancellable?
    
    var isEmptyResults: Bool { self.movies.isEmpty }

    let movieService: MovieService

    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
        
        startObservation()
    }

    func startObservation() {
        cancellable = AnyCancellable(
            self.$query
                .debounce(for: 2.0, scheduler: DispatchQueue.main)
                .sink { movieName in
                    print("searchText: \(movieName)")
                    self.searchMoviesBy(name: movieName)
                }
        )
    }

    func searchMoviesBy(name: String) {
        
        // TODO: maybe have the 'clear' button set 'movies' to empty
        // instead so there wont be a two second delay
        guard !name.isEmpty else {
            self.movies = []
            return
        }
        
        movieService.searchMovie(query: name) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.movies = response.results
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
