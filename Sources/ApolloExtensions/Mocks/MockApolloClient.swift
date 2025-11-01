// Created by Brad Bergeron on 10/31/25.

#if DEBUG

import Apollo
import ApolloAPI

public final actor MockApolloClient: ApolloClientProtocol {

  // MARK: Lifecycle

  public init() { }

  // MARK: Public

  public func registerResult<Operation: GraphQLOperation>(
    _ result: Result<GraphQLResponse<Operation>, Swift.Error>,
    for operationType: Operation.Type
  ) {
    responses[operationType.operationName] = .init(result: .init { try result.get() })
  }

  public func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy _: CachePolicy.Query.SingleResponse,
    requestConfiguration _: RequestConfiguration?
  ) async throws -> GraphQLResponse<Query>
    where Query.ResponseFormat == SingleResponseFormat
  {
    try mockResponse(for: query).get()
  }

  public func perform<Mutation: GraphQLMutation>(
    mutation: Mutation,
    requestConfiguration _: RequestConfiguration?
  ) async throws -> GraphQLResponse<Mutation>
    where Mutation.ResponseFormat == SingleResponseFormat
  {
    try mockResponse(for: mutation).get()
  }

  public func subscribe<Subscription: GraphQLSubscription>(
    subscription: Subscription,
    cachePolicy _: CachePolicy.Subscription,
    requestConfiguration _: RequestConfiguration?
  ) async throws -> AsyncThrowingStream<GraphQLResponse<Subscription>, Swift.Error>
  {
    let response = try mockResponse(for: subscription).get()
    return .init { continuation in
      continuation.yield(response)
      continuation.finish()
    }
  }

  // MARK: Internal

  enum Error: Swift.Error {
    case noResultSet
  }

  // MARK: Private

  private struct MockResponse {
    let result: Result<Any, Swift.Error>
  }

  private var responses = [String: MockResponse]()

  private func mockResponse<Operation: GraphQLOperation>(for operation: Operation) throws
    -> Result<GraphQLResponse<Operation>, Swift.Error>
  {
    guard let response = responses[type(of: operation).operationName] else {
      throw Error.noResultSet
    }
    return .init {
      try response.result.get() as! GraphQLResponse<Operation>
    }
  }
}

#endif
