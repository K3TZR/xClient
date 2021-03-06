//
//  TokenStore.swift
//  xClient
//
//  Created by Douglas Adams on 9/5/20.
//

import Foundation

final class TokenStore {
    // ----------------------------------------------------------------------------
    // MARK: - Private properties

    private var _wrapper : KeychainWrapper

    // ----------------------------------------------------------------------------
    // MARK: - Initialization

    init(service: String) {
        _wrapper = KeychainWrapper(serviceName: service)
    }

    // ----------------------------------------------------------------------------
    // MARK: - Public methods

    public func set(account: String, data: String) -> Bool {
        return _wrapper.set(data, forKey: account)
    }

    public func get(account: String) -> String? {
        return _wrapper.string(forKey: account)
    }

    public func delete(account: String) -> Bool{
        return _wrapper.removeObject(forKey: account)
    }
}
