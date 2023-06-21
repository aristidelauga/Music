//
//  AlbumListViewModel.swift
//  Itunes
//
//  Created by Aristide LAUGA on 30/05/2023.
//

import Combine
import Foundation


// https://itunes.apple.com/search?term=jack+johnson
// https://itunes.apple.com/search?term=michael+jackson&entity=album&limit=5
// https://itunes.apple.com/search?term=michael+jackson&entity=song&limit=5
// https://itunes.apple.com/search?term=Dhanush&entity=movie&limit=5
// https://itunes.apple.com/search?term=jim+jones&country=ca

class AlbumListViewModel: ObservableObject {
  
  @Published var searchTerm: String = ""
  @Published var albums: [Album] = []
  
  let limit: Int = 20
  
  var subscriptions = Set<AnyCancellable>()
  
  init() {
    $searchTerm
      .dropFirst()
      .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
      .sink { [weak self] term in
      self?.fetchAlbums(for: term)
    }.store(in: &subscriptions)
  }
  
  
  func fetchAlbums(for searchTerm: String) {
    guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)") else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("Error \(error)")
      } else if let data = data {
        do {
          let result = try JSONDecoder().decode(AlbumResult.self, from: data)
          DispatchQueue.main.async {
            self.albums = result.results
          }
        } catch {
          print("Decoding error \(error.localizedDescription)")
        }
      }
    }.resume()
  }
  
}
