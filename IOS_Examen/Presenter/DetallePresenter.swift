import Foundation

class DetallePresenter{    
    let data = SaveAndGetData()

    func getInfoPeli() -> String{
        return  data.getInfoPeli()
    }
    
    func getTituloPeli() -> String{
        return  data.getTituloPeli()
    }
}
