import XCTest
@testable import IOS_Examen

class IOS_ExamenTests: XCTestCase {

    func testGetConexion(){
        let conexion = GetConexionMock()
        let _ = conexion.getFiltro()
        let image = UIImage(named: "003-star")
        let imageView = UIImageView(image: image)
        conexion.getImage(url: "testURl", view: imageView)
        conexion.getPeliculas(urlL: "testURl", {_ in})
        XCTAssertTrue(conexion.verificar())
    }
    
    func testSaveDataMock(){
        let saveData = SaveDataMock()
        let _ = saveData.getData()
        let _ = saveData.getInfoPeli()
        let _ = saveData.getTituloPeli()
        saveData.saveInfoPeli(titulo: "Test", info: "Test")
        saveData.saveData(ancho: "200")
        XCTAssertTrue(saveData.verificar())
    }

}
class GetConexionMock: GetConexion {
    var pedirImagen = false
    var pedirFiltro = false
    var pedirPeliculas = false
    
    override func getImage(url: String, view: UIImageView) {
        pedirImagen = true
    }
    
    override func getFiltro() -> [String] {
        pedirFiltro = true
        return [""]
    }
    
    override func getPeliculas(urlL: String, _ callBack: @escaping ([PeliculasModel]) -> Void) {
        pedirPeliculas = true
    }
    func verificar() -> Bool{
        if(pedirImagen && pedirFiltro && pedirPeliculas){
            return true
        }else{
            return false
        }
    }
}

class SaveDataMock: SaveAndGetData {
    var getDataBool = false
    var getInfoPeliBool = false
    var getTituloPeliBool = false
    var saveDataBool = false
    var saveInfoPeliBool = false
    
    override func getData() -> CGFloat {
        getDataBool = true
        return CGFloat(1)
    }
    
    override func getInfoPeli() -> String {
        getInfoPeliBool = true
        return ""
    }
    
    override func getTituloPeli() -> String {
        getTituloPeliBool = true
        return ""
    }
    override func saveData(ancho: String) {
        saveDataBool = true
    }
    override func saveInfoPeli(titulo: String, info: String) {
        saveInfoPeliBool = true
    }
    func verificar() -> Bool{
        if(getDataBool && getInfoPeliBool && getTituloPeliBool && saveDataBool && saveInfoPeliBool ){
            return true
        }else{
            return false
        }
    }
}
