// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum DataStoreError {
    /// Oops! Looks like %@ isn't a valid URL
    internal static func badUrl(_ p1: Any) -> String {
      return L10n.tr("Localizable", "DataStoreError.badUrl", String(describing: p1), fallback: "Oops! Looks like %@ isn't a valid URL")
    }
    /// Something isn't right: %@
    internal static func transport(_ p1: Any) -> String {
      return L10n.tr("Localizable", "DataStoreError.transport", String(describing: p1), fallback: "Something isn't right: %@")
    }
    /// Looks like we hit a snag...try again?
    internal static let unknown = L10n.tr("Localizable", "DataStoreError.unknown", fallback: "Looks like we hit a snag...try again?")
  }
  internal enum HomeView {
    /// Employees
    internal static let title = L10n.tr("Localizable", "HomeView.title", fallback: "Employees")
    internal enum Button {
      /// *Try again?*
      internal static let refresh = L10n.tr("Localizable", "HomeView.button.refresh", fallback: "*Try again?*")
    }
    internal enum Message {
      /// Nothing to see here!
      internal static let empty = L10n.tr("Localizable", "HomeView.message.empty", fallback: "Nothing to see here!")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
