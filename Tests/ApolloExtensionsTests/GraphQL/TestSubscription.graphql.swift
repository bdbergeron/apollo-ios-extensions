// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

final class TestSubscription: GraphQLSubscription {
  static let operationName: String = "TestSubscription"
  static let operationDocument: OperationDocument = .init(
    definition: .init(
      #"subscription TestSubscription { items { __typename edges { __typename node { __typename id name } } } }"#
    ))

  init() {}

  struct Data: SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ParentType { Objects.Subscription }
    static var __selections: [Selection] { [
      .field("items", Items.self),
    ] }

    var items: Items { __data["items"] }

    init(
      items: Items
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": Objects.Subscription.typename,
          "items": items._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(TestQuery.Data.self)
        ]
      ))
    }

    struct Items: SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ParentType { Objects.ItemCollection }
      static var __selections: [Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge].self),
      ] }

      var edges: [Edge] { __data["edges"] }

      init(
        edges: [Edge]
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": Objects.ItemCollection.typename,
            "edges": edges._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(TestQuery.Data.Items.self)
          ]
        ))
      }

      struct Edge: SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ParentType { Objects.ItemCollectionEdge }
        static var __selections: [Selection] { [
          .field("__typename", String.self),
          .field("node", Node.self),
        ] }

        var node: Node { __data["node"] }

        init(
          node: Node
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": Objects.ItemCollectionEdge.typename,
              "node": node._fieldData,
            ],
            fulfilledFragments: [
              ObjectIdentifier(TestQuery.Data.Items.Edge.self)
            ]
          ))
        }

        struct Node: SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ParentType { Objects.Item }
          static var __selections: [Selection] { [
            .field("__typename", String.self),
            .field("id", String.self),
            .field("name", String?.self),
          ] }

          var id: String { __data["id"] }
          var name: String? { __data["name"] }

          init(
            id: String,
            name: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": Objects.Item.typename,
                "id": id,
                "name": name,
              ],
              fulfilledFragments: [
                ObjectIdentifier(TestQuery.Data.Items.Edge.Node.self)
              ]
            ))
          }
        }
      }
    }
  }
}
