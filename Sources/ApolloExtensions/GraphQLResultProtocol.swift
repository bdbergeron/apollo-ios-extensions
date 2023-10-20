// Created by Brad Bergeron on 10/19/23.

import Apollo
import ApolloAPI

// MARK: - GraphQLResultProtocol

public protocol GraphQLResultProtocol {
  associatedtype Data: RootSelectionSet
}

// MARK: - GraphQLResult + GraphQLResultProtocol

extension GraphQLResult: GraphQLResultProtocol { }
