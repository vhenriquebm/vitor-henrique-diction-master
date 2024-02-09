//
//  HeaderView.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 09/02/24.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class HeaderView: UIView {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var playSoundButton: UIButton!
    @IBOutlet weak var phoneticTextLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private var audioPlayer: AVPlayer?
    private var audioResult: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: HeaderView.self)
        if let viewToadd = bundle.loadNibNamed("HeaderView", owner: self), let contentView = viewToadd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("NIB file not found or invalid")
        }
        
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
        configureBindings()
    }
    
    private func configureViews() {
        playSoundButton.heightAnchor.constraint(equalTo: playSoundButton.widthAnchor).isActive = true
        playSoundButton.layer.cornerRadius = playSoundButton.frame.size.width / 2
        playSoundButton.layer.masksToBounds = true
        
        wordLabel.font = UIFont.sf_pro_rounded_bold(size: 45)
        phoneticTextLabel.font = UIFont.sf_pro_rounded_bold(size: 22)
    }
    
    private func configureBindings() {
        playSoundButton.rx
            .tap
            .subscribe(onNext: playSound)
            .disposed(by: disposeBag)
    }
    
    private func playSound() {
        guard let audioURLString = audioResult,
              let audioURL = URL(string: audioURLString) else {
            return
        }
        
        let playerItem = AVPlayerItem(url: audioURL)
        
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.rate = 1.0
        audioPlayer?.play()
    }
    
    func configure(_ result:SearchWordResponse?) {
        wordLabel.text = result?.word?.capitalizedFirstLetter()
        phoneticTextLabel.text = result?.phonetic
        
        let phonetics = result?.phonetics
        
        phonetics?.forEach { phonetic in
            if let audio = phonetic.audio, !audio.isEmpty {
                audioResult = audio
            }
        }
    }
}
