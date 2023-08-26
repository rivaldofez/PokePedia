//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 21/08/23.
//

import RxSwift

public protocol RemoteDataSource {
    associatedtype Request
    associatedtype Response
    
    func get(request: Request?) -> Observable<Response>
}
