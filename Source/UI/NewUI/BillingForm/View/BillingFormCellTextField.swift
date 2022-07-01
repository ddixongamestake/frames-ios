import UIKit
import Checkout

protocol CellTextFieldDelegate: AnyObject {
    func phoneNumberIsUpdated(number: String, tag: Int)
    func textFieldShouldBeginEditing(textField: UITextField)
    func textFieldShouldReturn() -> Bool
    func textFieldShouldEndEditing(textField: UITextField, replacementString: String) -> Bool
    func textFieldShouldChangeCharactersIn(textField: UITextField, replacementString string: String)
}

final class BillingFormCellTextField: UITableViewCell {
    weak var delegate: CellTextFieldDelegate?
    var type: BillingFormCell?
    var style: CellTextFieldStyle?

    private lazy var textFieldView: BillingFormTextFieldView? = {
        let view = BillingFormTextFieldView().disabledAutoresizingIntoConstraints()
        view.delegate = self
        view.phoneNumberDelegate = self
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewsInOrder()
        backgroundColor = .clear
    }

    func update(type: BillingFormCell?, style: CellTextFieldStyle?, tag: Int, textFieldValue: String?) {
        self.type = type
        self.style = style
        self.tag = tag
        textFieldView?.update(style: style, type: type, textFieldValue: textFieldValue, tag: tag)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BillingFormCellTextField {

    private func setupViewsInOrder() {
        guard let textFieldView = textFieldView else { return }
        contentView.addSubview(textFieldView)
        textFieldView.setContentHuggingPriority(.defaultLow, for: .vertical)
        textFieldView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Padding.l.rawValue),
            textFieldView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            textFieldView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            textFieldView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.Padding.xl.rawValue)
        ])
    }
}

extension BillingFormCellTextField: TextFieldViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return true }
    
    func textFieldShouldChangeCharactersIn(textField: UITextField, replacementString string: String) {
        delegate?.textFieldShouldChangeCharactersIn(textField: textField, replacementString: string)
    }

    func textFieldShouldBeginEditing(textField: UITextField) {
        delegate?.textFieldShouldBeginEditing(textField: textField)
    }
    func textFieldShouldReturn()-> Bool {
        delegate?.textFieldShouldReturn() ?? false
    }

    func textFieldShouldEndEditing(textField: UITextField, replacementString: String) -> Bool {
        delegate?.textFieldShouldEndEditing(textField: textField, replacementString: replacementString) ?? true
    }

}

extension BillingFormCellTextField: PhoneNumberTextFieldDelegate {
    func phoneNumberIsUpdated(number: String, tag: Int) {
        delegate?.phoneNumberIsUpdated(number: number, tag: tag)
    }
}
