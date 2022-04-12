//
//  FlickrService.swift
//  MichealHannan_Procore
//
//  Created by Micheal Hannan on 4/12/22.
//

import Foundation

final class FlickrService {

    // MARK:- Private Helpers
    public static func buildUrl(searchQuery: String) throws -> URL {
        var comps = URLComponents(
            string: "https://api.flickr.com/services/rest"
        )
        comps?.queryItems = [
            URLQueryItem(name: "text", value: searchQuery),
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: "a724969f016f0b8badd7e518a6c48e55"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "safe_search", value: "1"),
            URLQueryItem(name: "extras", value: "url_t"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
        ]

        guard let url = comps?.url else { throw NSError(domain: "Flickr", code: 1, userInfo: nil) }

        return url
    }

}
