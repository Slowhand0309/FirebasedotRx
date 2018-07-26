//
//  FirebaseAuth+Rx.swift
//  FirebasedotRx
//
//  Created by Slowhand0309 on 2018/07/26.
//  Copyright (c) 2018 Slowhand0309. All rights reserved.

import RxSwift
import FirebaseAuth

// MARK: - user methods.
public extension Reactive where Base: Auth {

    func updateCurrentUser(user: User) -> Single<Void> {
        return Single.create { [weak base] single in
            if let base = base {
                base.updateCurrentUser(user) { error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(()))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }

    func getTokenId(forceRefresh: Bool = false) -> Single<String?> {
        return Single.create { [weak base] single in
            if let user = base?.currentUser {
                user.getIDTokenForcingRefresh(forceRefresh) { (token, error) in
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

    func createUserWithEmail(email: String, password: String) -> Single<User?> {
        return Single.create { [weak base] single in
            if let base = base {
                base.createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(result?.user))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }
}

// MARK: - signin methods.
public extension Reactive where Base: Auth {

    func signInWithEmail(email: String, password: String) -> Single<User?> {
        return Single.create { [weak base] single in
            if let base = base {
                base.signIn(withEmail: email, password: password) { result, error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(result?.user))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }

    func signInWithEmailLink(email: String, link: String) -> Single<User?> {
        return Single.create { [weak base] single in
            if let base = base {
                base.signIn(withEmail: email, link: link) { result, error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(result?.user))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }

    func signInWithCredentials(credentials: AuthCredential) -> Single<User?> {
        return Single.create { [weak base] single in
            if let base = base {
                base.signInAndRetrieveData(with: credentials) { result, error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(result?.user))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }

    func signInAnonymously() -> Single<User?> {
        return Single.create { [weak base] single in
            if let base = base {
                base.signInAnonymously() { result, error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(result?.user))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }

    func signInWithCustomToken(token: String) -> Single<User?> {
        return Single.create { [weak base] single in
            if let base = base {
                base.signIn(withCustomToken: token) { result, error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(result?.user))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }
}

// MARK: - confirm methods.
public extension Reactive where Base: Auth {

    func sendPasswordReset(email: String) -> Single<Void> {
        return Single.create { [weak base] single in
            if let base = base {
                base.sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(()))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }

    func verifyPasswordResetCode(code: String) -> Single<String?> {
        return Single.create { [weak base] single in
            if let base = base {
                base.verifyPasswordResetCode(code) { result, error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(result))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }

    func confirmPasswordReset(code: String, newPassword: String) -> Single<Void> {
        return Single.create { [weak base] single in
            if let base = base {
                base.confirmPasswordReset(withCode: code, newPassword: newPassword) { error in
                    if let error = error {
                        single(.error(error))
                    } else {
                        single(.success(()))
                    }
                }
            } else {
                single(.error(FirebaseError.nilValue))
            }
            return Disposables.create()
        }
    }
}

// MARK: - state change listener.
public extension Reactive where Base: Auth {

    var stateDidChangeListener: Observable<(Auth, User?)> {
        get {
            return Observable.create { [weak base] observer in
                if let base = base {
                    let listener = base.addStateDidChangeListener({ (auth, user) in
                        observer.onNext((auth, user))
                    })
                    return Disposables.create() {
                        base.removeStateDidChangeListener(listener)
                    }
                } else {
                    observer.onError(FirebaseError.nilValue)
                    return Disposables.create()
                }
            }
        }
    }

    var idTokenDidChangeListener: Observable<(Auth, User?)> {
        get {
            return Observable.create { [weak base] observer in
                if let base = base {
                    let listener = base.addIDTokenDidChangeListener({ (auth, user) in
                        observer.onNext((auth, user))
                    })
                    return Disposables.create {
                        base.removeIDTokenDidChangeListener(listener)
                    }
                } else {
                    observer.onError(FirebaseError.nilValue)
                    return Disposables.create()
                }
            }
        }
    }
}
