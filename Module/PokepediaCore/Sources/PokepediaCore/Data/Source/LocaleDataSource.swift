//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 21/08/23.
//

import RxSwift

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> Observable<[Response]>
    func inserts(request: [Response]) -> Observable<Bool>
    
    func add(entity: Response) -> Observable<Bool>
    func get(id: Int) -> Observable<Response?>
    func update(id: Int, entity: Response) -> Observable<Bool>
}
