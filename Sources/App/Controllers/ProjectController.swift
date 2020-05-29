//
//  ProjectController.swift
//
//
//  Created by Shawn Gee on 5/26/20.
//

import Fluent
import Vapor

struct ProjectController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let projects = routes.grouped("projects")
        projects.get(use: index)
        projects.post(use: create)
        projects.group(":id") { project in
            project.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Project]> {
        Project.query(on: req.db).with(\.$features).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Project> {
        let project = try req.content.decode(Project.self)
        return project.save(on: req.db).map { project }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Project.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
