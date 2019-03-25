//
//  ChatViewController.swift
//  SuperCart
//
//  Created by Ashis Laha on 3/23/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import ApiAI
import JSQMessagesViewController
import UIKit
import Speech

protocol ChatDelegate: class {
    
}

enum Operation {
    case add, remove
}

struct Message {
    static let title = "title"
    static let imageUrl = "imageUrl"
    static let type = "type"
    static let subtitle = "subtitle"
    static let productName = "productName"
}

class OutgoingAvatar:NSObject, JSQMessageAvatarImageDataSource {
    func avatarImage() -> UIImage! {
        return #imageLiteral(resourceName: "user-avatar")
    }
    func avatarHighlightedImage() -> UIImage! {
        return #imageLiteral(resourceName: "user-avatar")
    }
    func avatarPlaceholderImage() -> UIImage! {
        return #imageLiteral(resourceName: "user-avatar")
    }
}

class IncomingAvatar:NSObject, JSQMessageAvatarImageDataSource {
    func avatarImage() -> UIImage! {
        return #imageLiteral(resourceName: "user-avatar")
    }
    func avatarHighlightedImage() -> UIImage! {
        return #imageLiteral(resourceName: "user-avatar")
    }
    func avatarPlaceholderImage() -> UIImage! {
        return #imageLiteral(resourceName: "user-avatar")
    }
}


class ChatViewController: JSQMessagesViewController {
    
    public var isUserInsideStore: Bool = false // this flag is caputured to restrict few queries to the users
    private let senderIdentifier = "walmart chat bot"
    private let displayName = "SuperRobo"
    private let userId = "userId"
    private let userName = "user_name"
    private let initialStatement = "Say something, I'm listening!"

    private var dialogflowMessages: [[String: Any]] = []
    private var category: String = ""
    private var productName: String = ""
    private var timer: Timer?
    private var index = 0
    private var endIndex = 0
    private let initialMessage = "Hi Ashis. I am Walmart-Bot: WalRobo. Welcome to SuperCart"
    
    var messages = [JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    weak var delegate: ChatDelegate?
    private var micButton: UIButton!
    private var tapped = false {
        didSet {
            tapped ? micButton?.setTitle("Stop", for: .normal): micButton?.setTitle("Speech", for: .normal)
            tapped ? SpeechManager.shared.startRecording() : SpeechManager.shared.stopRecording()
        }
    }
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = senderIdentifier
        self.senderDisplayName = displayName
        
        SpeechManager.shared.delegate = self
        addMicButton()
        
        collectionView?.collectionViewLayout.incomingAvatarViewSize = CGSize(width: 30, height: 30)
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: 30, height: 30)
        
        addMessage(withId: senderId, name: senderDisplayName, text: initialMessage)
    }
    
    func addMicButton() {
        let height = self.inputToolbar.contentView.leftBarButtonContainerView.frame.size.height
        micButton = UIButton(type: .custom)
        micButton?.setTitle("Speech", for: .normal)
        micButton?.frame = CGRect(x: 0, y: 0, width: 70, height: height)
        micButton.setTitleColor(.red, for: .normal)
        
        inputToolbar.contentView.leftBarButtonItemWidth = 70
        inputToolbar.contentView.leftBarButtonContainerView.addSubview(micButton)
        inputToolbar.contentView.leftBarButtonItem.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
        micButton?.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped(gesture: UITapGestureRecognizer) {
        tapped = !tapped
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.item]
        return message.senderId == senderId ? OutgoingAvatar(): IncomingAvatar()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as? JSQMessagesCollectionViewCell else { return UICollectionViewCell() }
        let message = messages[indexPath.item]
        cell.textView?.textColor = message.senderId == senderId ? UIColor.white: UIColor.black
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        addMessage(withId: userId, name: userName, text: text!)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        performQuery(senderId: userId, name: userName, text: text!)
        tapped = false
        inputToolbar.contentView.textView.text = ""
    }
    
    override func didPressAccessoryButton(_ sender: UIButton) {
        performQuery(senderId: userId, name: userName, text: "Multimedia")
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
//        guard let test = self.messages[indexPath.row].media, let photoItem = test as? JSQPhotoMediaItem,
//            let selectedImage = photoItem.image, !self.productName.isEmpty,!category.isEmpty, let departmanet = ProductDepartment(rawValue: category.lowercased()) else { return }
//        let wishList = WishList(prodName: self.productName, category: category, image: selectedImage)
//        
//        StoreModel.shared.shoppingList[departmanet]!.append(wishList)
//        addImageMedia(image: #imageLiteral(resourceName: "addCart"))
//        addMessage(withId: senderId, name: displayName, text: "\(productName) added to your shopping list.")
    }
}

// MARK: Dialogflow handling

extension ChatViewController {
    
    func performQuery(senderId:String, name:String, text:String) {
        guard !text.isEmpty else { return }
        let request = ApiAI.shared().textRequest()
        request?.query = text
        
        request?.setMappedCompletionBlockSuccess({ [weak self] (request, response) in
            
            guard let response = response as? AIResponse, let strongSelf = self, let action = response.result.action else { return }
            switch action {
            case "input.add": strongSelf.handleItem(response: response, operation: .add)
            case "input.delete": strongSelf.handleItem(response: response, operation: .remove)
            case "input.showList": strongSelf.handleShowWishList()
            default: break
            }
            
            }, failure: { (request, error) in
                print(error?.localizedDescription ?? "some fetching error at dialogflow")
        })
        ApiAI.shared().enqueue(request)
    }
    
    
    private func handleItem(response: AIResponse, operation: Operation) {
        if let messages = response.result.fulfillment.messages as? [[String: Any]], !messages.isEmpty {
            if let dict = messages.first, let speech = dict["speech"] as? String {
                addMessage(withId: senderId, name: senderDisplayName, text: speech)
                addImageMedia(image: UIImage(named: "fruits") ?? UIImage()) // TODO: change it later based on category
                
                switch operation {
                case .add: print("handle local data-base .... added")
                    
                case .remove: print("handle local data-base .... remove item")
                }
            }
        }
    }
    
    private func handleShowWishList() {
//        guard !StoreModel.shared.shoppingList.isEmpty else { return }
//        addImageMedia(image: #imageLiteral(resourceName: "fullList"))
//        for (_, list) in StoreModel.shared.shoppingList {
//            for each in list {
//                addMessage(withId: senderIdentifier, name: senderDisplayName, text: each.prodName)
//                addImageMedia(image: each.image)
//            }
//        }
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
            finishSendingMessage()
        }
    }
    
    private func addImageMedia(image: UIImage) {
        if let media = JSQPhotoMediaItem(image: image), let message = JSQMessage(senderId: senderIdentifier, displayName: displayName, media: media) {
            messages.append(message)
            finishSendingMessage()
        }
    }
    
    private func addMedia(imageUrl: String, callBack: @escaping (() -> ()) ) {
        guard let url = URL(string: imageUrl) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let data = data {
                DispatchQueue.main.async { [weak self] in
                    if let image = UIImage(data: data) {
                        self?.addImageMedia(image: image)
                        callBack()
                    }
                }
            } else {
                callBack()
            }
        }
        dataTask.resume()
    }
}


// MARK: Speech Manager delegate

extension ChatViewController: SpeechManagerDelegate {
    func didStartedListening(status:Bool) {
        if status {
            self.inputToolbar.contentView.textView.text = initialStatement
        }
    }
    
    func didReceiveText(text: String) {
        self.inputToolbar.contentView.textView.text = text
        if text != initialStatement {
            self.inputToolbar.contentView.rightBarButtonItem.isEnabled = true
        }
    }
}

