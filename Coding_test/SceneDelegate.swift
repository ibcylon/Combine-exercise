//
//  SceneDelegate.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import UIKit

import PresentationLayer
import DomainLayer
import DataLayer

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    window.windowScene = windowScene
    self.window = window
    
    let appRoot = AppCompositeRoot()
    appRoot.launch(window: window)
  }
}
