//
//  Created by Soroush on 1/19/24.

import Foundation
import Combine

class GetMessageViewModel {
    
    private var getMessagePublisher: AnyPublisher<Void, Never> = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    private let reloadMessageDataSubject = PassthroughSubject<Result<Void, NetworkError>, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    var messagesData = [MessageItem]()
    var numberOfRows = 0
    
    var reloadMessageList: AnyPublisher<Result<Void, NetworkError>, Never> {
        reloadMessageDataSubject.eraseToAnyPublisher()
    }
    
    func getMessagesListVM(messageData: AnyPublisher<Void, Never>) {
        self.getMessagePublisher = messageData
        self.getMessagePublisher
            .setFailureType(to: NetworkError.self)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.messagesData.removeAll()
            })
            .flatMap { _ -> AnyPublisher<[MessageItem], NetworkError> in
                return InteractionManager().getMessagesListIM()
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.messagesData.removeAll()
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
                // print("result", result)
                self?.prepareTableDataSource(response: result)
            })
            .store(in: &subscriptions)
    }
    
    private func prepareTableDataSource(response: [MessageItem]) {
        messagesData = response
        numberOfRows = response.count
        
        reloadMessageDataSubject.send(.success(()))
    }
    
}

