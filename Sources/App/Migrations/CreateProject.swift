//
//  CreateProject.swift
//  
//
//  Created by Shawn Gee on 5/26/20.
//

import Fluent

struct CreateProject: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("projects")
            .id()
            .field("name", .string, .required)
            .field("hero_image_url", .string, .required)
            .field("summary", .string, .required)
            .field("role", .string, .required)
            .field("technologies", .array(of: .string), .required)
            .field("app_store_link", .string)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("projects").delete()
    }
}
