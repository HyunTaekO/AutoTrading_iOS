//
//  TrainData.swift
//  DataManifests
//
//  Created by 오현택 on 5/22/24.
//

import Foundation
import RxSwift
import RxCocoa
import Utils
import Domain

final class TrainData {
    
    let fileManager: FileManager = FileManager.default
    let candleRepository: CandleRepository = CandleRepository(networkService: DefaultNetworkService())
    let disposeBag = DisposeBag()
    
    let version = 1
    var timeTypeString: String
    var symbol: MarketCode
    var timeType: CandleType
    let calendar = Calendar.current
    var documentPath: URL
    var directoryPath: URL
    
    var writeFileSuccess = PublishSubject<Bool>()
    
    init(symbol: MarketCode, timeType: CandleType) {
        self.symbol = symbol
        self.timeType = timeType
        self.documentPath = URL(fileURLWithPath: "///Users/ohhyunnteak/Documents/Documents/2024Project/CoinRichSystemUtils")
        self.directoryPath = documentPath.appendingPathComponent("TrainData/\(symbol.englishName)_v\(version)")
        
        
        switch timeType {
        case .minute(let m):
            self.timeTypeString = "Minute_\(m.rawValue)"
        case .hour(let h):
            self.timeTypeString = "Hour_\(h.rawValue)"
        case .days:
            self.timeTypeString = "Days"
        case .months:
            self.timeTypeString = "Months"
        case .weeks:
            self.timeTypeString = "Weeks"
        }
    }
    
    //Create
    func createDirectory() {
        do {
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch let e {
            print(e.localizedDescription)
        }
    }
    

    // Write
    func writeFile(candles: TrainDataCandles, filePath: URL) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(candles)
            try data.write(to: filePath)
            
        } catch {
            print("Error saving candles to file: \(error)")
        }
    }

    
    // Read
//    func readFile() -> TrainDataCandles? {
//        do {
//            let dataFromPath: Data = try Data(contentsOf: filePath)
//            let trainDataCandles = dataFromPath.toObject(TrainDataCandles.self)
//            let text: String = try dataFromPath.toString() ?? "문서없음"
//            print(text)
//            return trainDataCandles
//        } catch let e {
//            Logger.print(e.localizedDescription)
//            return nil
//        }
//    }
    

    // Delete
//    func deleteFile() {
//        do {
//            try fileManager.removeItem(at: filePath)
//        } catch let e {
//            print(e.localizedDescription)
//        }
//    }

}

extension TrainData {
    // Add Data
    func addTrainData(_ startDate: Date,_ endDate: Date) {
        var startDate = startDate
        var observables: [Observable<TrainDataCandles>] = []
        var idx = 0

        let dateString = startDate.toString(type: .yearMonth)
        let filePath = directoryPath.appendingPathComponent("\(self.symbol.englishName)_\(dateString)_\(self.timeTypeString).json")
        while startDate >= endDate {
            if idx % 5 == 0 && idx != 0 {
                Thread.sleep(forTimeInterval: 1.2)
            }
            let candles = candleRepository
                .fetchCandleData(self.symbol, startDate)
                .map{ $0.map{ $0.toTrainData() } }
                .catchAndReturn([])
            
            observables.append(candles)
            
            var nextDate: Date {
                switch timeType {
                case .minute(let m):
                    return calendar.date(byAdding: .minute, value: -(m.rawValue * 200), to: startDate)!
                default:
                    return calendar.date(byAdding: .minute, value: -(60 * 10 * 200), to: startDate)!
                }
            }
            
            startDate = nextDate
            idx += 1
        }
        
        
        Observable.from(observables)
            .concatMap{ $0 }
            .toArray()
            .subscribe(onSuccess: {[weak self] data in
                guard let self = self else { return }
                var trainData = data.flatMap{ $0 }
                if let last = trainData.last {
                    let lastDate = Date.stringToDate(dateString: last.candleDateTimeKst.replacingOccurrences(of: "T", with: " "), type: .toCandleFormat) ?? Date()
                    if !isSameMonth(lastDate, endDate) {
                        trainData = trainData.filter{ Date.stringToDate(dateString: $0.candleDateTimeKst.replacingOccurrences(of: "T", with: " "), type: .toCandleFormat)! >= endDate }
                    }
                }
                self.writeFile(candles: trainData, filePath: filePath)
                self.writeFileSuccess.onNext(true)
            }, onFailure: { error in
                Logger.errorPrint("파일쓰기 에러", error)
                self.writeFileSuccess.onNext(false)
            })
            .disposed(by: disposeBag)
    }
   
    func isSameMonth(_ date1: Date,_ date2: Date) -> Bool {
        
        let gap = calendar.dateComponents([.day], from: date1, to: date2)
        if gap.day ?? 1 > 0 {
            return false
        }
        return true
    }
}


