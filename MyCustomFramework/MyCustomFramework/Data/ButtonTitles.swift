import Foundation

public struct ButtonTitles {
    
    private let settings = KeyboardSettings()
    private var titles = [[String]]()
    
    public init(forPage pageNumber: Int) {
        
        var pagesDict: [String : Any] = [:]
        
        if let path = Bundle.main.path(forResource: "buttonTitles", ofType: "json"),
            let data = try? NSData(contentsOfFile: path, options: .mappedIfSafe),
            let json = try? JSONSerialization.jsonObject(with: data as Data, options: []),
            let jsonArray = json as? [Any],
            let innerJsonDict = jsonArray.first as? [String : Any] {
            
            pagesDict = innerJsonDict
        } else {
            print("Error: titles-json could not be serialized.")
        }
        
        let pageKey = "page\(pageNumber)"
        if let pageDict = pagesDict[pageKey] as? [String : Any] {
            
            for rowNumber in 1...settings.maxRowCount {
                let rowKey = "row\(rowNumber)"
                if let rowTitles = pageDict[rowKey] as? [String] {
                    titles.append(rowTitles)
                } else {
                    print("Error: titles for row \(rowNumber) could not be extracted.")
                }
            }
            
        } else {
            print("Error: titles for page \(pageNumber) could not be extracted.")
        }
    }
    
    public func getTitles(forRow rowNumber: Int) -> [String] {
        if rowNumber < 1 || rowNumber > settings.maxRowCount {
            fatalError("rowNumber is out of bounds")
        }
        return titles[rowNumber-1]
    }
    
}
