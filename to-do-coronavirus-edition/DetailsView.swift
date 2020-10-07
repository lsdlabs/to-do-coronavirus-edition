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

  var body: some View {
    ListView()
      .navigationBarTitle("Movie Watchlist")
      .navigationBarItems(trailing: Button(action: {
        self.isShowingSheet.toggle()
      }) {
        Image(systemName: "plus")
      })
      .sheet(isPresented: $isShowingSheet) {
        VStack() {
          Text("Hello Sheet")
          Button(action: {
            self.isShowingSheet = false
          }) { Text("Done")}
        }
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
