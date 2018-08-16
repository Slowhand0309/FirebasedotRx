//
//  Firestore+Rx.swift
//  FirebasedotRx
//
//  Created by Slowhand0309 on 2018/07/30.
//  Copyright (c) 2018 Slowhand0309. All rights reserved.

import RxSwift
import FirebaseFirestore
import CodableFirebase

// MARK: - DocumentReference methods.
extension Reactive where Base: DocumentReference {

    /// Fetch document data.
    ///
    /// e.g.
    ///     Firestore.firestore()
    ///         .collection("users")
    ///         .document("xxxx")
    ///         .rx.documents(type: Model.self)
    ///
    func fetch<T: Codable>(type: T.Type) -> Observable<(String, T?)> {
        return Observable.create { [weak base] observer in
            base?.getDocument { (document, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    if let document = document, let data = document.data() {
                        do {
                            let model = try FirestoreDecoder().decode(type, from: data)
                            observer.onNext((document.documentID, model))
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                    } else {
                        observer.onError(FirebaseError.nilValue)
                    }
                }
            }
            return Disposables.create()
        }
    }

    func insert<T: Codable>(model: T) -> Observable<String?> {
        return Observable.create { [weak base] observer in
            do {
                let data = try FirestoreEncoder().encode(model)
                base?.setData(data) { error in
                    if let error = error {
                        observer.onError(error)
                    } else {
                        observer.onNext(base?.documentID)
                        observer.onCompleted()
                    }
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func update<T: Codable>(model: T) -> Observable<String?> {
        return Observable.create { [weak base] observer in
            do {
                let data = try FirestoreEncoder().encode(model)
                base?.updateData(data) { error in
                    if let error = error {
                        observer.onError(error)
                    } else {
                        observer.onNext(base?.documentID)
                        observer.onCompleted()
                    }
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func delete() -> Observable<String?> {
        return Observable.create { [weak base] observer in
            base?.delete { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(base?.documentID)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - Query methods.
extension Reactive where Base: Query {

    func documents<T: Codable>(type: T.Type) -> Observable<T?> {
        return Observable.create { [weak base] observer in
            base?.getDocuments { (querySnapshot, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    let query = querySnapshot?.documents
                                    .map { $0.data() }
                    query?.forEach { value in
                        do {
                            let model = try FirestoreDecoder().decode(type, from: value)
                            observer.onNext(model)
                        } catch _ {
                            observer.onNext(nil)
                        }
                    }
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}

