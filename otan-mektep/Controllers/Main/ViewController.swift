//
//  ViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 14.12.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var loginInputBoxContainer: UIView!
    @IBOutlet weak var passwordInputBoxContainer: UIView!
    @IBOutlet weak var loginButtonContainer: UIView!
    
    @IBOutlet weak var registrationFieldContainer: UIView!
    //    @IBOutlet weak var registerButton: UIButton!
//    @IBOutlet weak var noAccountLabel: UILabel!
    
    
    @IBOutlet weak var googleSignInButtonContainer: UIView!
    @IBOutlet weak var appleSignInButtonContainer: UIView!
    
    @IBOutlet weak var orLabelContainer: UIView!
    
    var user: User?
    
    private var loginInputBox = InputBoxView(input: .init(isLarge: true,
                                                          isRequired: true,
                                                          isSecure: false,
                                                          date: nil,
                                                          time: nil,
                                                          label: "Логин",
                                                          placeholder: "Введите логин",
                                                          caption: InputBoxView.Caption(text: "Имя пользователя / почтовый адрес / номер телефона", 
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
                                                             placeholder: "Введите пароль",
                                                             caption: InputBoxView.Caption(text: "Нажмите на иконку глаза, чтобы скрыть/раскрыть пароль",
                                                                                           icon: nil,
                                                                                           action: nil), 
                                                             dropdownOptions: nil,
                                                             state: .empty))

    private var loginButton = MyButton(input: .init(isLarge: true, isFilled: true, icon: nil, label: "Войти"))

    
    @objc func tapAction() {
        view.endEditing(true)
    }
    
    // MARK: VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tapGesture)

        
        loginInputBox.delegate = self
        passwordInputBox.delegate = self
        
        loginInputBox.keyboardType = .emailAddress
        
        let registrationStackView = UIStackView()
        registrationStackView.axis = .horizontal
        registrationStackView.spacing = 0
        
        let noAccountLabel = UILabel()
        let registerButton = UIButton()
        
        noAccountLabel.text = "Нет аккаунта?"
        registerButton.setTitle("Зарегистрируйтесь".localizedCapitalized, for: .normal)
        
        noAccountLabel.widthAnchor.constraint(equalToConstant: noAccountLabel.intrinsicContentSize.width).isActive = true
        
        
        noAccountLabel.font = Fonts.subheadlineRegular15.font
        registerButton.titleLabel?.font = Fonts.subheadlineRegular15.font
        
        noAccountLabel.textColor = .label
        registerButton.setTitleColor(Colors.accentColor.color, for: .normal)
        
        registerButton.widthAnchor.constraint(equalToConstant: registerButton.titleLabel?.intrinsicContentSize.width ?? 0).isActive = true
        
        registerButton.addTarget(self, action: #selector(goToRegistrationPage), for: .touchUpInside)

        registrationFieldContainer.addSubview(registrationStackView)
        registrationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            registrationStackView.centerXAnchor.constraint(equalTo: registrationFieldContainer.centerXAnchor),
            registrationStackView.centerYAnchor.constraint(equalTo: registrationFieldContainer.centerYAnchor),
        ])
        
        registrationStackView.addArrangedSubview(noAccountLabel)
        registrationStackView.addArrangedSubview(registerButton)
            
        welcomeLabel.text = "Добро пожаловать!\nВойдите в приложение"
    
        loginInputBoxContainer.addFilledSubview(loginInputBox)
        passwordInputBoxContainer.addFilledSubview(passwordInputBox)

        loginInputBox.isRemoveCaptionOnActive = false
        passwordInputBox.isRemoveCaptionOnActive = false
        
        loginInputBox.delegate = self
        passwordInputBox.delegate = self
        
        loginButtonContainer.addFilledSubview(loginButton)
        
        loginButton.addAction { [weak self] in
            self?.loginButtonTapped()
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
    
    
    @objc func loginButtonTapped() {
        
        loginInputBox.resignFirstResponder()
        passwordInputBox.resignFirstResponder()
        
        let result = checkEntries()
        if result == LoginErrors.successful {
            Vibration.success.vibrate()

            navigate()
        } else {
            
            if result == .loginEmpty {
                loginInputBox.recolorForFourSeconds(to: .error, text: "Логин не должен быть пустым", oldText: "hihi")
                Vibration.error.vibrate()

            } else if result == .bothEmpty {
                loginInputBox.recolorForFourSeconds(to: .error, text: "Логин не должен быть пустым", oldText: "hihi")
                passwordInputBox.recolorForFourSeconds(to: .error, text: "Пароль не должен быть пустым", oldText: "hihi")

                Vibration.error.vibrate()

            } else if result == .passwordEmpty {
                passwordInputBox.recolorForFourSeconds(to: .error, text: "Пароль не должен быть пустым", oldText: "hihi")

                Vibration.error.vibrate()
            }
        }
    }
    
        
    enum LoginErrors {
        case successful
        case unsuccessful
        case loginEmpty
        case passwordEmpty
        case bothEmpty
        case passwordIncorrect
        case loginIncorrect
        case loginSyntaxIncorrect
        case passwordSyntaxIncorrect
    }
    
    func checkEntries() -> LoginErrors {
        if loginInputBox.text == "" && passwordInputBox.text == "" {
            return LoginErrors.bothEmpty
        } else if loginInputBox.text == "" {
            return LoginErrors.loginEmpty
        } else if passwordInputBox.text == "" {
            return LoginErrors.passwordEmpty
        }

        email = loginInputBox.text ?? ""
        password = passwordInputBox.text ?? ""
        
        Task {
            if await signInWithEmailPassword() == true {
                dismiss(animated: true)
            }
            return LoginErrors.successful
        }
      
        

        
        
        
        
        
        
        
        let api = apiCall()
        
        if api == LoginErrors.successful {
            return LoginErrors.successful
        }
        return LoginErrors.unsuccessful
    }
    
    func apiCall() -> LoginErrors {
        return LoginErrors.successful
    }
    
    func navigate() {  // navigate to the next page upon successful entry of the
        
    }
    
    @objc func goToRegistrationPage() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let registrationViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        registrationViewController.modalPresentationStyle = .fullScreen
        self.present(registrationViewController, animated: true, completion: nil)
    }

    func pushAlert(_ result: LoginErrors) {
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
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            
            user = authResult.user
            authenticationState = .authenticated

//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let registrationViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
//            registrationViewController.modalPresentationStyle = .fullScreen
//            self.present(registrationViewController, animated: true, completion: nil)

            print("User \(authResult.user.uid) signed in")
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
extension ViewController: InputBoxViewDelegate {
    func onFieldReturn(_ input: InputBoxView) {
        if input == loginInputBox {
            passwordInputBox.becomeFirstResponder()
        } else {
            loginButtonTapped()
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
