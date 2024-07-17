import Fluent
import FluentSQLiteDriver
import Leaf
import NIOSSL
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

  app.databases.use(DatabaseConfigurationFactory.sqlite(.file("db.sqlite")), as: .sqlite)

  app.migrations.add(CreateTodo())
  app.migrations.add(AddCompletedProperty())

  app.views.use(.leaf)

  // register routes
  try routes(app)
}
