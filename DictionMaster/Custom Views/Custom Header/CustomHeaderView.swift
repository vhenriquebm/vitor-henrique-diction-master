//
//  CustomHeaderView.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class CustomHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var playSoundButton: UIButton!
    @IBOutlet weak var phoneticTextLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private var audioPlayer: AVPlayer?
    private var audioResult: String?
    
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
