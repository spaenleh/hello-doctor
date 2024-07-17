import Fluent
import Vapor

struct HomeTodoContext: Encodable {
  var title: String
  var todos: [TodoDTO]
}

func routes(_ app: Application) throws {

  try app.register(collection: TodoController())
}
