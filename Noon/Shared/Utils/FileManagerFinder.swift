//
//  FileManagerFinder.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 03/04/24.
//

import Foundation
import UIKit

class FileManagerFinder {
    static func loadFiles() -> [URL] {
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let csvFiles = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
//                .filter { $0.pathExtension == "csv" }
            return csvFiles
        } catch {
            print("Error loading CSV files: \(error.localizedDescription)")
            return []
        }
    }
    
    static func shareFile(fileURL: URL) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        window.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    static func deleteFile(at fileURL: URL) {
            do {
                try FileManager.default.removeItem(at: fileURL)
                print("File deleted successfully.")
            } catch {
                print("Error deleting file: \(error.localizedDescription)")
            }
        }
}

