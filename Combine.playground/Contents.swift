import UIKit
import Combine

var myIntArrayPublisher: Publishers.Sequence<[Int], Never> = [1, 2, 3].publisher

myIntArrayPublisher.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("완료")
    case .failure(let error):
        print("실패 - error: \(error)")
    }
}, receiveValue: { receivedValue in
    print("값을 받았다. : \(receivedValue)")
})

var mySubscriptioin: AnyCancellable?

var mySubsriptionSet = Set<AnyCancellable>()

var myNotification = Notification.Name("com.devReswo.customNotification")

var myDefaultPublisher: NotificationCenter.Publisher = NotificationCenter.default.publisher(for: myNotification)

mySubscriptioin = myDefaultPublisher.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("완료")
    case .failure(let error):
        print("실패 - error: \(error)")
    }
}, receiveValue: { receivedValue in
    print("받은 값 : \(receivedValue)")
})

mySubscriptioin?.store(in: &mySubsriptionSet)

NotificationCenter.default.post(Notification(name: myNotification))
NotificationCenter.default.post(Notification(name: myNotification))
NotificationCenter.default.post(Notification(name: myNotification))

//mySubscriptioin?.cancel()

//MARK: - KVO - Key value observing

class MyFriend {
    var name = "철수" {
        didSet {
            print("name - didSet(): \(name)")
        }
    }
}

var myFriend = MyFriend()

var myFriendSubscription: AnyCancellable = ["영수"].publisher.assign(to: \.name, on: myFriend)

 
