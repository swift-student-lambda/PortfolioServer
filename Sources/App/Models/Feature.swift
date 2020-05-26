//
//  Feature.swift
//  
//
//  Created by Shawn Gee on 5/26/20.
//

import Fluent
import Vapor

final class Feature: Model, Content {
    static let schema = "features"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "media_url") var mediaURL: String
    @Field(key: "description") var description: String
    @Field(key: "code_snippet") var codeSnippet: String
    @Parent(key: "project_id") var project: Project
    
    init() {}
}
