//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 21/08/23.
//

import RxSwift

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
