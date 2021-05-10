//
//  SocketManagerDelegate.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/10.
//

import Foundation

protocol SocketManagerDelegate: AnyObject {
    func didconnect()
    func didReceive(with data: Any)
}
