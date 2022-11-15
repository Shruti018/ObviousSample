//
//  GalleryModel.swift
//  OGallery
//
//  Created by Shruti on 14/11/22.
//


import Foundation

// MARK: - GalleryModel
struct GalleryModel: Codable
{
    let date: String
    let explanation: String
    let media_type: String
    let title: String
    let hdurl: String
    let url: String
    let service_version: String
//    let copyright: String

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case explanation = "explanation"
        case media_type = "media_type"
        case title = "title"
        case hdurl = "hdurl"
        case url = "url"
        case service_version = "service_version"
//        case copyright = "copyright"
    }
}
