import Fluent
import Vapor

struct TodoController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let todos = routes.grouped("todos")

    todos.get(use: self.index)
    todos.post(use: self.create)
    todos.group(":todoID") { todo in
      todo.patch(use: self.patch)
      todo.delete(use: self.delete)
    }
  }

  @Sendable
  func index(req: Request) async throws -> View {
    let todos = try await Todo.query(on: req.db).all().map { $0.toDTO() }
    return try await req.view.render(
      "index",
      HomeTodoContext(
        title: "My Todos", todos: todos))
  }

  @Sendable
  func create(req: Request) async throws -> Response {
    let todo = try req.content.decode(TodoDTO.self).toModel()

    try await todo.save(on: req.db)
    return req.redirect(to: "/todos")
  }

  @Sendable
  func patch(req: Request) async throws -> Response {
    let todo = try req.content.decode(TodoDTO.self).toModel()

    try await todo.save(on: req.db)
    return req.redirect(to: "/todos")
  }

  @Sendable
  func delete(req: Request) async throws -> HTTPStatus {
    guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
      throw Abort(.notFound)
    }

    try await todo.delete(on: req.db)
    return .noContent
  }
}
