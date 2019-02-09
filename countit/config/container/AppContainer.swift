//
//  AppContainer.swift
//  countit
//
//  Created by David Grew on 02/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class AppContainer {
    
    private let controllerResolver: ControllerResolver
    private let serviceResolver: ServiceResolver
    private let respositoryResolver: RepositoryResolver
    
    private let clock = Clock()
    private let calendar = Calendar.autoupdatingCurrent
    private let context: NSManagedObjectContext
    
    init(sqlDatabase: Bool) {
        context = CoreDataConfig.getCoreDataContext(isSQLDatabase: sqlDatabase)
        respositoryResolver = RepositoryResolver(context: context)
        serviceResolver = ServiceResolver(repositoryResolver: respositoryResolver, clock: clock, calendar: calendar)
        controllerResolver = ControllerResolver(serviceResolver: serviceResolver)
    }
    
    func getControllerResolver() -> ControllerResolver {
        return controllerResolver
    }
}
