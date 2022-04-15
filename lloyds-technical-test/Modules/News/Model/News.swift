//
//  News.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import Foundation

struct News: Decodable {
    var uuid: String
    var title: String
    var description: String
    var keywords: String
    var snippet: String
    var url: String
    var imageUrl: String
    var language: String
    var publishedAt: String
    var source: String
    
    private enum CodingKeys: String, CodingKey {
        case uuid, title, description, keywords, snippet, url, language, source
        case imageUrl = "image_url"
        case publishedAt = "published_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        uuid = try container.decode(String.self, forKey: .uuid)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        keywords = try container.decode(String.self, forKey: .keywords)
        snippet = try container.decode(String.self, forKey: .snippet)
        url = try container.decode(String.self, forKey: .url)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        language = try container.decode(String.self, forKey: .language)
        publishedAt = try container.decode(String.self, forKey: .publishedAt)
        source = try container.decode(String.self, forKey: .source)
    }
}
