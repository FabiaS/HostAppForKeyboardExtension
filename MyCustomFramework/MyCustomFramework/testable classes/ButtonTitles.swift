import Foundation

public enum RowNumber: Int {
    case row1 = 1, row2, row3
}

// ??? could be a struct 
public class ButtonTitles: NSObject {
    
    private var row1Titles: [String]
    private var row2Titles: [String]
    private var row3Titles: [String]
    private let settings = KeyboardSettings()
    
    public init(pageNumber: Int) {
        
        let fileTitle = "titlesPage\(pageNumber)"
        if let path = Bundle.main.path(forResource: fileTitle, ofType: "json"),
            let data = try? NSData(contentsOfFile: path, options: .mappedIfSafe),
            let json = try? JSONSerialization.jsonObject(with: data as Data, options: []),
            let jsonArray = json as? [Any],
            let firstObject = jsonArray.first,
            let pageDict = firstObject as? [String : Any],
            let row1 = pageDict["row1"] as? [String],
            let row2 = pageDict["row2"] as? [String],
            let row3 = pageDict["row3"] as? [String]
        { 
            self.row1Titles = row1
            self.row2Titles = row2
            self.row3Titles = row3
        } else {
            self.row1Titles = []
            self.row2Titles = []
            self.row3Titles = []
        }
        
        super.init()
    }
    
    public func getTitlesForRow(_ row: RowNumber) -> [String] {
        switch row {
        case .row1:
            return self.row1Titles
        case .row2:
            return self.row2Titles
        case .row3:
            return self.row3Titles
        }
    }
    
}
