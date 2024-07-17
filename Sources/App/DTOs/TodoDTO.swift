import Fluent
import Vapor

struct TodoDTO: Content {
  var id: UUID?
  var title: String?
  var completed: Bool?

  func toModel() -> Todo {
    let model = Todo()

    model.id = self.id
    if let title = self.title {
      model.title = title
    }
    model.completed = self.completed ?? false
    return model
  }
}
