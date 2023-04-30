import Foundation
import XCoordinator


struct RouteTrigger<RouteType: Route> {
    let trigger: (RouteType) -> ()
    
    static var empty: RouteTrigger<RouteType> {
        return RouteTrigger(trigger: { _ in })
    }
}

extension RouteTrigger {
    init(unownedRouter: UnownedRouter<RouteType>) {
        self.init { router in
            unownedRouter.trigger(router)
        }
    }
}

