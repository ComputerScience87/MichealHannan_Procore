//
//  ViewController.swift
//  MichealHannan_Procore
//
//  Created by Micheal Hannan on 4/8/22.
//

import UIKit

class FlickrViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    private let flickrImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        submitSearch(text: searchBar.text)
    }
    
    private func submitSearch(text: String?) {
        guard let searchKeyword = text else { return }
        print("HERE!!")
        do {
            let result = try FlickrService.buildUrl(searchQuery: searchKeyword)
            let session = URLSession(configuration: .default)
            
            let urlRequest = URLRequest(url: result)
            
            session.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else { return }
                
                let json = try? JSONSerialization.jsonObject(with: data) as? [String: AnyHashable]
                
                guard let photos = json?["photos"] as? [String : Any],
                      let photo = photos["photo"] as? [String: Any] else { return }
                
                
                //let image = FlickrImage(id: photo["id"] as? String, title: photo["title"] as? String, url: photo["url_t"] as? String, height: photo["height_t"] as? Double, width: photo["width_t"] as? Double)
                
            }.resume()
        } catch {
            assertionFailure("Could not search FlickrService")
        }
    }
}

extension FlickrViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        flickrImages.count
    }
}

struct FlickrImage {
    let id: String
    let title: String
    let url: String
    let height: Double
    let width: Double
}
