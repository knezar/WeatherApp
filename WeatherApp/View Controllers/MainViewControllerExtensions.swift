//
//  MainViewControllerExtensions.swift
//  WeatherApp
//
//  Created by C4Q on 5/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
import UIKit
// MARK:- CollectionView - Data Source

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  weathers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MyCellCollectionViewCell
        let weather = weathers[indexPath.row]
        cell.iconImageView.image = UIImage.init(named: weather.icon)
        cell.dateLabel.text = Models().getDateFormatted(from: weather.sunriseISO, format: "MMM dd")
        cell.highLabel.text = "High: \(weather.maxTempF) \u{00B0}F"
        cell.lowLabel.text = "Low: \(weather.minTempF) \u{00B0}F"
        return cell
    }
}

//MARK:- CollectionView - Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchTextField.resignFirstResponder()
        let forecastDVC = WeatherDetailedViewController()
        forecastDVC.weather = weathers[indexPath.row]
        self.navigationController?.pushViewController(forecastDVC, animated: true)
    }
}

// MARK:- CollectionView - Flow Layout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        return CGSize(width: (screenWidth * 0.5), height: (screenHeight * 0.4))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
// MARK:- TextField - Delegate
extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        moveTextField(textField: textField, moveDistance: -150, up: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        guard let textFieldvar = textField.text else {
            return  textField.becomeFirstResponder()
        }
        if textFieldvar.count == 5 {
            ClientAPI.manager.getWeather(from: textFieldvar, completionHandler: {self.weathers = $0}, errorHandler: { (error) in
                let message = error.localizedDescription
                let avc = UIAlertController(title: "Invalid ZipCode", message: message, preferredStyle: .alert)
                avc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(avc, animated: true, completion: nil)
                textField.text = nil
                self.cityNameLabel.text = ""
                self.weathers = []
            })
            CityNameHelper.manager.getLocationName(from: textFieldvar, completionHandler: {self.cityName = $0.0}, errorHandler: {print($0)})
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDistance: -150, up: false)
    }
    func moveTextField (textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animate TextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
