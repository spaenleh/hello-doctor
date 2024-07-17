import Fluent

struct AddCompletedProperty: AsyncMigration {
  func prepare(on database: any FluentKit.Database) async throws {
    try await database.schema("todos").field("completed", .bool, .required, .sql(.default(false)))
      .update()
  }

  func revert(on database: any FluentKit.Database) async throws {
    try await database.schema("todos").deleteField("completed").update()
  }

}
