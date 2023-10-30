// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import ApolloExtensionsTestSchema

final class TestSubscription: GraphQLSubscription {
  static let operationName: String = "TestSubscription"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription TestSubscription { people { __typename ...PersonCollection } }"#,
      fragments: [PersonCollection.self, Person.self]
    ))

  public init() {}

  struct Data: ApolloExtensionsTestSchema.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { ApolloExtensionsTestSchema.Objects.Subscription }
    static var __selections: [ApolloAPI.Selection] { [
      .field("people", People.self),
    ] }

    var people: People { __data["people"] }

    init(
      people: People
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": ApolloExtensionsTestSchema.Objects.Subscription.typename,
          "people": people._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(TestSubscription.Data.self)
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

      var edges: [PersonCollection.Edge] { __data["edges"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var personCollection: PersonCollection { _toFragment() }
      }

      init(
        edges: [PersonCollection.Edge]
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": ApolloExtensionsTestSchema.Objects.PersonCollection.typename,
            "edges": edges._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(TestSubscription.Data.People.self),
            ObjectIdentifier(PersonCollection.self)
          ]
        ))
      }
    }
  }
}
