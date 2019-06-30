import Foundation
import UIKit

class CellPresenter{
    let data = SaveAndGetData()
    
    func getData() -> CGFloat{
        return data.getData()
    }
    
    func saveInfoPeli(titulo: String, info: String){
        data.saveInfoPeli(titulo: titulo, info: info)
    }
}
