# apollo-ios-extensions
Helpful extensions to the [apollo-ios](https://github.com/apollographql/apollo-ios) package.

## Features

### ApolloClientProtocol Default Values
It's wonderful we're provided with `ApolloClientProtocol`, which `ApolloClient` conforms to.
However, the `ApolloClient` implementation provides default parameter values that `ApolloClientProtocol`
doesn't provide. Consider this a non-issue now!

### MockApolloClient
Want to test your app's code around `ApolloClient`? Look no further than `MockApolloClient`!
This mock object conforms to `AppoloClientProtocol` and allows you to stub responses to queries,
mutations, and subscriptions.

```swift
func test_query() throws {
  let apolloClient = MockApolloClient()
  apolloClient.fetchResult = { parameters in
    let data = TestQuery.Data(items: .init(edges: [
      .init(node: .init(id: "1",name: "Brad")),
    ]))
    return .success(GraphQLResult(data: data))
  }

  let expectation = expectation(description: #function)
  apolloClient.fetch(query: TestQuery()) { result in
    expectation.fulfill()
    switch result {
    case .success(let result):
      XCTAssertEqual(result.data?.items.edges.count, 1)
      XCTAssertEqual(result.data?.items.edges[0].node.id, "1")
      XCTAssertEqual(result.data?.items.edges[0].node.name, "Brad")
    case .failure(let error):
      XCTFail("Unexpected error: \(error)")
    }
  }
  wait(for: [expectation], timeout: 1.0)
}
```

### Testing / Mocking GraphQLResult
Want to test your generated GraphQL data models against stable JSON data that you control?
`GraphQLResult.mockedJSONResponse` is your answer!

Mock your response, like `items.json` in your app bundle:
```json
{
  "data": {
    "items": {
      "__typename": "ItemCollection",
      "edges": [
        {
          "__typename": "ItemCollectionEdge",
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

Then test against that mock response:
```swift
func test_mockedJSONResponse() throws {
  let url = try XCTUnwrap(Bundle.module.url(forResource: "items", withExtension: "json"))
  let response = try GraphQLResult.mockedJSONResponse(
    for: TestQuery(),
    jsonURL: url)
  let data = try XCTUnwrap(response.data)
  XCTAssertEqual(data.items.edges.first?.node.__typename, "Item")
  XCTAssertEqual(data.items.edges.first?.node.id, "1")
  XCTAssertEqual(data.items.edges.first?.node.name, "Brad")
}
```