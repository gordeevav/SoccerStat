//
//  TransferViewModel.swift
//  NinjaIceHockey
//
//  Created by Александр on 24.11.2022.
//

import Foundation
import RxSwift

final class TransferViewModel {
    
    private let api = SofaScoreApi()
    private let disposeBag = DisposeBag()
    private let dateFormatter = DateFormatter()
    private let emptyString = "-/-"
    
    public let items = PublishSubject<[Transfer]>()
    
    public func fetchData(disposeBag: DisposeBag) {
        api.transfers()
            .compactMap { [weak self] transfersData -> [Transfer]? in
                self?.getTransferArray(from: transfersData)
            }
            .bind(to: items)
            .disposed(by: disposeBag)
        
//        let res = [
//            Transfer.mock(),
//            Transfer.mock(),
//            Transfer.mock(),
//            Transfer.mock(),
//            Transfer.mock(),
//            Transfer.mock(),
//            Transfer.mock(),
//            Transfer.mock(),
//        ]
//
//        items.onNext(res)
    }
    
    private func getTransferArray(from transfersData: TransfersData) -> [Transfer]? {
        guard let transfers = transfersData.transfers
        else { return nil }
            
        let result: [Transfer] = transfers.compactMap { transferData in
            Transfer(
                playerId:       transferData.player?.id ?? 0,
                playerName:     transferData.player?.name ?? emptyString,
                teamFromName:   transferData.fromTeamName ?? emptyString,
                teamFromId:     transferData.transferFrom?.id ?? 0,
                teamToName:     transferData.toTeamName ?? emptyString,
                teamToId:       transferData.transferTo?.id ?? 0,
                fee:            "\(transferData.transferFeeRaw?.value ?? 0) \(transferData.transferFeeRaw?.currency ?? "")" ,
                date:           dateFormatter.format(
                    from: transferData.transferDateTimestamp ?? 0,
                    dateFormat: "dd.MM.YYYY"
                )
            )
        }
        
        return result
    }
}

