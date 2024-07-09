//
//  CartService.swift
//
//
//  Created by Artemy Volkov on 11.07.2023.
//

import Combine

/// Provides functionality for managing a shopping cart, including item management and checkout processes.
///
/// `CartService` uses an `APIClient` to communicate with the backend, performing actions such as retrieving the current cart state, adding or removing items, applying bonuses, and processing the cart for checkout.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Cart Operations
///
/// - ``getCart()``
/// - ``addAddressToCart(addressString:idAddress:)``
/// - ``addBonusesToCart(_:)``
/// - ``deleteBonusesFromCart()``
/// - ``addCommentToCart(_:)``
/// - ``confirmCart()``
/// - ``processInternalPayment()``
/// - ``deleteCartItem(idrfNomenclature:count:)``
/// - ``addCartItem(idrfNomenclature:count:)``
/// - ``addCartItemWithInstallmentPlan(idrfNomenclature:count:countMonthPayment:amountPaymentInMonth:)``
///
public struct CartService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.cartBaseURLs)
    
    public init() {}
    
    /// Fetches the current state of the shopping cart.
    /// - Returns: A publisher emitting the current cart state or a `NetworkRequestError`.
    public func getCart() -> AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        let request = CartRequest(accessToken: AuthStorage.shared.getAccessToken())
        return apiClient.dispatch(request)
    }
    
    /// Adds an address to the shopping cart.
    /// - Parameters:
    ///   - addressString: The address in string format.
    ///   - idAddress: A unique identifier for the address.
    /// - Returns: A publisher emitting the updated cart state or a `NetworkRequestError`.
    public func addAddressToCart(addressString: String, idAddress: String) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartAddressPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            addressString: addressString,
            idAddress: idAddress
        )
        return apiClient.dispatch(request)
    }
    
    /// Adds bonuses to the shopping cart.
    /// - Parameter amountBonuses: The amount of bonuses to apply to the cart.
    /// - Returns: A publisher emitting the updated cart state or a `NetworkRequestError`.
    public func addBonusesToCart(_ amountBonuses: Double) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartBonusesPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            amountBonuses: amountBonuses
        )
        return apiClient.dispatch(request)
    }
    
    /// Deletes bonuses from the shopping cart.
    /// - Returns: A publisher emitting the updated cart state without bonuses or a `NetworkRequestError`.
    public func deleteBonusesFromCart() ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartBonusesDELETERequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }
    
    /// Adds a comment to the shopping cart.
    /// - Parameter comment: The comment to add to the cart.
    /// - Returns: A publisher emitting the updated cart state with the comment or a `NetworkRequestError`.
    public func addCommentToCart(_ comment: String) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartCommentPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            comment: comment
        )
        return apiClient.dispatch(request)
    }
    
    /// Confirms the shopping cart, moving it towards checkout.
    /// - Returns: A publisher emitting the confirmed cart state or a `NetworkRequestError`.
    public func confirmCart() ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartConfirmPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }
    
    /// Processes an internal payment within the shopping cart.
    /// - Returns: A publisher emitting the updated cart state post-payment or a `NetworkRequestError`.
    public func processInternalPayment() ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartInternalPaymentPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }
    
    /// Deletes an item from the shopping cart.
    /// - Parameters:
    ///   - idrfNomenclature: The unique identifier of the item to delete.
    ///   - count: The quantity of the item to delete.
    /// - Returns: A publisher emitting the updated cart state without the specified item or a `NetworkRequestError`.
    public func deleteCartItem(idrfNomenclature: String, count: Int) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartSalerowDELETERequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idrfNomenclature: idrfNomenclature,
            count: count
        )
        return apiClient.dispatch(request)
    }
    
    /// Adds an item to the shopping cart.
    /// - Parameters:
    ///   - idrfNomenclature: The unique identifier of the item to add.
    ///   - count: The quantity of the item to add.
    /// - Returns: A publisher emitting the updated cart state with the new item or a `NetworkRequestError`.
    public func addCartItem(idrfNomenclature: String, count: Int) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartSalerowPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idrfNomenclature: idrfNomenclature,
            count: count
        )
        return apiClient.dispatch(request)
    }
    
    /// Adds an item to the shopping cart with an installment plan.
    /// - Parameters:
    ///   - idrfNomenclature: The unique identifier of the item to add.
    ///   - count: The quantity of the item to add.
    ///   - countMonthPayment: The number of monthly payments for the installment plan.
    ///   - amountPaymentInMonth: The amount to be paid each month.
    /// - Returns: A publisher emitting the updated cart state with the new installment plan item or a `NetworkRequestError`.
    public func addCartItemWithInstallmentPlan(
        idrfNomenclature: String,
        count: Int,
        countMonthPayment: Int,
        amountPaymentInMonth: Double
    ) -> AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartSalerowInstallmentPlanRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idrfNomenclature: idrfNomenclature,
            count: count,
            countMonthPayment: countMonthPayment,
            amountPaymentInMonth: amountPaymentInMonth
        )
        return apiClient.dispatch(request)
    }
}
