# ``ipbswiftapi_v7``

iProBonus Swift API Library

## Overview

`ipbswiftapi_v7` is a Swift package designed to simplify communication with iProBonus platform APIs. It provides a suite of services for functionalities like authorization, balance management, shopping cart, product catalog, document handling, media data, messaging, order processing, payments, customer relationship management and much more. Built with SwiftUI in mind, it employs a reactive approach using Combine for seamless integration into modern iOS development workflows.

## Features

- **Reactive Approach with Combine:** Facilitates efficient handling of asynchronous data and operations.
- **Secure Token Management:** Securely stores access tokens in Keychain, enhancing data security and user privacy.
- **Custom Request Protocol:** Simplifies API communication request creation.
- **Robust Error Handling:** Comprehensive error management at the package level.
- **Flexible UI Integration:** Compatible with package `ipbswiftui_v7` for UI components, but also allows for custom UI design and layout integration. For more details on the visual components library, visit [ipbswiftui_v7](https://github.com/progressterra/ipbswiftui_v7).

## Usage example

##### Authorize and get user cart

```swift
import Combine
import ipbswiftapi_v7

class ViewModel: ObservableObject {

    @Published var phoneNumber = ""
    @Published var codeFromSMS = ""
    @Published var cartResult: DHSaleHeadAsOrderViewModel?
    @Published var error: NetworkRequestError?

    private let authService = AuthorizationService()
    private let cartService = CartService()
    private var tempToken: String?
    private var subscriptions: Set<AnyCancellable> = []

    func startLogin() {
        authService.startLogin(with: phoneNumber)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if case .failure(let error) = $0 {
                    self?.error = error
                }
            } receiveValue: { [weak self] value in
                self?.tempToken = value.data?.tempToken
            }
            .store(in: &subscriptions)
    }
        
    func endLogin() {
        guard let tempToken else { return }
        authService.endLogin(with: codeFromSMS, tempToken: tempToken)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if case .failure(let error) = $0 {
                    self?.error = error
                }
            } receiveValue: { [weak self] value in
                AuthStorage.shared.updateTokenStorage(for: value.data) // save tokens to Keychain
                self?.phoneNumber = ""
                self?.codeFromSMS = ""
            }
            .store(in: &subscriptions)
    }
        
    func getCart() {
        cartService.getCart()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if case .failure(let error) = $0 {
                    self?.error = error
                }
            } receiveValue: { [weak self] value in
                self?.cartResult = value.data
            }
            .store(in: &subscriptions)
    }
}
```


## Topics

### Core

- ``AuthStorage``
- ``IPBSettings``

### Network Layer

- ``APIClient``
- ``NetworkDispatcher``
- ``Request``
- ``HTTPMethod``
- ``NetworkRequestError``
- ``MediaModel``

### Services

- ``ApplicationService``
- ``AuthorizationService``
- ``BalanceService``
- ``CartService``
- ``CatalogService``
- ``ChecklistService``
- ``ComPlaceService``
- ``DocumentService``
- ``MediaDataService``
- ``MessengerService``
- ``OrderService``
- ``PaymentDataService``
- ``PaymentsService``
- ``ProductService``
- ``SCRMService``

### Utilities

- ``JSONEncoderUtility``
- ``JSONDecoderUtility``
- ``KeychainUtility``
- ``NetworkConnectivityChecker``

### Filter and Sort

- ``FilterAndSort``
- ``FieldForFilter``
- ``SortData``
- ``TypeComparison``
- ``TypeVariantSort``
