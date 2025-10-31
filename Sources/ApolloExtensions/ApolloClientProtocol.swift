// Created by Brad Bergeron on 10/31/25.

import Apollo
import ApolloAPI

// MARK: - ApolloClientProtocol

public protocol ApolloClientProtocol: Sendable {
  func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy.Query.SingleResponse,
    requestConfiguration: RequestConfiguration?
  ) async throws -> GraphQLResponse<Query>
    where Query.ResponseFormat == SingleResponseFormat

  func perform<Mutation: GraphQLMutation>(
    mutation: Mutation,
    requestConfiguration: RequestConfiguration?
  ) async throws -> GraphQLResponse<Mutation>
    where Mutation.ResponseFormat == SingleResponseFormat

  func subscribe<Subscription: GraphQLSubscription>(
    subscription: Subscription,
    cachePolicy: CachePolicy.Subscription,
    requestConfiguration: RequestConfiguration?
  ) async throws -> AsyncThrowingStream<GraphQLResponse<Subscription>, any Swift.Error>
}

extension ApolloClientProtocol {
  public func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy.Query.SingleResponse = .cacheFirst,
    requestConfiguration: RequestConfiguration? = nil
  ) async throws -> GraphQLResponse<Query>
    where Query.ResponseFormat == SingleResponseFormat
  {
    try await fetch(query: query, cachePolicy: cachePolicy, requestConfiguration: requestConfiguration)
  }

  public func perform<Mutation: GraphQLMutation>(
    mutation: Mutation,
    requestConfiguration: RequestConfiguration? = nil
  ) async throws -> GraphQLResponse<Mutation>
    where Mutation.ResponseFormat == SingleResponseFormat
  {
    try await perform(mutation: mutation, requestConfiguration: requestConfiguration)
  }

  public func subscribe<Subscription: GraphQLSubscription>(
    subscription: Subscription,
    cachePolicy: CachePolicy.Subscription = .cacheThenNetwork,
    requestConfiguration: RequestConfiguration? = nil
  ) async throws -> AsyncThrowingStream<GraphQLResponse<Subscription>, any Swift.Error>
  {
    try await subscribe(subscription: subscription, cachePolicy: cachePolicy, requestConfiguration: requestConfiguration)
  }
}

// MARK: - ApolloClient + ApolloClientProtocol

extension ApolloClient: ApolloClientProtocol { }
