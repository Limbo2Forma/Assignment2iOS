/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import UIKit
import SwiftUI

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "png"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).png from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}

func downloadFromUrl(url: URL, path: URL) -> Void {
    if let downloadedData = NSData(contentsOf: url) {
        if downloadedData.write(to: path, atomically: true) {
            print("updated data\n")
        } else {
            print("error update data\n")
            exit(1)
        }
    } else {
        print("cant download\n")
        exit(1)
    }
}

// read the CSV and return a raw array of string with each row of the CSV is an element
func getCSVData() -> Array<String> {
//
    // get the path to the user Documents folder
    
    // require a placeholder file to find the path, the file is updated automatically
    let url = URL(string: "https://fixturedownload.com/download/epl-2020-GMTStandardTime.csv")!
    let docDir = Bundle.main.url(forResource: "epl-2020-GMTStandardTime", withExtension: "csv")

    // start download
    downloadFromUrl(url: url, path: docDir!)
    
    do {
        let content = try String(contentsOf: docDir!)
        var parsedCSV: [String] = content.components(
            separatedBy: "\n"
        )
        
        // remove the exceed '\n' and the first column name row
        parsedCSV.removeFirst()
        parsedCSV.removeLast()
        return parsedCSV
    }
    catch {
        print(error)
        return []
    }
}

