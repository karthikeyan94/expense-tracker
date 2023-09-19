//
//  ETTransactionDocument.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 19/09/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ETTransactionDocument: FileDocument {
    
    static var readableContentTypes: [UTType] = [.text, .json]
    
    var text: String = ""
    
    init(_ text: String = "") {
        self.text = text
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
