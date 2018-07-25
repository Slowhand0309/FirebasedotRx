//
//  FirebaseError.swift
//  FirebasedotRx
//
//  Created by Slowhand0309 on 2018/07/26.
//  Copyright (c) 2018 Slowhand0309. All rights reserved.

import Foundation

enum FirebaseError: Error {

    /// Not found user.
    case userNotFound

    /// Not found reference
    case reference

    /// nil value
    case nilValue

    /// other
    case unknown
}
