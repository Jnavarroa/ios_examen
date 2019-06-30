import UIKit
import Alamofire
import SwiftyJSON

class MainController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var indicadorView: UIActivityIndicatorView!
    @IBOutlet weak var tvPeliculas: UITableView!
    @IBOutlet weak var pickFiltro: UIPickerView!
    fileprivate var peliculasMostrar = [PeliculasModel]()
    fileprivate let mainPresenter = MainPresenter(serviceL: GetConexion())
    var filtroPV = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvPeliculas?.dataSource = self
        tvPeliculas?.delegate = self
        mainPresenter.attachView(self)
        mainPresenter.getFiltro(filtro: "Popular")
        mainPresenter.getFiltroPV()
        pickFiltro.dataSource = self
        pickFiltro.delegate = self
        pickFiltro.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filtroPV.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filtroPV[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(filtroPV[row])
        mainPresenter.getFiltro(filtro: filtroPV[row])
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?{
        
        let attributedString = NSAttributedString(string: filtroPV[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        return attributedString
    }
    
    

}
extension MainController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peliculasMostrar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("customCell", owner: self, options: nil)?.first as? customCell
        let peli = peliculasMostrar[indexPath.row]
        cell?.main = self
        let fecha = mainPresenter.cambiarFecha(fecha: peli.release_date)
        cell?.txtFecha.text =  "Estreno: \(fecha)"
        cell?.txtNombre.text = peli.title
        cell?.txtRating.text = String(format:"%.1f", peli.vote_average)
        cell?.id = String(peli.id)
        cell?.originalTitle = peli.original_title
        cell?.descripcion = peli.overview
        let url = "https://image.tmdb.org/t/p/w500\(peli.poster_path)"
        mainPresenter.setImage(url: url, view: cell!.imgPelicula)
        return cell!
    }
}


extension MainController: UserView {
    
    func setFiltrosPickerView(_ filtro: [String]) {
        self.filtroPV = filtro
        self.pickFiltro.reloadAllComponents()
    }
    
    func startLoading() {
        indicadorView?.startAnimating()
        indicadorView?.isHidden = false
    }
    
    func finishLoading() {
        indicadorView?.stopAnimating()
        indicadorView?.isHidden = true
    }
    
    func setPeliculas(_ pelis: [PeliculasModel]) {
        peliculasMostrar = pelis
        tvPeliculas?.isHidden = false
        tvPeliculas?.reloadData()
    }
    
    func setVacio() {
        peliculasMostrar.removeAll()
        tvPeliculas?.reloadData()
        alertaM(alertText: "Alerta", alertMessage: "Datos no encontrados")
        let alertController = UIAlertController(title: "Alerta", message: "Datos no encontrados", preferredStyle: UIAlertController.Style.alert)
        let saveAction = UIAlertAction(title: "Reintentar", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.mainPresenter.getFiltro(filtro: "")
        })
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
