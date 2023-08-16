//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 16/08/23.
//

import Foundation
import RxSwift

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    // Search List
    func list(request: Request?) -> Observable<[Response]>
    
    func saveToggle(entity: Response) -> Observable<Bool>
    
    func get(id: Int) -> Observable<Response?>
    
}




