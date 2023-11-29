# iProBonus Swift API V7

## Overview

`ipbswiftapi_v7` is a Swift package designed to simplify communication with [iProBonus](https://iprobonus.com) platform APIs. It provides a suite of services for functionalities like authorization, balance management, shopping cart, product catalog, document handling, media data, messaging, order processing, payments, and customer relationship management. Built with SwiftUI in mind, it employs a reactive approach using Combine for seamless integration into modern iOS development workflows.

## Features
- **Reactive Approach with Combine:** Facilitates efficient handling of asynchronous data and operations.
- **Secure Token Management:** Securely stores access tokens in Keychain, enhancing data security and user privacy.
- **Custom Request Protocol:** Simplifies API communication request creation.
- **Robust Error Handling:** Comprehensive error management at the package level.
- **Flexible UI Integration:** Compatible with package `ipbswiftui_v7` for UI components, but also allows for custom UI design and layout integration. For more details on the visual components library, visit [ipbswiftui_v7](https://github.com/progressterra/ipbswiftui_v7).

## Installation

To integrate `ipbswiftapi_v7` into your Swift project using the Swift Package Manager, ensure your project targets iOS 16 or later and you have Xcode 14 or later.

### Steps

1. **Open Your Project in Xcode:**
   - Launch Xcode and open your project.

2. **Add Package Dependency:**
   - Navigate to `File` > `Swift Packages` > `Add Package Dependency...`.
   - Enter the package repository URL: `https://github.com/progressterra/ipbswiftapi_v7.git`.
   - Click `Next`.

3. **Specify the Version:**
   - Select the version of `ipbswiftapi_v7` you wish to use.
   - Click `Next`.

4. **Select Package Products:**
   - Choose `ipbswiftapi_v7` from the list of packages.
   - Click `Finish`.

5. **Import and Use the Package:**
   - In your Swift files where you want to use the package, add `import ipbswiftapi_v7`.
   - Start utilizing the package's functionalities.

6. **Build Your Project:**
   - Compile your project to fetch and build the `ipbswiftapi_v7` package.

### Troubleshooting

- Check that your Xcode version and project settings are up-to-date and compatible with the package.
- For issues or errors, refer to the [GitHub Issues page](https://github.com/progressterra/ipbswiftapi_v7/issues) for `ipbswiftapi_v7`.


## Usage

### Authorization Service

Example of using the `AuthorizationService` for login, token refresh, and logout functionalities in `ipbswiftui_v7` implementation.

```swift
// Example usage of AuthorizationService
public func startLogin() {
    authService.startLogin(with: phoneNumber)
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.error = error
            case .finished:
                break
            }
        } receiveValue: { [weak self] result in
            self?.tempToken = result.data?.tempToken
            self?.secondForResendSMS = result.data?.secondForResendSMS ?? 0
        }
        .store(in: &subscriptions)
}

public func endLogin() {
    guard let tempToken else { return }
    
    authService.endLogin(with: codeFromSMS, tempToken: tempToken)
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.error = error
            case .finished:
                break
            }
        } receiveValue: { [unowned self] value in
            self.endLoginStatus = value.result.status
            if value.result.status == .success {
                AuthStorage.shared.updateTokenStorage(for: value.data)
            }
        }
        .store(in: &subscriptions)
}

public func logoutToken() {
    authService
        .logoutToken(
            refreshToken: AuthStorage.shared.getRefreshToken(),
            accessToken: AuthStorage.shared.getAccessToken()
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                if error == .unauthorized { // if NetworkRequestErorr case is unauthorized you should refresh JWT tokens and retry operation.
                    self?.refreshTokenAnd {
                        self?.logoutToken()
                    }
                }
            case .finished:
                break
            }
        } receiveValue: { [weak self] result in
            if result.result.status == .success {
                AuthStorage.shared.logout()
                self?.isLoggedIn = false
            }
        }
        .store(in: &subscriptions)
}

// Example of how you can handle topken refersh
public func refreshTokenAnd(_ retry: @escaping () -> Void) {
    if refreshTokenPublisher == nil {
        refreshTokenPublisher = authService.refreshToken(with: AuthStorage.shared.getRefreshToken())
            .share()
            .eraseToAnyPublisher()
    }
    
    refreshTokenPublisher?
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                print("Refresh token error: \(error)")
            case .finished:
                self?.refreshTokenPublisher = nil
                break
            }
        } receiveValue: { result in
            if result.result.status == .success {
                AuthStorage.shared.updateTokenStorage(for: result.data)
                retry()
            }
        }
        .store(in: &subscriptions)
}
```

## Contributing

We are excited to have contributors who can help us improve and expand `ipbswiftapi_v7`. Whether you're fixing bugs, improving the documentation, or sharing new ideas, your contributions are warmly welcomed.

### Contributing Guidelines

- **Open Issue or Feature Request:** If you have found a bug or have an idea for a new feature, please start by opening an issue. This allows us to discuss the potential changes before you put significant effort into it.
- **Fork and Clone:** Fork the project to your own GitHub account and then clone it to your local device.
- **Create a New Branch:** Make sure you create a new branch before making any changes.
- **Make Your Changes:** Implement your bug fix or feature. Keep your changes as focused as possible. If you want to make multiple changes, consider creating separate branches and pull requests.
- **Write Tests:** If possible, add tests that validate the changes you've made.
- **Follow the Code Style:** Make sure your code adheres to the existing style of the project to maintain consistency.
- **Commit Your Changes:** Write meaningful commit messages. Include a reference to the issue number if applicable.
- **Push Your Changes and Create a Pull Request:** Once you're happy with your changes, push your branch to GitHub and create a pull request against the `main` branch of the `ipbswiftapi_v7` repository.
- **Code Review:** Once your pull request is opened, maintainers will review your code and might request changes or provide feedback.

### High Load Development & Revolutionary Approach

`ipbswiftapi_v7` is under high-load development, aiming to revolutionize how we build applications. We're striving to create a package that not only simplifies API communication for Swift developers but also brings innovative features and approaches to the Swift and SwiftUI community. By contributing, you're participating in shaping the future of app development.

---

Your contributions, whether small or large, play a significant part in the success of `ipbswiftapi_v7`. Let's work together to build something revolutionary!
