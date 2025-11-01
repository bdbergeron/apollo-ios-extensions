// Created by Brad Bergeron on 10/31/25.

import Apollo
import Foundation
import Testing

@testable import ApolloExtensions

// MARK: - ApolloTestHelpersTests

@Suite
struct ApolloTestHelpersTests {

  @Test
  func mockedJSONResponse_failsWithError() async throws {
    let mockURL = try #require(Bundle.module.url(forResource: "invalid_json", withExtension: "json"))
    let query = TestQuery()
    do {
      _ = try await query.mockedJSONResponse(url: mockURL)
      Issue.record("Should fail.")
    } catch {
      #expect((error as NSError).domain == NSCocoaErrorDomain)
      #expect((error as NSError).code == 3840)
    }
  }

  @Test
  func mockedJSONResponse_succeeds() async throws {
    let mockURL = try #require(Bundle.module.url(forResource: "people", withExtension: "json"))
    let query = TestQuery()
    let response = try await query.mockedJSONResponse(url: mockURL)
    let data = try #require(response.data)
    #expect(data.people.edges.count == 2)
    #expect(data.people.edges[0].node.__typename == "Person")
    #expect(data.people.edges[0].node.id == "1")
    #expect(data.people.edges[0].node.name == "Bradley")
    #expect(data.people.edges[0].node.nickname == "Brad")
    #expect(data.people.edges[0].node.age == 34)
    #expect(data.people.edges[1].node.__typename == "Person")
    #expect(data.people.edges[1].node.id == "2")
    #expect(data.people.edges[1].node.name == "Noah")
    #expect(data.people.edges[1].node.nickname == nil)
    #expect(data.people.edges[1].node.age == nil)

    let person1 = Person(id: "1", name: "Bradley", nickname: "Brad", age: 34)
    #expect(data.people.edges[0].node.fragments.person == person1)

    let person2 = Person(id: "2", name: "Noah", nickname: nil, age: nil)
    #expect(data.people.edges[1].node.fragments.person == person2)

    let people = PersonCollection(edges: [
      .init(node: .init(id: "1", name: "Bradley", nickname: "Brad", age: 34)),
      .init(node: .init(id: "2", name: "Noah", nickname: nil, age: nil)),
    ])
    #expect(data.people.fragments.personCollection == people)
  }

  @Test
  func dataDict_debugDescription() {
    let dataDict = Person(id: "1", name: "Brad").__data
    let expected: [(key: String, value: any Hashable)] = [
      (key: "__typename", value: "Person"),
      (key: "age", value: Optional<Int>.none),
      (key: "id", value: "1"),
      (key: "name", value: "Brad"),
      (key: "nickname", value: Optional<String>.none),
    ]
    #expect(dataDict.description == expected.description)
  }

}
