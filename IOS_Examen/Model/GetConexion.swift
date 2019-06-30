import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class GetConexion{
    var filtro = [String]()
    
    func getFiltro() -> [String]{
        filtro.append("Popular")
        filtro.append("Top Rated")
        return filtro
    }
    
    func getPeliculas(urlL: String,_ callBack:@escaping ([PeliculasModel]) -> Void){
        var urlE = "https://api.themoviedb.org/3/movie/popular?api_key=34738023d27013e6d1b995443764da44"
        if(urlL == "Top Rated"){
            urlE = "https://api.themoviedb.org/3/movie/top_rated?api_key=34738023d27013e6d1b995443764da44"
        }
        var pelis = [PeliculasModel]()
        let encodedUrl = urlE.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedUrl)!
        let urlRequest = URLRequest(url: url)
        Alamofire.request(urlRequest)
            .responseJSON { response in
                let jsonAPI = JSON(response.data!)
                for (_,subAPI):(String, JSON) in jsonAPI {
                    let jsonPelis = subAPI
                    for(_, subJson):(String, JSON) in jsonPelis{
                        let titulo = subJson["title"].stringValue
                        if(titulo != ""){
                            let idL : Int32 = Int32(Int(subJson["id"].stringValue) ?? 0)
                            var videoL = false
                            if(subJson["video"].stringValue == "true"){
                                videoL = true
                            }
                            let voteL : Double = Double(subJson["vote_average"].stringValue)!
                            let voteCountL : Int32 = Int32(Int(subJson["vote_count"].stringValue) ?? 0)
                            let popuL : Double = Double(subJson["popularity"].stringValue)!
                            var adultL = false
                            if(subJson["adult"].stringValue == "true"){
                                adultL = true
                            }
                            var genreE = [Int]()
                            let genreL = subJson["genre_ids"]
                            for (_, ship) in genreL {
                                let val = Int(ship.stringValue)
                                genreE.append(val!)
                            }
                            let pelisL = PeliculasModel(id: idL,
                                                        video: videoL,
                                                        vote_average: voteL,
                                                        vote_count: voteCountL,
                                                        title: subJson["title"].stringValue,
                                                        popularity: popuL,
                                                        poster_path: subJson["poster_path"].stringValue,
                                                        original_language: subJson["original_language"].stringValue,
                                                        original_title: subJson["original_title"].stringValue,
                                                        genre_ids: genreE,
                                                        backdrop_path: subJson["backdrop_path"].stringValue,
                                                        adult: adultL,
                                                        overview: subJson["overview"].stringValue,
                                                        release_date: subJson["release_date"].stringValue)
                            pelis.append(pelisL)
                        }
                    }
                }
        }
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(pelis)
        }
    }
    
    func getImage(url:String, view: UIImageView){
        Alamofire.request(url).response { response in
            if let data = response.data {
                let image = UIImage(data: data)
                view.image = image
            } else {
                let image = UIImage(named: "")
                view.image = image
            }
        }
    }
}
extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}

extension UIViewController {
    func alertaM(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Entiendo", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
