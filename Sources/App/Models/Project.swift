//
//  Project.swift
//  
//
//  Created by Shawn Gee on 5/26/20.
//

import Fluent
import Vapor

final class Project: Model, Content {
    static let schema = "projects"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "hero_image_url") var heroImageURL: String
    @Field(key: "summary") var summary: String
    @Field(key: "role") var role: String
    @Field(key: "technologies") var technologies: [String]
    @Field(key: "app_store_link") var appStoreLink: String?
    @Children(for: \.$project) var features: [Feature]
    
    init() {}
}
