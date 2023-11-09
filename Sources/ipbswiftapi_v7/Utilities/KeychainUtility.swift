//
//  KeychainUtility.swift
//
//
//  Created by Artemy Volkov on 09.11.2023.
//

import Security
import Foundation

public struct KeychainUtility {

    @discardableResult
    public static func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ] as [String: Any]

        let attributesToUpdate = [kSecValueData as String: data]

        var status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        
        if status == errSecItemNotFound {
            var newItem = query
            newItem[kSecValueData as String] = data
            status = SecItemAdd(newItem as CFDictionary, nil)
        }
        
        if status != errSecSuccess, let errorMessage = SecCopyErrorMessageString(status, nil) {
            print("Save to Keychain failed: \(errorMessage as String)")
        }

        return status
    }
    
    public static func load(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status != errSecSuccess, let errorMessage = SecCopyErrorMessageString(status, nil) {
            print("Load from Keychain failed: \(errorMessage as String)")
            return nil
        }
        
        return item as? Data
    }
    
    @discardableResult
    public static func delete(key: String) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ] as [String: Any]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess, let errorMessage = SecCopyErrorMessageString(status, nil) {
            print("Delete from Keychain failed: \(errorMessage as String)")
        }
        
        return status
    }
}
