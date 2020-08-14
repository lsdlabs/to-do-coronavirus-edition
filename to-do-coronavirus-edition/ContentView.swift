//
//  ContentView.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 8/12/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    print("My Watchlist Button tapped")
                    NavigationLink("DetailsView", destination: DetailsView())
                }) {
                    Image("My Watchlist Button")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
