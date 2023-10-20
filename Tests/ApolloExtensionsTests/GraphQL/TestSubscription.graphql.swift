// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import ApolloExtensionsTestSchema

final class TestSubscription: GraphQLSubscription {
  static let operationName: String = "TestSubscription"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription TestSubscription { people { __typename edges { __typename node { __typename ...Person } } } }"#,
      fragments: [Person.self]
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
        .field("edges", [Edge].self),
      ] }

      var edges: [Edge] { __data["edges"] }

      init(
        edges: [Edge]
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": ApolloExtensionsTestSchema.Objects.PersonCollection.typename,
            "edges": edges._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(TestSubscription.Data.People.self)
          ]
        ))
      }

      /// People.Edge
      ///
      /// Parent Type: `PersonCollectionEdge`
      struct Edge: ApolloExtensionsTestSchema.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { ApolloExtensionsTestSchema.Objects.PersonCollectionEdge }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("node", Node.self),
        ] }

        var node: Node { __data["node"] }

        init(
          node: Node
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": ApolloExtensionsTestSchema.Objects.PersonCollectionEdge.typename,
              "node": node._fieldData,
            ],
            fulfilledFragments: [
              ObjectIdentifier(TestSubscription.Data.People.Edge.self)
            ]
          ))
        }

        /// People.Edge.Node
        ///
        /// Parent Type: `Person`
        struct Node: ApolloExtensionsTestSchema.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { ApolloExtensionsTestSchema.Objects.Person }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(Person.self),
          ] }

          var id: ApolloExtensionsTestSchema.ID { __data["id"] }
          var name: String { __data["name"] }
          var nickname: String? { __data["nickname"] }
          var age: Int? { __data["age"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var person: Person { _toFragment() }
          }

          init(
            id: ApolloExtensionsTestSchema.ID,
            name: String,
            nickname: String? = nil,
            age: Int? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": ApolloExtensionsTestSchema.Objects.Person.typename,
                "id": id,
                "name": name,
                "nickname": nickname,
                "age": age,
              ],
              fulfilledFragments: [
                ObjectIdentifier(TestSubscription.Data.People.Edge.Node.self),
                ObjectIdentifier(Person.self)
              ]
            ))
          }
        }
      }
    }
  }
}
