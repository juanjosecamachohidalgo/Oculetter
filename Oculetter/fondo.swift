//
//  fondo.swift
//  Oculetter
//
//  Created by Aula11 on 3/12/18.
//  Copyright © 2018 Universidad de Almeria. All rights reserved.
//

import Foundation
extension UIView{
    func addBackground() { // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "YOUR IMAGE NAME GOES HERE")
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground) }
}
