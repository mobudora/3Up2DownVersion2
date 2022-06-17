//
//  ChatInputAccessoryView.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit

//情報を違うファイルに渡すためにDelegateを使用。1.プロトコルをまず作ってあげる
protocol ChatInputAccessoryViewDelegate: class {
    //送ってあげたい情報
    func tappedSendButton(text: String)
}

class ChatInputAccessoryView: UIView {
    
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func tappedSendButton(_ sender: Any) {
        //テキストがnilの時のためにguardlet
        guard let text = chatTextView.text else { return }
        //受け取ったテキストを渡す
        delgate?.tappedSendButton(text: text)
    }
    //2.プロトコルのdelegateを作る
    weak var delgate: ChatInputAccessoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nibInit()
        setUpView()
        autoresizingMask = .flexibleHeight
    }
    
    private func setUpView() {
        chatTextView.layer.cornerRadius = 15
        chatTextView.layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230, alpha: 1).cgColor
        chatTextView.layer.borderWidth = 1
        
        sendButton.layer.cornerRadius = 15
        sendButton.imageView?.contentMode = .scaleAspectFill
        sendButton.contentHorizontalAlignment = .fill
        sendButton.contentVerticalAlignment = .fill
        sendButton.isEnabled = false
        
        chatTextView.text = ""
        chatTextView.delegate = self
    }
    
    func removeText() {
        chatTextView.text = ""
        sendButton.isEnabled = false
    }
    //メッセージを打つところを可変にする
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    //ChatInputAccessoryView.xibファイルをセットアップする
    private func nibInit() {
        let nib = UINib(nibName: "ChatInputAccessory", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension ChatInputAccessoryView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("textView.text:", textView.text)
        if textView.text.isEmpty {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }
}
