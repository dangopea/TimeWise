//
//  Note.swift
//  TimeWise
//
//  Created by Dhriti on 06/06/2566 BE.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct Note: Codable {
    @DocumentID var id: String? // @DocumentID to fetch the identifier from Firestore
    var title: String?
}
