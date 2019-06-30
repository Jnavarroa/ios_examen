import UIKit
import EzPopup

protocol popup : NSObjectProtocol {
    func loadNewScreen(controller: UIViewController) -> Void;
}

class customCell: UITableViewCell {

    @IBOutlet weak var txtFecha: UILabel!
    @IBOutlet weak var txtRating: UILabel!
    @IBOutlet weak var txtNombre: UILabel!
    @IBOutlet weak var imgPelicula: UIImageView!
    @IBOutlet weak var btnMasInfo: UIButton!
    var id = "", originalTitle = "", descripcion = ""
    var main = MainController()
    let data = CellPresenter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnMasInfo.backgroundColor = .clear
        btnMasInfo.layer.cornerRadius = 10
        btnMasInfo.layer.borderWidth = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func btnMasInfo(_ sender: Any) {
        data.saveInfoPeli(titulo: originalTitle, info: descripcion)
        let contentVC = DetallePeliculaController()
        let popupVC = PopupViewController(contentController: contentVC, popupWidth: data.getData(), popupHeight: 320)
        popupVC.backgroundAlpha = 0.3
        popupVC.backgroundColor = .black
        popupVC.canTapOutsideToDismiss = true
        popupVC.cornerRadius = 10
        popupVC.shadowEnabled = true
        main.present(popupVC, animated: true)
    }
}
