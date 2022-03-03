//
//  TextField+Publisher.swift
//  WriteX
//
//  Created by Ahmed Fathy on 03/03/2022.
//

import Combine
import UIKit


extension UITextField {
    
    func creatTextFieldBinding(with subject: CurrentValueSubject<String, Never> , storeIn subscripations: inout Set<AnyCancellable>){
         
         subject.sink { [weak self] value in
             if value != self?.text {
                 self?.text = value
             }
         }.store(in: &subscripations)
         
         
         self.textPublisher.sink { value in
             if value != subject.value {
                 subject.send(value!)
             }
         }.store(in: &subscripations)
         
         
     }
    
    func shakeField(){
        let animatoin  = CAKeyframeAnimation(keyPath: "position.x")
        animatoin.values = [0,10,-10,10,0]
        animatoin.keyTimes = [0,0.08,0.25,0.415,0.5]
        animatoin.duration = 0.5
        animatoin.fillMode = .forwards
        animatoin.isRemovedOnCompletion = false
        animatoin.isAdditive = true
        layer.add(animatoin, forKey: nil)
    }
    
    
}
