// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ApolloExtensions",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "ApolloExtensions", targets: ["ApolloExtensions"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios", .upToNextMajor(from: "1.9.1")),
  ],
  targets: [
    .target(
      name: "ApolloExtensions",
      dependencies: [
        .product(name: "Apollo", package: "apollo-ios"),
      ]),
    .target(
      name: "ApolloExtensionsTestSchema",
      dependencies: [
        .product(name: "Apollo", package: "apollo-ios"),
      ],
      exclude: [
        "schema.graphqls",
      ]),
    .testTarget(
      name: "ApolloExtensionsTests",
      dependencies: [
        .target(name: "ApolloExtensions"),
        .target(name: "ApolloExtensionsTestSchema"),
      ],
      exclude: [
        "GraphQL/Person.graphql",
        "GraphQL/PersonCollection.graphql",
        "GraphQL/TestMutation.graphql",
        "GraphQL/TestQuery.graphql",
        "GraphQL/TestSubscription.graphql",
      ],
      resources: [
        .process("Resources"),
      ]),
  ])
