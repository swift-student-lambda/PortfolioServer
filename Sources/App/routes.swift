import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { _ in
        "It works!"
    }

    try app.register(collection: ProjectController())
    try app.register(collection: FeatureController())
}
