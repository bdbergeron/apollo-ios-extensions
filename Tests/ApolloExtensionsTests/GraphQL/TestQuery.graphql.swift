// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import ApolloExtensionsTestSchema

final class TestQuery: GraphQLQuery {
  static let operationName: String = "TestQuery"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query TestQuery { people { __typename ...PersonCollection } }"#,
      fragments: [Person.self, PersonCollection.self]
    ))

  public init() {}

  struct Data: ApolloExtensionsTestSchema.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { ApolloExtensionsTestSchema.Objects.Query }
    static var __selections: [ApolloAPI.Selection] { [
      .field("people", People.self),
    ] }

    var people: People { __data["people"] }

    init(
      people: People
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": ApolloExtensionsTestSchema.Objects.Query.typename,
          "people": people._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(TestQuery.Data.self)
        ]
      ))
    }

    /// People
    ///
    /// Parent Type: `PersonCollection`
    struct People: ApolloExtensionsTestSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { ApolloExtensionsTestSchema.Objects.PersonCollection }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(PersonCollection.self),
      ] }

      var edges: [Edge] { __data["edges"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var personCollection: PersonCollection { _toFragment() }
      }

      init(
        edges: [Edge]
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": ApolloExtensionsTestSchema.Objects.PersonCollection.typename,
            "edges": edges._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(TestQuery.Data.People.self),
            ObjectIdentifier(PersonCollection.self)
          ]
        ))
      }

      typealias Edge = PersonCollection.Edge
    }
  }
}
