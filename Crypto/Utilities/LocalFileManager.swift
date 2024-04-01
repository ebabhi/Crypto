//
//  FileManager.swift
//  Crypto
//
//  Created by Abhishek Ghimire on 28/03/2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    
    private var cacheURL : URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    
    func setImage(image: UIImage, name: String , folder : String) {
        if let url = cacheURL {
            
            let imageCacheDirectory = url
                .appendingPathComponent(folder)
            
            createFolderIfNeeded(imageCacheDirectory)
            
            let imageCacheurl  = imageCacheDirectory
                .appendingPathComponent(name)
            do{
                try image.pngData()?.write(to: imageCacheurl)
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    func getImage(name: String , folder : String)-> UIImage? {
        if let url = cacheURL {
            let imageCacheurl =   url
                .appendingPathComponent(folder)
                .appendingPathComponent(name)
            
            return  UIImage(contentsOfFile: imageCacheurl.path)
        }
        return nil
    }
    
    private func createFolderIfNeeded(_ at : URL) {
        do{
            try FileManager.default.createDirectory(at: at, withIntermediateDirectories: true)
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
}
