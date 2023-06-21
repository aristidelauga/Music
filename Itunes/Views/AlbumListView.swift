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
      List {
        ForEach(viewModel.albums) { album in
          Text(album.collectionName)
        }
        
        switch viewModel.state {
          case .good:
            Color.clear
              .onAppear {
                viewModel.loadMore()
              }
          case .isLoading:
            ProgressView().progressViewStyle(.circular)
          case .loadedAll:
            Color.gray
          case .error(let message):
            Text(message)
              .foregroundStyle(.red)
        }
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
