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
    case add, remove, none
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
        return #imageLiteral(resourceName: "walrobo")
    }
    func avatarHighlightedImage() -> UIImage! {
        return #imageLiteral(resourceName: "walrobo")
    }
    func avatarPlaceholderImage() -> UIImage! {
        return #imageLiteral(resourceName: "walrobo")
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
    private let initialMessage = "Hi Ashis. I am Wal-Robo. Welcome to SuperCart"
    
    var messages = [JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    weak var delegate: ChatDelegate?
    private var micButton: UIButton!
    private var tapped = false {
        didSet {
            tapped ? micButton?.setTitle("Stop", for: .normal): micButton?.setTitle("Speech", for: .normal)
            if tapped {
                SpeechManager.shared.startRecording()
            } else {
                SpeechManager.shared.stopRecording()
                self.inputToolbar.contentView.textView.text = ""
            }
        }
    }
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ask WalRobo"
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
            case "input.welcome": strongSelf.handleItem(response: response, operation: .none)
            case "input.add": strongSelf.handleItem(response: response, operation: .add)
            case "input.delete": strongSelf.handleItem(response: response, operation: .remove)
            case "input.showList": strongSelf.handleShowWishList()
            case "input.search": strongSelf.searchShoppingList()
            case "input.recipe": strongSelf.handleRecipe(response: response)
            case "input.smartSuggestion": strongSelf.handleItem(response: response, operation: .none)
            default: break
            }
            
            }, failure: { (request, error) in
                print(error?.localizedDescription ?? "some fetching error at dialogflow")
        })
        ApiAI.shared().enqueue(request)
    }
    
    
    private func handleItem(response: AIResponse, operation: Operation) {
        
        guard let messages = response.result.fulfillment.messages as? [[String: Any]], !messages.isEmpty,
            let dict = messages.first, let speech = dict["speech"] as? String else { return }
        
        // add message
        if operation == .none {
            addMessage(withId: senderId, name: senderDisplayName, text: speech)

        } else if speech == "" {
            switch operation {
            case .add, .remove:
                addMessage(withId: senderId, name: senderDisplayName, text: "The item is unavailable currently.")
            case .none: break
            }
        } else {
            
            addMessage(withId: senderId, name: senderDisplayName, text: speech)
            
            let texts = speech.components(separatedBy: "#")
            guard texts.count > 1, let lastText = texts.last else { return }
            
            // handle shopping list along with image
            let productSpecifications = lastText.components(separatedBy: ",")
            if productSpecifications.count > 1 {
                
                let category = productSpecifications[0].replacingOccurrences(of: ".", with: "")
                let subCategory = productSpecifications[1].replacingOccurrences(of: ".", with: "")
                
                guard let productCategory = ProductCategory(rawValue: category) else { return }
                
                addImageMedia(image: productCategory.image())
                
                switch operation {
                case .add:
                    if !checkItemPresentInList(category: productCategory, subCategory: subCategory) {
                        let basicProduct = BasicProduct(title: subCategory, category: category, subCategory: subCategory)
                        AppManager.shared.shoppingList[productCategory]?.append(basicProduct)
                    }
                    
                case .remove:
                    if let basicProducts = AppManager.shared.shoppingList[productCategory] {
                        let basicProduct = BasicProduct(title: subCategory, category: category, subCategory: subCategory)
                        let tempBasicProducts = basicProducts.filter { $0 != basicProduct }
                        AppManager.shared.shoppingList[productCategory] = tempBasicProducts
                    }
                    
                case .none: break
                }
            }
        }
    }
    
    private func handleShowWishList() {
        guard !AppManager.shared.shoppingList.isEmpty else {
            addMessage(withId: senderIdentifier, name: senderDisplayName, text: "Your shopping list is empty. Please add item to list.")
            return
        }
        var shoppingListEmpty = true
        for (_, list) in AppManager.shared.shoppingList {
            for each in list {
                shoppingListEmpty = false
                addMessage(withId: senderIdentifier, name: senderDisplayName, text: each.title)
            }
        }
        if shoppingListEmpty {
            addMessage(withId: senderIdentifier, name: senderDisplayName, text: "Your shopping list is empty. Please add item to list.")
        }
    }
    
    // MARK:- Recipe
    private func handleRecipe(response: AIResponse) {
        guard let messages = response.result.fulfillment.messages as? [[String: Any]], !messages.isEmpty,
            let dict = messages.first,
            let speech = dict["speech"] as? String else { return }
        
        if let data = speech.data(using: .utf8),
            let arrayDict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: String]],
            let arrDict = arrayDict {
            
            var resultText = "added "
            arrDict.forEach {
                
                let category = $0["category"] ?? ""
                let subCategory = $0["subcategory"] ?? ""
                
                if let productCategory = ProductCategory(rawValue: category),
                    !checkItemPresentInList(category: productCategory, subCategory: subCategory) {
                    
                    let basicProduct = BasicProduct(title: subCategory, category: category, subCategory: subCategory)
                    AppManager.shared.shoppingList[productCategory]?.append(basicProduct)
                }
                resultText += subCategory + ", "
            }
            addMessage(withId: senderIdentifier, name: senderDisplayName, text: resultText)
        } else {
             addMessage(withId: senderIdentifier, name: senderDisplayName, text: speech)
        }
    }
    
    private func checkItemPresentInList(category: ProductCategory, subCategory: String) -> Bool {
        let categoryEmpty = AppManager.shared.shoppingList[category]?.isEmpty ?? false
        if categoryEmpty {
            return false
        } else {
            // category have some data, check the subcategory of each data
            if let addedProducts = AppManager.shared.shoppingList[category] {
                for each in addedProducts {
                    if each.subCategory == subCategory {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
            finishSendingMessage()
            if id == senderId {
                SpeechManager.shared.speak(text: text)
            }
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
    
    private func searchShoppingList() {
        let productListController = ProductListViewController()
        productListController.productListParams = AppManager.shared.getProductListForSearchAPI()
        navigationController?.pushViewController(productListController, animated: true)
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

