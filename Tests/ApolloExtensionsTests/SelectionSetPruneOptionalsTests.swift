// Created by Brad Bergeron on 10/19/23.

import Apollo
import XCTest

@testable import ApolloExtensions

// MARK: - SelectionSetPruneOptionalsTests

final class SelectionSetPruneOptionalsTests: XCTestCase {
  func test_pruneOptionals_withOptional() throws {
    let parsedPerson = try Person(
      data: [
        "__typename": "Person",
        "id": "1",
        "name": "Bradley",
        "nickname": "Brad",
        "age": 34,
      ])
    let personFromGeneratedInitializer = Person(
      id: "1",
      name: "Bradley",
      nickname: "Brad",
      age: 34)
    XCTAssertNotEqual(personFromGeneratedInitializer, parsedPerson)

    let pruned = personFromGeneratedInitializer.pruneOptionals()
    XCTAssertEqual(pruned, parsedPerson)
  }

  func test_pruneOptionals_withNull() throws {
    let parsedPerson = try Person(
      data: [
        "__typename": "Person",
        "id": "1",
        "name": "Bradley",
        "nickname": nil,
        "age": nil,
      ])
    let personFromGeneratedInitializer = Person(
      id: "1",
      name: "Bradley",
      nickname: nil,
      age: nil)

    // All the fields are equal...
    XCTAssertEqual(personFromGeneratedInitializer.__typename, parsedPerson.__typename)
    XCTAssertEqual(personFromGeneratedInitializer.__objectType, parsedPerson.__objectType)
    XCTAssertEqual(personFromGeneratedInitializer.id, parsedPerson.id)
    XCTAssertEqual(personFromGeneratedInitializer.name, parsedPerson.name)
    XCTAssertEqual(personFromGeneratedInitializer.nickname, parsedPerson.nickname)
    XCTAssertEqual(personFromGeneratedInitializer.age, parsedPerson.age)
    XCTAssertEqual(personFromGeneratedInitializer.__typename, parsedPerson.__typename)
    XCTAssertEqual(personFromGeneratedInitializer.__objectType, parsedPerson.__objectType)

    // But the objects themselves are seemingly not.
    XCTAssertNotEqual(personFromGeneratedInitializer, parsedPerson)

    // So what's driving the inequality? The underlying `DataDict`
    XCTAssertNotEqual(personFromGeneratedInitializer.__data, parsedPerson.__data)

    let pruned = personFromGeneratedInitializer.pruneOptionals()

    // And now everything's equal as one would expect
    XCTAssertEqual(pruned, parsedPerson)
  }

  func test_pruneOptionals_nested_withOptional() throws {
    let parsed = try PersonCollection(
      data: [
        "__typename": "PersonCollection",
        "edges": [
          [
            "__typename": "PersonCollectionEdge",
            "node": [
              "__typename": "Person",
              "id": "1",
              "name": "Bradley",
              "nickname": "Brad",
              "age": 34,
            ] as [String: AnyHashable],
          ] as [String: AnyHashable],
          [
            "__typename": "PersonCollectionEdge",
            "node": [
              "__typename": "Person",
              "id": "2",
              "name": "Christopher",
              "nickname": "Chris",
              "age": 32,
            ] as [String: AnyHashable],
          ] as [String: AnyHashable],
        ]
      ])
    let fromGeneratedInitializer = PersonCollection(
      edges: [
        .init(
          node: .init(
            id: "1",
            name: "Bradley",
            nickname: "Brad",
            age: 34)),
        .init(
          node: .init(
            id: "2",
            name: "Christopher",
            nickname: "Chris",
            age: 32)),
      ])

    XCTAssertNotEqual(fromGeneratedInitializer, parsed)

    let pruned = fromGeneratedInitializer.pruneOptionals()
    XCTAssertEqual(pruned, parsed)
  }
}
