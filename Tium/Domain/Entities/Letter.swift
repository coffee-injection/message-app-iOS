//
//  Letter.swift
//  Tium
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

struct Letter: Identifiable {
    let id: String
    let content: String
    let status: LetterStatus
    let sender: String
    let receiver: String?
    let matchedAt: Date?
    let readAt: Date?
    let createdAt: Date
    
    var canBeRead: Bool {
        return status == .delivered
    }
    
    var canBeBookmarked: Bool {
        return status == .read
    }
    
    var isRead: Bool {
        return status == .read
    }
    
    init(
        id: String = UUID().uuidString,
        content: String,
        status: LetterStatus = .waiting,
        sender: String,
        receiver: String? = nil,
        matchedAt: Date? = nil,
        readAt: Date? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.content = content
        self.status = status
        self.sender = sender
        self.receiver = receiver
        self.matchedAt = matchedAt
        self.readAt = readAt
        self.createdAt = createdAt
    }
}

enum LetterStatus: String, CaseIterable {
    case waiting = "WAITING"
    case delivered = "DELIVERED"
    case read = "READ"
}

extension Letter {
    static let sampleLetters: [Letter] = [
        Letter(
            id: "1",
            content: "The sea whispers secrets from distant lands...",
            status: .read,
            sender: "OceanDreamer",
            receiver: "Ethan",
            matchedAt: Date().addingTimeInterval(-86400),
            readAt: Date().addingTimeInterval(-3600),
            createdAt: Date().addingTimeInterval(-172800)
        ),
        Letter(
            id: "2", 
            content: "Under the vast night sky, we are but tiny specks of light...",
            status: .read,
            sender: "Stargazer",
            receiver: "Ethan",
            matchedAt: Date().addingTimeInterval(-72000),
            readAt: Date().addingTimeInterval(-1800),
            createdAt: Date().addingTimeInterval(-144000)
        ),
        Letter(
            id: "3",
            content: "The sand remembers every footprint, every story told by the sea...",
            status: .delivered,
            sender: "BeachWalker",
            receiver: "Ethan",
            matchedAt: Date().addingTimeInterval(-3600),
            readAt: nil,
            createdAt: Date().addingTimeInterval(-72000)
        ),
        Letter(
            id: "4",
            content: "The wind carries messages from places we've never been...",
            status: .read,
            sender: "WindWhisperer",
            receiver: "Ethan",
            matchedAt: Date().addingTimeInterval(-18000),
            readAt: Date().addingTimeInterval(-900),
            createdAt: Date().addingTimeInterval(-108000)
        ),
        Letter(
            id: "5",
            content: "Somewhere in the ocean, a bottle carries dreams to unknown shores...",
            status: .read,
            sender: "BottleDreamer",
            receiver: "Ethan",
            matchedAt: Date().addingTimeInterval(-9000),
            readAt: Date().addingTimeInterval(-450),
            createdAt: Date().addingTimeInterval(-54000)
        )
    ]
}
