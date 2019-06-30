import Foundation
import UIKit

class MainPresenter {
    
    fileprivate let service:GetConexion
    weak fileprivate var userView : UserView?
    private var peliculas = [PeliculasModel]()
    
    init(serviceL:GetConexion){
        self.service = serviceL
    }
    
    func setImage(url: String, view: UIImageView){
        service.getImage(url: url, view: view)
    }
    
    func attachView(_ view:UserView){
        userView = view
    }
    
    func detachView() {
        userView = nil
    }
    
    func getFiltroPV(){
        self.userView?.setFiltrosPickerView(service.getFiltro())
    }
    
    func getFiltro(filtro:String){
        self.userView?.startLoading()
        service.getPeliculas(urlL: filtro, { [weak self] pelis in
            self?.userView?.finishLoading()
            if(pelis.count == 0){
                self?.userView?.setVacio()
            }else{
                self?.peliculas = pelis
                self?.userView?.setPeliculas(pelis)
            }
        })
    }
    
    func cambiarFecha(fecha: String) -> String{
        let fechaArray = fecha.components(separatedBy: "-")
        let dia = fechaArray[2]
        let mes = fechaArray[1]
        let ano = fechaArray[0]
        return "\(dia)-\(mes)-\(ano)"
    }
}
protocol UserView: NSObjectProtocol {
    func startLoading()
    func setFiltrosPickerView(_ filtro: [String])
    func finishLoading()
    func setVacio()
    func setPeliculas(_ pelis: [PeliculasModel])
    
}
