//
//  ContentView.swift
//  Itunes
//
//  Created by Aristide LAUGA on 30/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
          Text("Search") 
          AlbumListView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
