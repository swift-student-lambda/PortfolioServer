//
//  CreateFeature.swift
//  
//
//  Created by Shawn Gee on 5/26/20.
//

import Fluent

struct CreateFeature: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("features")
            .id()
            .field("name", .string, .required)
            .field("media_url", .string, .required)
            .field("description", .string, .required)
            .field("code_snippet", .string)
            .field("project_id", .uuid, .references("projects", "id"))
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("features").delete()
    }
}
