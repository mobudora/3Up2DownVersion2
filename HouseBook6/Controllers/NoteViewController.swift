//
//  NoteViewController.swift
//  HouseBook
//
//  Created by Dora on 2022/03/26.
//

import UIKit
import Firebase
import Nuke
import GoogleMobileAds

class NoteViewController: UIViewController {

    var bannerView: GADBannerView!
    
    //
    private var chatrooms = [ChatRoom]()
    //
    private var chatroomListener: ListenerRegistration?
    
    private var user: User? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    @IBOutlet weak var noteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        noteTableView.tableFooterView = UIView()
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLoginUserInfo()
        getChatRoomInfoFromFirestore()
    }

    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    
    private func getChatRoomInfoFromFirestore() {
        
        //????????????????????????????????????????????????????????????
        chatroomListener?.remove()
        //?????????????????????????????????????????????
        chatrooms.removeAll()
        noteTableView.reloadData()
        
        //????????????????????????Firestore???chatRoom????????????????????????
        chatroomListener = Firestore.firestore().collection("chatRoom")
            .addSnapshotListener { (snapshots, err) in
                if let err = err {
                    print("ChatRoom??????????????????????????????????????????\(err)")
                    return
                }
                
                snapshots?.documentChanges.forEach({ (documentChange) in
                    switch documentChange.type {
                        //.added==???????????????????????????
                    case .added:
                        self.handleAddedDocumentChange(documentChange: documentChange)
                    case .modified,.removed:
                        print("nothing to do")
                    }
                })
            }
    }
    private func handleAddedDocumentChange(documentChange: DocumentChange) {
        let dic = documentChange.document.data()
        let chatroom = ChatRoom(dic: dic)
        //Firestore???????????????????????????????????????documentID???chatRoom???????????????????????????
        chatroom.documentId = documentChange.document.documentID

        guard let uid = Auth.auth().currentUser?.uid else { return }
        //?????????uid????????????????????????????????????????????????????????????????????????
        let isContain = chatroom.members.contains(uid)
        //?????????????????????????????????cell????????????????????????????????????
        if !isContain { return }
        
        //???????????????uid????????????????????????????????????????????????????????????
        chatroom.members.forEach { (memberRandomUid) in
            if memberRandomUid != uid {
                Firestore.firestore().collection("chatFriends\(uid)").document(memberRandomUid).getDocument { (userSnapshot, err) in
                    if let err = err {
                        print("???????????????????????????????????????????????????\(err)")
                        return
                    }
                    
                    guard let dic = userSnapshot?.data() else { return }
                    var user = User(dic: dic)
                    
                    chatroom.partnerUser = user
                    
                    user.uid = documentChange.document.documentID
                    
                    guard let chatroomId = chatroom.documentId else { return }
                    let latestMessageId = chatroom.latestMessageId
                    
                    if latestMessageId == "" {
                        self.chatrooms.append(chatroom)
                        print("self.chatrooms.count:", self.chatrooms.count)
                        self.noteTableView.reloadData()
                        print("dic:", dic)
                        return
                    }
                    
                    Firestore.firestore().collection("chatRoom").document(chatroomId).collection("messages").document(latestMessageId).getDocument { (messageSnapshot, err) in
                        if let err = err {
                            print("?????????????????????????????????????????????\(err)")
                            return
                        }
                        guard let dic = messageSnapshot?.data() else { return }
                        let message = Message(dic: dic)
                        chatroom.latestMessage = message
                        
                        self.chatrooms.append(chatroom)
                        print("self.chatrooms.count:", self.chatrooms.count)
                        self.noteTableView.reloadData()
                        print("dic:", dic)
                    }
                }
            }
        }
    }
    private func getLoginUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err ) in
            if let err = err {
                print("???????????????????????????????????????????????????\(err)")
                return
            }
            
            guard let snapshot = snapshot, let dic = snapshot.data()  else { return }
            
            let user = User(dic: dic)
            
            self.user = user
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension NoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTableView.dequeueReusableCell(withIdentifier: "NoteTableViewCustomCell", for: indexPath) as! NoteTableViewCell
        cell.chatroom = chatrooms[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "ChatRoom", bundle: nil)
        let chatRoomViewController = storyboard.instantiateViewController(withIdentifier: "ChatRoomViewController") as! ChatRoomViewController
        //ChatRoom.storyboard???Firestore???users??????????????????
        chatRoomViewController.user = user
        //ChatRoom.storyboard???Firestore???chatRoom??????????????????????????????????????????
        chatRoomViewController.chatroom = chatrooms[indexPath.row]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        navigationController?.pushViewController(chatRoomViewController, animated: true)
    }
}
class NoteTableViewCell: UITableViewCell {

    var chatroom: ChatRoom? {
        didSet {
            partnerNameLabel.text = chatroom?.partnerUser?.name
            guard let url = URL(string: chatroom?.partnerUser?.profileImageUrl ?? "") else { return }
            Nuke.loadImage(with: url, into: userImageView)
            dateLabel.text = dateFormatterForDateLabel(date: chatroom?.latestMessage?.createdAt.dateValue() ?? Date())
            latestMessageLabel.text = chatroom?.latestMessage?.message
            
        }
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var latestMessageLabel: UILabel!
    @IBOutlet weak var partnerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //???????????????????????????????????????????????????????????????
        userImageView.layer.cornerRadius = 25
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    private func dateFormatterForDateLabel(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
}

