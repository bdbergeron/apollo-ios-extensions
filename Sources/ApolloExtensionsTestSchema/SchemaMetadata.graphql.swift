// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == ApolloExtensionsTestSchema.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == ApolloExtensionsTestSchema.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == ApolloExtensionsTestSchema.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == ApolloExtensionsTestSchema.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Mutation": return ApolloExtensionsTestSchema.Objects.Mutation
    case "Person": return ApolloExtensionsTestSchema.Objects.Person
    case "Query": return ApolloExtensionsTestSchema.Objects.Query
    case "PersonCollection": return ApolloExtensionsTestSchema.Objects.PersonCollection
    case "PersonCollectionEdge": return ApolloExtensionsTestSchema.Objects.PersonCollectionEdge
    case "Subscription": return ApolloExtensionsTestSchema.Objects.Subscription
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
