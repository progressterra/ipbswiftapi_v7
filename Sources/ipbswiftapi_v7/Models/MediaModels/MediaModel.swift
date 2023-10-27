//
//  MediaModel.swift
//  
//
//  Created by Artemy Volkov on 02.08.2023.
//

import Foundation

/// `MediaModel` is a representation of a media file for multipart form data requests.
///
/// It includes the key name, the binary data of the file, the file extension, and the MIME type.
///
/// Parameters:
///   - key: The key associated with the file data. Default is "file".
///   - data: The binary data of the file.
///   - fileExtension: The extension of the file. Default is ".jpg".
///   - mimeType: The MIME type of the file. Default is "image/jpeg".
///
/// Usage Example:
/// ```swift
/// let media = MediaModel(key: "image", data: imageData, fileExtension: ".jpg", mimeType: "image/jpeg")
/// ```
public struct MediaModel {
    let key: String
    let data: Data
    let fileExtension: String
    let mimeType: String
    
    public init(key: String = "file", data: Data, fileExtension: String = ".jpg", mimeType: String = "image/jpeg") {
        self.key = key
        self.data = data
        self.fileExtension = fileExtension
        self.mimeType = mimeType
    }
}
