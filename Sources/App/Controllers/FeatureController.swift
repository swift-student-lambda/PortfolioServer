//
//  FeatureController.swift
//
//
//  Created by Shawn Gee on 5/26/20.
//

import Fluent
import Vapor

struct FeatureController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let features = routes.grouped("features")
        features.post(use: create)
        features.group(":id") { feature in
            feature.delete(use: delete)
        }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Feature> {
        let feature = try req.content.decode(Feature.self)
        return feature.save(on: req.db).map { feature }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Feature.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
