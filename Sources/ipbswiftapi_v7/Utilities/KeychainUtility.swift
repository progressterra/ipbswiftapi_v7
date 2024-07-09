//
//  KeychainUtility.swift
//
//
//  Created by Artemy Volkov on 09.11.2023.
//

import Security
import Foundation

/// A utility for managing secure storage in the iOS Keychain.
///
/// `KeychainUtility` provides a simple interface to save, load, and delete secure items in the iOS Keychain. It's designed to work with generic password items, allowing you to store and retrieve small data blobs securely, such as tokens or credentials, across app launches.
///
/// ## Topics
///
/// ### Saving Items
///
/// - ``save(key:data:)``
///
/// ### Loading Items
///
/// - ``load(key:)``
///
/// ### Deleting Items
///
/// - ``delete(key:)``
///
public struct KeychainUtility {
    
    /// Saves data to the Keychain associated with a specific key.
    ///
    /// If an item with the provided key already exists in the Keychain, this function updates it with the new data. Otherwise, it adds a new item to the Keychain.
    ///
    /// - Parameters:
    ///   - key: A `String` representing the key under which to store the data.
    ///   - data: A `Data` object containing the data to be stored.
    ///
    /// - Note: This operation is performed asynchronously on a background queue.
    public static func save(key: String, data: Data) {
        DispatchQueue.global(qos: .background).async {
            var query = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ] as [String: Any]
            
            let accessible = kSecAttrAccessibleAfterFirstUnlock as String
            let updateAttributes = [
                kSecValueData as String: data,
                kSecAttrAccessible as String: accessible
            ]
            query.merge(updateAttributes) { (_, new) in new }
            
            let status = SecItemUpdate(query as CFDictionary, updateAttributes as CFDictionary)
            if status == errSecItemNotFound {
                SecItemAdd(query as CFDictionary, nil)
            }
        }
    }
    
    /// Loads data from the Keychain associated with a specific key.
    ///
    /// Retrieves the data stored in the Keychain for the given key. If no data is found, or if an error occurs, returns `nil`.
    ///
    /// - Parameter key: A `String` representing the key associated with the data to load.
    /// - Returns: An optional `Data` object containing the retrieved data if successful, or `nil` if not found or an error occurs.
    public static func load(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status != errSecSuccess {
            return nil
        }
        
        return item as? Data
    }
    
    /// Deletes a Keychain item associated with a specific key.
    ///
    /// Removes the data stored in the Keychain for the given key. If the item does not exist or an error occurs, this function fails silently.
    ///
    /// - Parameter key: A `String` representing the key associated with the data to delete.
    ///
    /// - Note: This operation is performed asynchronously on a background queue.
    public static func delete(key: String) {
        DispatchQueue.global(qos: .background).async {
            let query = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ] as [String: Any]
            
            _ = SecItemDelete(query as CFDictionary)
        }
    }
}
