//
//  RegistrationViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 20.12.2023.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var topBarContainer: UIView!
    
    @IBOutlet weak var surnameInputBoxContainer: UIView!
    @IBOutlet weak var firstNameInputBoxContainer: UIView!
    @IBOutlet weak var fathersNameInputBoxContainer: UIView!
    @IBOutlet weak var phoneNumberInputBoxContainer: UIView!
    @IBOutlet weak var emailAddressInputBoxContainer: UIView!
    @IBOutlet weak var passwordInputBoxContainer: UIView!
    @IBOutlet weak var repeatPasswordInputBoxContainer: UIView!
    
    @IBOutlet weak var registerButtonContainer: UIView!
    @IBOutlet weak var orLabelContainer: UIView!
    
    @IBOutlet weak var googleSignInButtonContainer: UIView!
    @IBOutlet weak var appleSignInButtonContainer: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!

    var user: User?
    var authResult: AuthDataResult?
    var role = "heyhey"
    private var surnameInputBox = InputBoxView(input: .init(isLarge: true,
                                                            isRequired: true,
                                                            isSecure: false,
                                                            date: nil,
                                                            time: nil,
                                                            label: "Фамилия",
                                                            placeholder: "Введите вашу фамилию",
                                                            caption: InputBoxView.Caption(text: "",
                                                                                          icon: nil,
                                                                                          action: nil),
                                                            dropdownOptions: nil,
                                                            state: .empty))
    
    
    private var firstNameInputBox = InputBoxView(input: .init(isLarge: true,
                                                              isRequired: true,
                                                              isSecure: false,
                                                              date: nil,
                                                              time: nil,
                                                              label: "Имя",
                                                              placeholder: "Введите ваше имя",
                                                              caption: InputBoxView.Caption(text: "",
                                                                                            icon: nil,
                                                                                            action: nil),
                                                              dropdownOptions: nil,
                                                              state: .empty))
    
    private var fathersNameInputBox = InputBoxView(input: .init(isLarge: true,
                                                                isRequired: false,
                                                                isSecure: false,
                                                                date: nil,
                                                                time: nil,
                                                                label: "Отчество",
                                                                placeholder: "Введите ваше отчество",
                                                                caption: InputBoxView.Caption(text: "",
                                                                                              icon: nil,
                                                                                              action: nil),
                                                                dropdownOptions: nil,
                                                                state: .empty))
    
    private var phoneNumberInputBox = InputBoxView(input: .init(isLarge: true,
                                                                isRequired: true,
                                                                isSecure: false,
                                                                date: nil,
                                                                time: nil,
                                                                label: "Номер телефона",
                                                                placeholder: "Введите ваш номер телефона",
                                                                caption: InputBoxView.Caption(text: "",
                                                                                              icon: nil,
                                                                                              action: nil),
                                                                dropdownOptions: nil,
                                                                state: .empty))
    
    private var emailAddressInputBox = InputBoxView(input: .init(isLarge: true,
                                                                 isRequired: false,
                                                                 isSecure: false,
                                                                 date: nil,
                                                                 time: nil,
                                                                 label: "Электронная почта",
                                                                 placeholder: "Введите адрес электронной почты",
                                                                 caption: InputBoxView.Caption(text: "",
                                                                                               icon: nil,
                                                                                               action: nil),
                                                                 dropdownOptions: nil,
                                                                 state: .empty))
    
    private var passwordInputBox = InputBoxView(input: .init(isLarge: true,
                                                             isRequired: true,
                                                             isSecure: true,
                                                             date: nil,
                                                             time: nil,
                                                             label: "Пароль",
                                                             placeholder: "Придумайте пароль",
                                                             caption: InputBoxView.Caption(text: "",
                                                                                           icon: nil,
                                                                                           action: nil),
                                                             dropdownOptions: nil,
                                                             state: .empty))
    
    private var repeatPasswordInputBox = InputBoxView(input: .init(isLarge: true,
                                                                   isRequired: true,
                                                                   isSecure: true,
                                                                   date: nil,
                                                                   time: nil,
                                                                   label: "Повторите пароль",
                                                                   placeholder: "Повторите пароль",
                                                                   caption: InputBoxView.Caption(text: "",
                                                                                                 icon: nil,
                                                                                                 action: nil),
                                                                   dropdownOptions: nil,
                                                                   state: .empty))
    
    private var registerButton = MyButton(input: .init(isLarge: true, isFilled: true, icon: nil, label: "Зарегистрироваться"))
    
    func onCancel() {
        AppUtility.onCancel(self, true)
    }

    
    
    @objc func tapAction() {
        view.endEditing(true)
    }

    
    // MARK: VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(tapAction))
        scrollView.addGestureRecognizer(tapGesture)
        
//        scrollView.isScrollEnabled = true
//        scrollView.alwaysBounceVertical = true
        
        let nav = Navigation.title("Регистрация",
                                   large: false,
                                   leftAction: [.init(nil, UIImage(named: "arrow-left-large"), false, { [weak self] in self?.onCancel() })],
                                   rightAction: [.init(nil, nil, false, {})])
        
        let topBar = AcadlyNavigation(style: nav, searchInfo: nil)
        
        topBarContainer.addFilledSubview(topBar)
        
        scrollView.contentSize = CGSize(width: 0, height: 1015 + 216) //1014// = CGPoint(x: 0, y: 1014 + 216)
        surnameInputBox
        firstNameInputBox
        fathersNameInputBox
        phoneNumberInputBox
        emailAddressInputBox
        passwordInputBox
        repeatPasswordInputBox
        
        
        surnameInputBox.delegate = self
        firstNameInputBox.delegate = self
        fathersNameInputBox.delegate = self
        phoneNumberInputBox.delegate = self
        emailAddressInputBox.delegate = self
        passwordInputBox.delegate = self
        repeatPasswordInputBox.delegate = self
        
        emailAddressInputBox.keyboardType = .emailAddress
        phoneNumberInputBox.keyboardType = .phonePad
        
        
        surnameInputBoxContainer.addFilledSubview(surnameInputBox)
        firstNameInputBoxContainer.addFilledSubview(firstNameInputBox)
        fathersNameInputBoxContainer.addFilledSubview(fathersNameInputBox)
        phoneNumberInputBoxContainer.addFilledSubview(phoneNumberInputBox)
        emailAddressInputBoxContainer.addFilledSubview(emailAddressInputBox)
        passwordInputBoxContainer.addFilledSubview(passwordInputBox)
        repeatPasswordInputBoxContainer.addFilledSubview(repeatPasswordInputBox)


        surnameInputBox.isRemoveCaptionOnActive = false
        firstNameInputBox.isRemoveCaptionOnActive = false
        fathersNameInputBox.isRemoveCaptionOnActive = false
        phoneNumberInputBox.isRemoveCaptionOnActive = false
        emailAddressInputBox.isRemoveCaptionOnActive = false
        passwordInputBox.isRemoveCaptionOnActive = false
        repeatPasswordInputBox.isRemoveCaptionOnActive = false
        
        registerButtonContainer.addFilledSubview(registerButton)
        
        registerButton.addAction { [weak self] in
            self?.registerButtonTapped()
        }
        
        let orLabel = UILabel()
        orLabel.text = "ИЛИ"
        orLabel.font = Fonts.caption1Bold12.font
        orLabel.textColor = Colors.gray500.color
        orLabel.widthAnchor.constraint(equalToConstant: orLabel.intrinsicContentSize.width).isActive = true
        
        let leftSeparatorView = UIView()
        let rightSeparatorView = UIView()
        
        leftSeparatorView.backgroundColor = Colors.gray300.color
        rightSeparatorView.backgroundColor = Colors.gray300.color
        
        orLabelContainer.addSubview(leftSeparatorView)
        orLabelContainer.addSubview(rightSeparatorView)
        orLabelContainer.addSubview(orLabel)
        
        leftSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        rightSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftSeparatorView.leadingAnchor.constraint(equalTo: orLabelContainer.leadingAnchor, constant: 20),
            rightSeparatorView.trailingAnchor.constraint(equalTo: orLabelContainer.trailingAnchor, constant: -20),
            leftSeparatorView.centerYAnchor.constraint(equalTo: orLabelContainer.centerYAnchor),
            rightSeparatorView.centerYAnchor.constraint(equalTo: orLabelContainer.centerYAnchor),
            
            orLabel.centerXAnchor.constraint(equalTo: orLabelContainer.centerXAnchor),
            orLabel.centerYAnchor.constraint(equalTo: orLabelContainer.centerYAnchor),
            
            leftSeparatorView.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -20),
            rightSeparatorView.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 20),
            leftSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            rightSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let googleButton = UIButton()
        let appleButton = UIButton()
        
        googleSignInButtonContainer.addFilledSubview(googleButton)
        appleSignInButtonContainer.addFilledSubview(appleButton)
        
        googleSignInButtonContainer.backgroundColor = Colors.gray200.color
        appleSignInButtonContainer.backgroundColor = Colors.gray200.color
        
        googleSignInButtonContainer.layer.cornerRadius = 10
        appleSignInButtonContainer.layer.cornerRadius = 10
        
        let googleImageView = UIImageView()
        let appleImageView = UIImageView()
        
        googleImageView.image = UIImage(named: "google-logo")
        appleImageView.image = UIImage(named: "apple-logo")
        
        googleSignInButtonContainer.addSubview(googleImageView)
        appleSignInButtonContainer.addSubview(appleImageView)
        
        googleImageView.translatesAutoresizingMaskIntoConstraints = false
        appleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let googleLabel = UILabel()
        let appleLabel = UILabel()
        
        googleLabel.translatesAutoresizingMaskIntoConstraints = false
        appleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        googleSignInButtonContainer.addSubview(googleLabel)
        appleSignInButtonContainer.addSubview(appleLabel)
        
        googleLabel.text = "Ввойти через Google"
        appleLabel.text = "Ввойти через Apple"
        
        googleLabel.font = Fonts.body17.font
        appleLabel.font = Fonts.body17.font
        
        NSLayoutConstraint.activate([
            googleImageView.leadingAnchor.constraint(equalTo: googleSignInButtonContainer.leadingAnchor, constant: 13),
            googleImageView.topAnchor.constraint(equalTo: googleSignInButtonContainer.topAnchor, constant: 13),
            googleImageView.heightAnchor.constraint(equalToConstant: 24),
            googleImageView.widthAnchor.constraint(equalToConstant: 24),
            
            appleImageView.leadingAnchor.constraint(equalTo: appleSignInButtonContainer.leadingAnchor, constant: 13),
            appleImageView.topAnchor.constraint(equalTo: appleSignInButtonContainer.topAnchor, constant: 13),
            appleImageView.heightAnchor.constraint(equalToConstant: 24),
            appleImageView.widthAnchor.constraint(equalToConstant: 24),
            
            googleLabel.centerXAnchor.constraint(equalTo: googleSignInButtonContainer.centerXAnchor),
            googleLabel.centerYAnchor.constraint(equalTo: googleSignInButtonContainer.centerYAnchor),
            
            appleLabel.centerXAnchor.constraint(equalTo: appleSignInButtonContainer.centerXAnchor),
            appleLabel.centerYAnchor.constraint(equalTo: appleSignInButtonContainer.centerYAnchor),
            
        ])
        
        googleButton.addTarget(self, action: #selector(googleSignInButtonTapped), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(appleSignInButtonTapped), for: .touchUpInside)
    }
    
    @objc func googleSignInButtonTapped() {
        
    }
    
    @objc func appleSignInButtonTapped() {
        
    }
    
    
    @objc func registerButtonTapped() {
        surnameInputBox.resignFirstResponder()
        firstNameInputBox.resignFirstResponder()
        fathersNameInputBox.resignFirstResponder()
        phoneNumberInputBox.resignFirstResponder()
        emailAddressInputBox.resignFirstResponder()
        passwordInputBox.resignFirstResponder()
        repeatPasswordInputBox.resignFirstResponder()
        
        
        let result = checkEntries()
        
        if result == RegistrationErrors.successful {
            Vibration.success.vibrate()
            
            email = emailAddressInputBox.text ?? ""
            password = passwordInputBox.text ?? ""
            
            if let firstName = firstNameInputBox.text {
                if let surname = surnameInputBox.text {
                    if let fatherName = fathersNameInputBox.text {
                         displayName = "\(surname) \(firstName) \(fatherName)"
                    } else {
                        displayName = "\(surname) \(firstName)"
                    }
                }
            }
            phoneNumber = phoneNumberInputBox.text ?? ""
            navigate()
        } else {
            Vibration.error.vibrate()

            if wrongEntries.surnameEmpty {
                surnameInputBox.recolorForFourSeconds(to: .error, text: "Фамилия не может быть пустой", oldText: "hihi")
            }
            if wrongEntries.surnameWrongSyntax {
                surnameInputBox.recolorForFourSeconds(to: .error, text: "Фамилия не может содержать числа", oldText: "hihi")
            }
            if wrongEntries.firstNameEmpty {
                firstNameInputBox.recolorForFourSeconds(to: .error, text: "Имя не может быть пустое", oldText: "hihi")
            }
            if wrongEntries.firstNameWrongSyntax {
                firstNameInputBox.recolorForFourSeconds(to: .error, text: "Имя не может содержать числа", oldText: "hihi")
            }
            if wrongEntries.fathersNameWrongSyntax {
                fathersNameInputBox.recolorForFourSeconds(to: .error, text: "Отчество не может быть пустым", oldText: "hihi")
            }
            if wrongEntries.phoneNumberEmpty {
                phoneNumberInputBox.recolorForFourSeconds(to: .error, text: "Номер телефона не может быть пустым", oldText: "hihi")
            }
            if wrongEntries.phoneNumberWrongSyntax {
                phoneNumberInputBox.recolorForFourSeconds(to: .error, text: "Номер телефона не может содержать букв", oldText: "hihi")
            }
            if wrongEntries.emailWrongSyntax {
                emailAddressInputBox.recolorForFourSeconds(to: .error, text: "Почтовый адрес заполнен неправильно", oldText: "hihi")
            }
            if wrongEntries.passwordEmpty {
                passwordInputBox.recolorForFourSeconds(to: .error, text: "Пароль не может быть пустым", oldText: "hihi")
            }
            if wrongEntries.repeatPasswordEmpty {
                repeatPasswordInputBox.recolorForFourSeconds(to: .error, text: "Пароль не может быть пустым", oldText: "hihi")
            }
            if wrongEntries.passwordWrongSyntax {
                passwordInputBox.recolorForFourSeconds(to: .error, text: "Пароль неправильно заполнен", oldText: "hihi")
            }
            if wrongEntries.repeatPasswordWrongSyntax {
                repeatPasswordInputBox.recolorForFourSeconds(to: .error, text: "Пароль неправильно заполнен", oldText: "hihi")
            }
            if wrongEntries.passwordsNotMatching {
                passwordInputBox.recolorForFourSeconds(to: .error, text: "Пароли не совпадают", oldText: "hihi")
            }
        }
    }
    
    
    enum RegistrationErrors {
        case successful
        case unsuccessful
    }
    
    class WrongEntries {
        var surnameEmpty = false
        var surnameWrongSyntax = false
        
        var firstNameEmpty = false
        var firstNameWrongSyntax = false
        
        var fathersNameWrongSyntax = false
        
        var phoneNumberEmpty = false
        var phoneNumberWrongSyntax = false
        
        var emailWrongSyntax = false
        
        var passwordEmpty = false
        var repeatPasswordEmpty = false
        
        var passwordWrongSyntax = false
        var repeatPasswordWrongSyntax = false
        
        var passwordsNotMatching = false
    }
    
    var wrongEntries = WrongEntries()
    
    func checkEntries() -> RegistrationErrors {
        
        let surnameText = surnameInputBox.text ?? ""
        let firstNameText = firstNameInputBox.text ?? ""
        let fathersNameText = fathersNameInputBox.text ?? ""
        let phoneNumberText = phoneNumberInputBox.text ?? ""
        let emailAddressText = emailAddressInputBox.text ?? ""
        let passwordText = passwordInputBox.text ?? ""
        let repeatPasswordText = repeatPasswordInputBox.text ?? ""
        
        var nothingsWrong = true
        
        if surnameText.isEmpty {
            wrongEntries.surnameEmpty = true
            nothingsWrong = false
        } else {
            wrongEntries.surnameEmpty = false
            nothingsWrong = true
        }
        
        if containsOnlyLettersAndHyphen(surnameText) {
            wrongEntries.surnameWrongSyntax = false
            print("The string contains only letters.")
            nothingsWrong = true
        } else {
            wrongEntries.surnameWrongSyntax = true
            print("The string contains non-letter characters.")
            nothingsWrong = false
        }
        
        
        if firstNameText.isEmpty {
            wrongEntries.firstNameEmpty = true
            nothingsWrong = false
        } else {
            wrongEntries.firstNameEmpty = false
            nothingsWrong = true
        }
        
        if containsOnlyLettersAndHyphen(firstNameText) {
            print("The string contains only letters.")
            wrongEntries.firstNameWrongSyntax = false
            nothingsWrong = true
        } else {
            print("The string contains non-letter characters.")
            wrongEntries.firstNameWrongSyntax = true
            nothingsWrong = false
        }
        
        
        if containsOnlyLettersAndHyphen(fathersNameText) {
            print("The string contains only letters.")
            wrongEntries.fathersNameWrongSyntax = false
            nothingsWrong = true
        } else {
            print("The string contains non-letter characters.")
            wrongEntries.fathersNameWrongSyntax = true
            nothingsWrong = false
        }
        
        
        
        if phoneNumberText.isEmpty {
            wrongEntries.phoneNumberEmpty = true
            nothingsWrong = false
        } else {
            wrongEntries.phoneNumberEmpty = false
            nothingsWrong = true
        }
        
        if isNumericPhoneNumberWithPlus(phoneNumberText) {//} phoneNumberText.allSatisfy({ $0.isNumber }) {
            print("The phone number is fine.")
            wrongEntries.phoneNumberWrongSyntax = false
            nothingsWrong = true
        } else {
            print("The string contains non-letter characters.")
            wrongEntries.phoneNumberWrongSyntax = true
            nothingsWrong = false
        }
        
        if isValidEmail(emailAddressText) {
            wrongEntries.emailWrongSyntax = false
            nothingsWrong = true
        } else {
            wrongEntries.emailWrongSyntax = true
            nothingsWrong = false
        }

        if passwordText.isEmpty {
            wrongEntries.passwordEmpty = true
            nothingsWrong = false
        } else {
            wrongEntries.passwordEmpty = false
            nothingsWrong = true
        }
        
        if repeatPasswordText.isEmpty {
            wrongEntries.repeatPasswordEmpty = true
            nothingsWrong = false
        } else {
            wrongEntries.repeatPasswordEmpty = false
            nothingsWrong = true
        }
        
        if passwordText != repeatPasswordText {
            wrongEntries.passwordsNotMatching = true
            nothingsWrong = false
        } else {
            wrongEntries.passwordsNotMatching = false
            nothingsWrong = true
            
            if containsOnlyLettersNumbersAndPunctuation(passwordText) {
                wrongEntries.repeatPasswordWrongSyntax = false
                nothingsWrong = true
            } else {
                wrongEntries.repeatPasswordWrongSyntax = true
                nothingsWrong = false
            }
        }

        if nothingsWrong {
            return RegistrationErrors.successful
        } else {
            return RegistrationErrors.unsuccessful
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isNumericPhoneNumberWithPlus(_ input: String) -> Bool {
        let pattern = "^[0-9+]+$"
        return input.range(of: pattern, options: .regularExpression) != nil
    }

    /* surname / name */
    func containsOnlyLettersAndHyphen(_ input: String) -> Bool {
        let pattern = "^[a-zA-Z-әіңғүұқөһӘІҢҒҮҰҚӨҺА-Яа-я]+$"
        return input.range(of: pattern, options: .regularExpression) != nil
    }
    
    func containsOnlyLettersNumbersAndPunctuation(_ input: String) -> Bool {
        let regex = "^[A-Za-z0-9.\\s!]+$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: input)
    }
    
    func meetsPasswordCriteria(_ input: String) -> Bool {
        let regex = "^(?=.*\\d)[A-Za-z0-9]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: input)
    }
    
    func apiCall() -> RegistrationErrors {
        return RegistrationErrors.successful
    }
    
    func navigate() {  // navigate to the next page upon successful entry of the
        Task {
            if await signUpWithEmailPassword() == true {
//                dismiss(animated: true)
                print("User \(authResult?.user.uid) signed in")
                print("user = \(user)")

                //TODO: return here
                role = "pupil"
                if role == "pupil" {
                    performSegue(withIdentifier: "pupilTabBar", sender: self)
    //                pupilTabBar
                } else if role == "parent" {
                    
                } else if role == "schoolEmployee" {
                    
                } else if role == "cafeteriaEmployee" {
                    
                }

            }
        }
    }
    
    @objc func goToRegistrationPage() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let registrationViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        registrationViewController.modalPresentationStyle = .fullScreen
        self.present(registrationViewController, animated: true, completion: nil)
    }
    
    func pushAlert(_ result: RegistrationErrors) {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    enum AuthenticationState {
        case unauthenticated
        case authenticating
        case authenticated
    }
    
    var authenticationState: AuthenticationState = .unauthenticated
    var email = ""
    var password = ""
    var displayName = ""
    var phoneNumber = ""
    
    var confirmPassword = ""
    
    var isValid = false
    var errorMessage = ""
    
    func signInWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user
            print("User \(authResult.user.uid) signed in")
            print("user = \(user)")
            authenticationState = .authenticated
            
            
            //            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            //            let registrationViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
            //            registrationViewController.modalPresentationStyle = .fullScreen
            //            self.present(registrationViewController, animated: true, completion: nil)
            
            
            return true
        } catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    
    func signUpWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        
        do {
            let authResultLocal = try await Auth.auth().createUser(withEmail: email, password: password)
            
            authResult = authResultLocal
//            user = authResult.user
            authenticationState = .authenticated
//            user.set
//            user?.phoneNumber = phoneNumber
//            user?.email = email
//            user?.displayName = displayName
            
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let registrationViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
//            registrationViewController.modalPresentationStyle = .fullScreen
//            self.present(registrationViewController, animated: true, completion: nil)
            let changeRequest = user?.createProfileChangeRequest()
            
            // Set the new display name
            changeRequest?.displayName = displayName
//            changeRequest?.phone
            
            // Commit the changes
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("Error updating display name: \(error.localizedDescription)")
                } else {
                    print("Display name updated successfully!")
                }
            }

            
//            print("User \(authResult.user.uid) signed in")
            return true
        } catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}


// MARK: Extension of InputBoxViewDelegate
extension RegistrationViewController: InputBoxViewDelegate {
    func onFieldReturn(_ input: InputBoxView) {
        
        if input == surnameInputBox {
            firstNameInputBox.becomeFirstResponder()
        } else if input == firstNameInputBox {
            fathersNameInputBox.becomeFirstResponder()
        } else if input == fathersNameInputBox {
            phoneNumberInputBox.becomeFirstResponder()
        } else if input == phoneNumberInputBox {
            emailAddressInputBox.becomeFirstResponder()
        } else if input == emailAddressInputBox {
            passwordInputBox.becomeFirstResponder()
        } else if input == passwordInputBox {
            repeatPasswordInputBox.becomeFirstResponder()
        } else if input == repeatPasswordInputBox {
            registerButtonTapped()
        }
    }
    
    func onFieldDidBeginEditing(_ input: InputBoxView) {
        //        input.heightAnchor.constraint(equalToConstant: 87).isActive = true
        //        input.
    }
    
    func onFieldDidEndEditing(_ input: InputBoxView) {
    }
    
    //    func input(_ input: InputBoxView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //
    //    }
    
    func inputDidTapDelegate(_ input: InputBoxView) {
        
    }
}
