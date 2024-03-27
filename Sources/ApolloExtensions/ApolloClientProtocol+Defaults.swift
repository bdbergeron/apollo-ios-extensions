// Created by Brad Bergeron on 10/17/23.

import Apollo
import ApolloAPI
import Foundation

extension ApolloClientProtocol {

  public func clearCache(
    callbackQueue: DispatchQueue = .main,
    completion: ((Result<Void, Error>) -> Void)? = nil)
  {
    clearCache(callbackQueue: callbackQueue, completion: completion)
  }
  
  @discardableResult
  public func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy = .default,
    contextIdentifier: UUID? = nil,
    context: RequestContext? = nil,
    queue: DispatchQueue = .main,
    resultHandler: GraphQLResultHandler<Query.Data>? = nil)
    -> Cancellable
  {
    fetch(
      query: query,
      cachePolicy: cachePolicy,
      contextIdentifier: contextIdentifier,
      context: context,
      queue: queue,
      resultHandler: resultHandler)
  }

  public func watch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy = .default,
    context: RequestContext? = nil,
    callbackQueue: DispatchQueue = .main,
    resultHandler: @escaping GraphQLResultHandler<Query.Data>)
    -> GraphQLQueryWatcher<Query>
  {
    watch(
      query: query,
      cachePolicy: cachePolicy,
      context: context,
      callbackQueue: callbackQueue,
      resultHandler: resultHandler)
  }

  @discardableResult
  public func perform<Mutation: GraphQLMutation>(
    mutation: Mutation,
    publishResultToStore: Bool = true,
    contextIdentifier: UUID? = nil,
    context: RequestContext? = nil,
    queue: DispatchQueue = .main,
    resultHandler: GraphQLResultHandler<Mutation.Data>? = nil)
    -> Cancellable
  {
    perform(
      mutation: mutation,
      publishResultToStore: publishResultToStore,
      contextIdentifier: contextIdentifier,
      context: context,
      queue: queue,
      resultHandler: resultHandler)
  }

  @discardableResult
  public func upload<Operation: GraphQLOperation>(
    operation: Operation,
    files: [GraphQLFile],
    context: RequestContext? = nil,
    queue: DispatchQueue = .main,
    resultHandler: GraphQLResultHandler<Operation.Data>? = nil)
    -> Cancellable
  {
    upload(
      operation: operation,
      files: files,
      context: context,
      queue: queue,
      resultHandler: resultHandler)
  }

  public func subscribe<Subscription: GraphQLSubscription>(
    subscription: Subscription,
    context: RequestContext? = nil,
    queue: DispatchQueue = .main,
    resultHandler: @escaping GraphQLResultHandler<Subscription.Data>)
    -> Cancellable
  {
    subscribe(
      subscription: subscription,
      context: context,
      queue: queue,
      resultHandler: resultHandler)
  }
}
