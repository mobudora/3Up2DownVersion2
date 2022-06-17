//
//  partnerTableViewCell.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit
import Firebase
import Nuke

class partnerTableViewCell: UITableViewCell {

    var messageText: Message? {
        didSet {
//            if let message = messageText {
//                //messageText: Message?の中のmessage==message.messageを代入
//                partnerMessageTextView.text = message.message
//                let width = estimateFrameForTextView(text: message.message).width + 20
//                partnerMessageTextViewWidthConstraint.constant = width
//                partnerTimeLabel.text = dateFormatterForDateLabel(date: message.createdAt.dateValue())
////                partnerImageView
//            }
        }
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var partnerMessageTextView: UITextView!
    @IBOutlet weak var myMessageTextView: UITextView!
    @IBOutlet weak var partnerTimeLabel: UILabel!
    @IBOutlet weak var myTimeLabel: UILabel!
    @IBOutlet weak var partnerMessageTextViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var myMessageTextViewWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        userImageView.layer.cornerRadius = 22.5
        partnerMessageTextView.layer.cornerRadius = 15
        myMessageTextView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkWhicthUserMessage()
        // Configure the view for the selected state
    }
    private func checkWhicthUserMessage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //Message?の中のuidが自分のもの(Auth.auth().currentUser?.uid)か判断する
        if uid == messageText?.uid {
            partnerMessageTextView.isHidden = true
            partnerTimeLabel.isHidden = true
            userImageView.isHidden = true
            //自分のを表示
            myMessageTextView.isHidden = false
            myTimeLabel.isHidden = false
            
            if let messageBox = messageText {
                //messageText: Message?の中のmessage==message.message==messageText?.messageを代入
                myMessageTextView.text = messageBox.message
                let width = estimateFrameForTextView(text: messageBox.message).width + 20
                myMessageTextViewWidthConstraint.constant = width
                myTimeLabel.text = dateFormatterForDateLabel(date: messageBox.createdAt.dateValue())
            }
        } else {
            //相手のを表示
            partnerMessageTextView.isHidden = false
            partnerTimeLabel.isHidden = false
            userImageView.isHidden = false
            
            myMessageTextView.isHidden = true
            myTimeLabel.isHidden = true
            //画像を相手の画像に変える。partnerUserにchatRoom.storyboardでchatroomのpartnerUserの情報を与えている
            if let urlString = messageText?.partnerUser?.profileImageUrl, let url = URL(string: urlString) {
                Nuke.loadImage(with: url, into: userImageView)
            }
            
            
            if let messageBox = messageText {
                partnerMessageTextView.text = messageBox.message
                let width = estimateFrameForTextView(text: messageBox.message).width + 20
                partnerMessageTextViewWidthConstraint.constant = width
                partnerTimeLabel.text = dateFormatterForDateLabel(date: messageBox.createdAt.dateValue())
            }
        }
    }
    //テキストの長さによってサイズを可変にするテキストの長さを計算するメソッド
    private func estimateFrameForTextView(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], context: nil)
    }
    private func dateFormatterForDateLabel(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
}
