//
//  Quest.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-02.
//

import SwiftUI

struct Quest: Identifiable {
    let id = UUID()
    let role: String
    var isPlayer: Bool = false
    let phases: [String] = ["Team Building Phase", "Quest Phase"]
    
    var description: String {
        switch role {
        case "Servant":
            return "You are loyal to Arthur. Try to help the good team succeed in missions. You don’t know who anyone is."
        case "Assassin":
            return "You are evil. Work with fellow evil players to fail missions. At the end, try to identify and kill Merlin."
        case "Merlin":
            return "You are good. You know who the evil players are. Help the good team without revealing yourself."
        case "Percival":
            return "You are good. You are told who might be Merlin. Protect Merlin by keeping their identity secret."
        case "Morcana":
            return "You are evil. You appear as Merlin to Percival. Deceive the good team and help evil fail missions."
        default:
            return "Unknown role. Follow the game master's instructions."
        }
    }
    
    var isEvil: Bool {
        switch role {
        case "Servant":
            return false
        case "Assassin":
            return true
        case "Merlin":
            return false
        case "Percival":
            return false
        case "Morcana":
            return true
        default:
            return false
        }
    }
    
    func generateMissionChoice() -> Bool {
        // generateMissionChoice from AI
        return true
    }
    
    func generateMessage() -> Bool {
        // generateMissionChoice from AI
        return true
    }
}


