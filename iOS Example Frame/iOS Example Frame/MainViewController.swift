//
//  ViewController.swift
//  iOS Example Frame
//
//  Created by Floriel Fedry on 11/06/2018.
//  Copyright © 2018 Checkout. All rights reserved.
//

import UIKit
import FramesIos

class MainViewController: UIViewController, CardViewControllerDelegate {

    let checkoutAPIClient = CheckoutAPIClient(publicKey: "pk_test_03728582-062b-419c-91b5-63ac2a481e07",
                                              environment: .sandbox)
    var cardViewController: CardViewController {
        CheckoutTheme.primaryBackgroundColor = .blue
        CheckoutTheme.secondaryBackgroundColor = .purple
        CheckoutTheme.tertiaryBackgroundColor = .orange
        CheckoutTheme.errorColor = .yellow
        CheckoutTheme.color = .green
        return CardViewController(cardHolderNameState: .normal, billingDetailsState: .normal, defaultRegionCode: "UK")
    }

    @IBAction func onClickGoToPaymentPage(_ sender: Any) {
        navigationController?.pushViewController(cardViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cardViewController.delegate = self
        cardViewController.rightBarButtonItem = UIBarButtonItem(title: "Pay", style: .done, target: nil, action: nil)
        cardViewController.availableSchemes = [.visa, .mastercard, .maestro]
        cardViewController.setDefault(regionCode: "UK")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardViewController.addressViewController.setCountrySelected(country: "yo", regionCode: "yo")
    }

    func onTapDone(controller: CardViewController, card: CkoCardTokenRequest) {
        controller.navigationController?.popViewController(animated: true)
        let shippingDetails = CkoAddress(addressLine1: "yo", addressLine2: "yo", city: "yo", state: "yo", postcode: "yo", country: "yo")
        print(card.billingDetails)
        var cardWithShipping = card.createWith(shippingDetails: shippingDetails)
        checkoutAPIClient.createCardToken(card: card, successHandler: { cardToken in
            self.showAlert(with: cardToken.id)
        }, errorHandler: { error in
            print(error)
        })
    }

    private func showAlert(with cardToken: String) {
        let alert = UIAlertController(title: "Payment",
                                      message: cardToken, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
