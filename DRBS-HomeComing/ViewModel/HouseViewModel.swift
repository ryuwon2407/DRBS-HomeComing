/*
 ################################################################
 #                        #                                     #
 #  ⭐️뷰모델이 모델을 소유⭐️   # ⭐️사용자와 상호작용하는 로직도 뷰모델이 소유⭐️ #
 #                        #                                     #
 ################################################################
 */
import CoreLocation
import UIKit

class HouseViewModel {
    //MARK: - Model
    var house: House?
    /* 뷰컨은 뷰모델이 소유한 데이터를 표기해야하기 때문에
       뷰모델은 뷰컨이 소유한 데이터와 관련있는 값도 가져야 함 */
    
    var name: String?
    var tradingType: String?
    var livingType: String?
    var address: CLLocationCoordinate2D?
    var 관리비미포함목록: [String] = []
    
    var rate: Float?
    
    //MARK: - Output
    
    
    
    //MARK: - Input


    
    
    
    //MARK: - Logics
    func blahblah() {
        
    }
    
    func calculateRates(value: Float) -> Float {
        switch value {
        case _ where value > 0.0 && value < 0.5:
            return 0
        case _ where value > 0.5 && value < 1.0:
            return 0.5
        case _ where value > 1.0 && value < 1.5:
            return 1.0
        case _ where value > 1.5 && value < 2.0:
            return 1.5
        case _ where value > 2.0 && value < 2.5:
            return 2.0
        case _ where value > 2.5 && value < 3.0:
            return 2.5
        case _ where value > 3.0 && value < 3.5:
            return 3.0
        case _ where value > 3.5 && value < 4.0:
            return 3.5
        case _ where value > 4.0 && value < 4.5:
            return 4.0
        case _ where value > 4.5 && value < 5.0:
            return 4.5
        case 5.0:
            return 5.0
        default:
            return 0.0
        }
    }

}
