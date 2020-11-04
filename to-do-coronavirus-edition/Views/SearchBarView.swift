//
//  SearchBarView.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 11/3/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//


/*
Unfortunately,SwiftUI does not offer a SearchBar View yet, so I have to rely a bit more on UIKit, particularly UISearchBar.

resource: https://axelhodler.medium.com/creating-a-search-bar-for-swiftui-e216fe8c8c7f
 */
import SwiftUI

struct SearchBarView: UIViewRepresentable {

    let placeholder: String
    @Binding var text: String

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: self.$text)
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
