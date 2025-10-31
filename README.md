# ApolloExtensions
Helpful extensions to the [apollo-ios](https://github.com/apollographql/apollo-ios) package.

[![Build and Test](https://github.com/bdbergeron/apollo-ios-extensions/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/bdbergeron/apollo-ios-extensions/actions/workflows/build-and-test.yml)
[![codecov](https://codecov.io/gh/bdbergeron/apollo-ios-extensions/graph/badge.svg?token=e6ZQ0eQaJk)](https://codecov.io/gh/bdbergeron/apollo-ios-extensions)
[![CodeFactor](https://www.codefactor.io/repository/github/bdbergeron/apollo-ios-extensions/badge)](https://www.codefactor.io/repository/github/bdbergeron/apollo-ios-extensions)


## Features

### MockApolloClient
Want to test your app's code around `ApolloClient`? Look no further than `MockApolloClient`! This mock object conforms to `ApolloClientProtocol` and allows you to stub responses to queries, mutations, and subscriptions.

```swift
@Test
func fetchAllFriends() throws {
  let mockedResponseData = GetAllFriendsQuery.Data(friends: .init(edges: [.init(node: .init(id: "1", name: "Brad"))]))
  let apolloClient = MockApolloClient()
  await apolloClient.registerResult(
    .success(.init(
      data: mockedResponseData,
      extensions: nil,
      errors: nil,
      source: .server,
      dependentKeys: nil
    )),
    for: GetAllFriendsQuery.self
  )
  let friendsService = FriendsService(apolloClient: apolloClient)
  let friends = try await friendsService.fetchAllFriends() // Internally performs the fetch operation on it's apolloClient with GetAllFriendsQuery
  let data = try #require(response.data)
  #expect(data.people.edges.count == 1)
  #expect(data.people.edges[0].node.fragments.person.id == "1")
  #expect(data.people.edges[0].node.fragments.person.name == "Brad")
}
```

### Testing / Mocking GraphQL Operations
Want to validate your generated GraphQL operations and data models against stable JSON data that you control? `mockedJSONResponse` is your answer.

Mock your response, like `people.json` in your app bundle:
```json
{
  "data": {
    "people": {
      "__typename": "PersonCollection",
      "edges": [
        {
          "__typename": "PersonCollectionEdge",
          "node": {
            "__typename": "Item",
            "id": "1",
            "name": "Brad"
          }
        }
      ]
    }
  }
}
```

And use that mock response in your tests:
```swift
@Test
func mockedPeopleQueryResponse() async throws {
  let mockURL = try #require(Bundle.module.url(forResource: "people", withExtension: "json"))
  let query = PeopleQuery()
  let response = try await query.mockedJSONResponse(url: mockURL)
  let data = try #require(response.data)

  let person = Person(id: "1", name: "Bradley", nickname: "Brad", age: 36)
  #expect(data.people.edges[0].node.fragments.person == person)
}
```