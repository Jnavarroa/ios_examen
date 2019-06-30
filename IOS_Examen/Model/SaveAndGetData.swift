import Foundation
import UIKit
class SaveAndGetData {
    
    private let datosUsuario = UserDefaults()
    
    func saveData(ancho: String){
        self.datosUsuario.set(ancho, forKey: "ancho")
        self.datosUsuario.synchronize()
    }
    
    func getData() -> CGFloat{
        var ancho : Double = Double(datosUsuario.string(forKey: "ancho")!)!
        ancho = ancho - 10
        return CGFloat(ancho)
    }
    
    func saveInfoPeli(titulo: String, info: String){
        self.datosUsuario.set(titulo, forKey: "titulo")
        self.datosUsuario.set(info, forKey: "info")
        self.datosUsuario.synchronize()
    }

    func getInfoPeli() -> String{
        return  datosUsuario.string(forKey: "info")!
    }
    
    func getTituloPeli() -> String{
        return datosUsuario.string(forKey: "titulo")!
    }
}
