import UIKit

class DetallePeliculaController: UIViewController {

    @IBOutlet weak var txtDescripcion: UITextView!
    @IBOutlet weak var txtNombre: UILabel!
    let detalle = DetallePresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNombre.text = detalle.getTituloPeli()
        txtDescripcion.text = detalle.getInfoPeli()
    }
}
