//
//  AlbumListView.swift
//  Itunes
//
//  Created by Aristide LAUGA on 21/06/2023.
//

import SwiftUI

struct AlbumListView: View {
  
  @StateObject var viewModel = AlbumListViewModel()
  
  var body: some View {
    NavigationView {
      List(viewModel.albums) { album in
        Text(album.collectionName)
      }
      .listStyle(.plain)
      .searchable(text: $viewModel.searchTerm)
      .navigationTitle("Search Albums")
    }
    .onAppear {
      viewModel.fetchAlbums(for: viewModel.searchTerm)
    }
  }
}

struct AlbumListView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumListView()
  }
}
