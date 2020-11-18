//
//  DetailsView.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 8/13/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    @State private var isShowingSheet = false

    let service: MovieStore

    init(service: MovieStore = MovieStore.shared) {
        self.service = service
    }

    var body: some View {
        ListView()
            .navigationBarTitle("Movie Watchlist")
            .onAppear(perform: loadMovieWatchList)
            .navigationBarItems(trailing: Button(action: {
                self.isShowingSheet.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isShowingSheet) {
                SheetView(isShowingSheet: self.$isShowingSheet)
            }
    }
    
    private func loadMovieWatchList() {
        print("Load watch list")
    }

//    private func loadMovieSearchResults() {
//        service.searchMovie(query: "The Exorcist") { (response) in
//            switch response {
//            case .success(let movieResponse):
//                print(movieResponse)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}

struct SheetView: View {
    @Binding var isShowingSheet: Bool

    var body: some View {
        VStack() {
            MovieSearchView()
            Button(action: {
                self.isShowingSheet = false
            }) { Text("Done") }
        }
    }
}

struct ListView: View {
    var body: some View {
        VStack {
            List() {
                Text("Hello Second View")
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView() {
            DetailsView()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView() {
            ListView()
        }
    }
}
