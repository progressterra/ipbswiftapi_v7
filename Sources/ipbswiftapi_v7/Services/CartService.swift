//
//  CartService.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

import Combine

public struct CartService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.cartBaseURLs)
    
    public init() {}
    
    public func getCart() -> AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        let request = CartRequest(accessToken: AuthStorage.shared.getAccessToken())
        return apiClient.dispatch(request)
    }
    
    public func addAddressToCart(addressString: String, idAddress: String) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartAddressPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            addressString: addressString,
            idAddress: idAddress
        )
        return apiClient.dispatch(request)
    }
    
    public func addBonusesToCart(_ amountBonuses: Double) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartBonusesPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            amountBonuses: amountBonuses
        )
        return apiClient.dispatch(request)
    }
    
    public func deleteBonusesFromCart() ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartBonusesDELETERequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }
    
    public func addCommentToCart(_ comment: String) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartCommentPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            comment: comment
        )
        return apiClient.dispatch(request)
    }
    
    public func confirmCart() ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartConfirmPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }
    
    public func processInternalPayment() ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartInternalPaymentPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }
    
    public func deleteCartItem(idrfNomenclature: String, count: Int) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartSalerowDELETERequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idrfNomenclature: idrfNomenclature,
            count: count
        )
        return apiClient.dispatch(request)
    }
    
    public func addCartItem(idrfNomenclature: String, count: Int) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = CartSalerowPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idrfNomenclature: idrfNomenclature,
            count: count
        )
        return apiClient.dispatch(request)
    }
    
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
