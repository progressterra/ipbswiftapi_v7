//
//  KeychainUtility.swift
//
//
//  Created by Artemy Volkov on 09.11.2023.
//

import Security
import Foundation

public struct KeychainUtility {
    
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
