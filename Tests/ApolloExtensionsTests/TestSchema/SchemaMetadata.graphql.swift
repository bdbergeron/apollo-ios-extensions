// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

typealias ID = String

protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SchemaMetadata {}

protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaMetadata {}

protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SchemaMetadata {}

protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaMetadata {}

enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Query": return Objects.Query
    case "Item": return Objects.Item
    case "ItemCollection": return Objects.ItemCollection
    case "ItemCollectionEdge": return Objects.ItemCollectionEdge
    default: return nil
    }
  }
}

enum Objects {}
enum Interfaces {}
enum Unions {}
