//
//  FirebaseAuth+Rx.swift
//  FirebasedotRx
//
//  Created by Slowhand0309 on 2018/07/26.
//  Copyright (c) 2018 Slowhand0309. All rights reserved.

import RxSwift
import FirebaseAuth

public extension Reactive where Base: Auth {

    func getTokenId() -> Single<String?> {
        return Single.create { [weak base] single in
            if let user = base?.currentUser {
                user.getIDTokenForcingRefresh(true) { (token, error) in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(token))
                    }
                }
            } else {
                single(.error(FirebaseError.userNotFound))
            }
            return Disposables.create()
        }
    }
}
