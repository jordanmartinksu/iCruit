import UIKit
import MessageUI

class CenterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var adminButton: UIBarButtonItem!
  @IBOutlet weak var topBar: UINavigationItem!
  @IBOutlet weak var mainMenu: UITableView!
  var delegate: CenterViewControllerDelegate?
  enum CellIdentifiers {
    static let MainMenuOptionCell = "MainMenuOptionCell"
    static let MainMenuButtonCell = "MainMenuButtonCell"
    static let MainMenuTextboxCell = "MainMenuTextboxCell"
    static let MainMenuQuestionCell = "MainMenuQuestionCell"
    static let MainMenuSubmissionCell = "MainMenuSubmissionCell"
  }
  override func viewDidLoad() {
      super.viewDidLoad()
      mainMenu.separatorStyle = .none
      mainViewVariables.color = UIColor.black
      let colorString = UserDefaults.standard.string(forKey: "Color")
      self.navigationController?.navigationBar.barTintColor = UIColor.black
      switch colorString {
        case "Black":
          mainViewVariables.color = UIColor.black
          mainViewVariables.background = UIColor.white
          self.navigationController?.navigationBar.barTintColor = UIColor.white
        case "Blue":
          mainViewVariables.color = UIColor.blue
          mainViewVariables.background = UIColor.white
          self.navigationController?.navigationBar.barTintColor = UIColor.white
        case "Brown":
          mainViewVariables.color = UIColor.brown
          mainViewVariables.background = UIColor.white
          self.navigationController?.navigationBar.barTintColor = UIColor.white
        case "Cyan":
          mainViewVariables.color = UIColor.cyan
          mainViewVariables.background = UIColor.black
          self.navigationController?.navigationBar.barTintColor = UIColor.black
        case "Dark Gray":
          mainViewVariables.color = UIColor.darkGray
          mainViewVariables.background = UIColor.white
          self.navigationController?.navigationBar.barTintColor = UIColor.white
        case "Gray":
          mainViewVariables.color = UIColor.gray
          mainViewVariables.background = UIColor.white
          self.navigationController?.navigationBar.barTintColor = UIColor.black
        case "Green":
          mainViewVariables.color = UIColor.green
          mainViewVariables.background = UIColor.black
          self.navigationController?.navigationBar.barTintColor = UIColor.white
        case "Light Gray":
          mainViewVariables.color = UIColor.lightGray
          mainViewVariables.background = UIColor.black
          self.navigationController?.navigationBar.barTintColor = UIColor.black
        case "Magenta":
          mainViewVariables.color = UIColor.magenta
          mainViewVariables.background = UIColor.white
          self.navigationController?.navigationBar.barTintColor = UIColor.white
        case "Orange":
          mainViewVariables.color = UIColor.orange
          mainViewVariables.background = UIColor.black
          self.navigationController?.navigationBar.barTintColor = UIColor.black
        case "Purple":
          mainViewVariables.color = UIColor.purple
          mainViewVariables.background = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        case "Red":
          mainViewVariables.color = UIColor.red
          mainViewVariables.background = UIColor.black
          self.navigationController?.navigationBar.barTintColor = UIColor.black
        case "Yellow":
          mainViewVariables.color = UIColor.yellow
          mainViewVariables.background = UIColor.black
          self.navigationController?.navigationBar.barTintColor = UIColor.black
        default:
          mainViewVariables.color = UIColor.black
          mainViewVariables.background = UIColor.white
          self.navigationController?.navigationBar.barTintColor = UIColor.white
      }
      editButton.setTitleTextAttributes([
      NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 26.0)!,
      NSAttributedStringKey.foregroundColor: UIColor.blue],
                                      for: .normal)
      adminButton.setTitleTextAttributes([
      NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 26.0)!,
      NSAttributedStringKey.foregroundColor: UIColor.blue],
                                      for: .normal)
      let titleLabel = UILabel(frame: CGRect(x: 10, y: 50, width: 230, height: 21))
      titleLabel.textAlignment = .center //For center alignment
      titleLabel.text = mainViewVariables.title
      titleLabel.textColor = mainViewVariables.color
      titleLabel.font = UIFont(name: "Helvetica-Bold", size: 30.0)
      topBar.titleView = titleLabel
      mainMenu.backgroundColor = mainViewVariables.background
      mainMenu.dataSource = self
      mainMenu.delegate = self
      self.view.addSubview(mainMenu)
  }
  
  // MARK: Button actions
  @IBAction func editTapped(_ sender: Any) {
    delegate?.toggleLeftPanel?()
  }
  @IBAction func adminTapped(_ sender: Any) {
    delegate?.toggleRightPanel?()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mainViewVariables.mainMenuOptions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if (mainViewVariables.mainMenuOptions[indexPath.row].type == "WelcomeMessage") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "ColorSelection") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "CompanySubmission") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "CompanyTextbox") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuTextboxCell, for: indexPath) as! MainMenuTextbox
      cell.configureForMainMenuTextbox(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "Question") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuQuestionCell, for: indexPath) as! MainMenuQuestion
      cell.configureForMainMenuQuestion(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "EditQuestion") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuTextboxCell, for: indexPath) as! MainMenuTextbox
      cell.configureForMainMenuTextbox(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "QuestionSubmission") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "EditQuestionSubmission") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "AddQuestion") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "Submission") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuSubmissionCell, for: indexPath) as! MainMenuSubmission
      cell.configureForMainMenuSubmission(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "PasswordTextbox") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuTextboxCell, for: indexPath) as! MainMenuTextbox
      cell.configureForMainMenuTextbox(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "PasswordSubmission") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "Reset") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "Export") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "ResetSubmission") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else if (mainViewVariables.mainMenuOptions[indexPath.row].type == "Generic") {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
    else {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainMenuOptionCell, for: indexPath) as! MainMenuOptionCell
      cell.configureForMainMenuOption(mainViewVariables.mainMenuOptions[indexPath.row])
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 63
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let mainMenuOption = mainViewVariables.mainMenuOptions[indexPath.row]
    if (mainMenuOption.type == "ColorSelection") {
      let title = mainMenuOption.title
      let defaults = UserDefaults.standard
      defaults.set(title, forKey:"SelectedColor")
    }
    else if (mainMenuOption.type == "ColorSubmission") {
      let defaults = UserDefaults.standard
      let selected = defaults.string(forKey: "SelectedColor")
      defaults.set(selected, forKey: "Color")
      self.mainMenu.reloadData()
      viewDidLoad()
    }
    else if (mainMenuOption.type == "CompanySubmission") {
      let defaults = UserDefaults.standard
      let selected = defaults.string(forKey: "SelectedName")
      defaults.set(selected, forKey: "CompanyName")
      self.mainMenu.reloadData()
      viewDidLoad()
    }
    else if (mainMenuOption.type == "QuestionSubmission") {
      let defaults = UserDefaults.standard
      var answers = defaults.array(forKey: "Answers")
      var submissions = defaults.array(forKey: "Submissions")
      submissions!.append(answers!)
      answers = ["","","","","","","","","","","","","","","","","","","",""]
      defaults.set(submissions, forKey: "Submissions")
      defaults.set(answers, forKey: "Answers")
      self.mainMenu.reloadData()
      viewDidLoad()
    }
    else if (mainMenuOption.type == "AddQuestion") {
      let defaults = UserDefaults.standard
      var questions = defaults.array(forKey: "Questions") as? [String]
      var selectedQuestions = defaults.array(forKey: "SelectedQuestions") as? [String]
      var number = defaults.integer(forKey: "NumberOfQuestions")
      var notFound = true
      if (number != 20) {
        for n in 0...19 {
          if (notFound && questions![n]=="") {
            questions![n] = "Question " + String(n+1)
            selectedQuestions![n] = "Question " + String(n+1)
            notFound = false
          }
        }
        number = number + 1
      }
      defaults.set(questions, forKey: "Questions")
      defaults.set(number, forKey: "NumberOfQuestions")
      defaults.set(selectedQuestions, forKey: "SelectedQuestions")
      mainViewVariables.mainMenuOptions = MainMenuOption.editQuestionOptions()
      self.mainMenu.reloadData()
      viewDidLoad()
    }
    else if (mainMenuOption.type == "RemoveQuestion") {
      let defaults = UserDefaults.standard
      var questions = defaults.array(forKey: "Questions") as? [String]
      var selectedQuestions = defaults.array(forKey: "SelectedQuestions") as? [String]
      var number = defaults.integer(forKey: "NumberOfQuestions")
      var notFound = true
      if (number != 1) {
        for n in 1...19 {
          if (notFound && questions![n]=="") {
            questions![n - 1] = ""
            selectedQuestions![n-1] = ""
            notFound = false
          }
          else if (n==19) {
            questions![n] = ""
            selectedQuestions![n] = ""
          }
        }
        number = number - 1
      }
      defaults.set(questions, forKey: "Questions")
      defaults.set(questions, forKey: "SelectedQuestions")
      defaults.set(number, forKey: "NumberOfQuestions")
      mainViewVariables.mainMenuOptions = MainMenuOption.editQuestionOptions()
      self.mainMenu.reloadData()
      viewDidLoad()
    }
    else if (mainMenuOption.type == "EditQuestionSubmission") {
      let defaults = UserDefaults.standard
      let questions = defaults.array(forKey: "SelectedQuestions")
      //var i = 0
      //for cell in tableView.visibleCells {
      //  if (cell.isKind(of: MainMenuTextbox.self)) {
      //    questions[i] = ((cell as! MainMenuTextbox).mainTextbox?.text!)!
      //  }
      //  i = i + 1
      //}
      defaults.set(questions, forKey: "Questions")
      mainViewVariables.mainMenuOptions = MainMenuOption.editQuestionOptions()
      self.mainMenu.reloadData()
      viewDidLoad()
    }
    else if (mainMenuOption.type == "PasswordSubmission") {
      let defaults = UserDefaults.standard
      let oldPassword = defaults.string(forKey: "Password")
      let newPassword = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! MainMenuTextbox).mainTextbox?.text!
      let isLocked = defaults.bool(forKey: "IsLocked")
      var numberWrong = defaults.integer(forKey: "WrongPasswords")
      if (!isLocked) {
        defaults.set(true, forKey: "IsLocked")
        defaults.set(newPassword as! String, forKey: "Password")
        (tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! MainMenuOptionCell).mainMenuOptionLabel.text = "Unlock"
      }
      else if (oldPassword == newPassword) {
        defaults.set(false, forKey: "IsLocked")
        defaults.set("", forKey: "Password")
        numberWrong = 0
        defaults.set(numberWrong, forKey: "WrongPasswords")
        (tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! MainMenuOptionCell).mainMenuOptionLabel.text = "Lock"
      }
      else if (numberWrong < 8) {
        numberWrong = numberWrong + 1
        (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! MainMenuTextbox).mainTextbox?.text! = "Wrong Password x" + String(numberWrong)
        defaults.set(numberWrong, forKey: "WrongPasswords")
      }
      else if (numberWrong < 9) {
        numberWrong = numberWrong + 1
        (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! MainMenuTextbox).mainTextbox?.text! = "Two more wrong passwords until reset."
        defaults.set(numberWrong, forKey: "WrongPasswords")
      }
      else if (numberWrong < 10) {
        numberWrong = numberWrong + 1
        (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! MainMenuTextbox).mainTextbox?.text! = "One more wrong passwords until reset."
        defaults.set(numberWrong, forKey: "WrongPasswords")
      }
      else if (numberWrong < 11) {
        numberWrong = numberWrong + 1
        (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! MainMenuTextbox).mainTextbox?.text! = "Too many wrong passwords, press reset to reset iCruit!"
        (tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! MainMenuOptionCell).mainMenuOptionLabel.text = "Reset"
        defaults.set(numberWrong, forKey: "WrongPasswords")
      }
      else {
        (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! MainMenuTextbox).mainTextbox?.text! = "iCruit was reset!"
        (tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! MainMenuOptionCell).mainMenuOptionLabel.text = "Lock"
        resetApp()
      }
    }
    else if (mainMenuOption.type == "Reset") {
      mainViewVariables.mainMenuOptions = MainMenuOption.areYouSureOptions()
      self.mainMenu.reloadData()
      viewDidLoad()
    }
    else if (mainMenuOption.type == "YesReset") {
      resetApp()
      mainViewVariables.mainMenuOptions = [MainMenuOption(title: "iCruit was successfully reset.", type: "Success")]
      self.mainMenu.reloadData()
      viewDidLoad()
    }
    else if (mainMenuOption.type == "NoReset") {
      mainViewVariables.mainMenuOptions = MainMenuOption.resetOptions()
      self.mainMenu.reloadData()
      viewDidLoad()
    }
    else if (mainMenuOption.type == "Export") {
      if MFMailComposeViewController.canSendMail() {
        let mailVC = configuredMailComposeViewController()
        self.present(mailVC, animated: true, completion: nil)
      }
      else {
        print(generateStringForCSV())
        mainViewVariables.mainMenuOptions = [MainMenuOption(title: "Your mail client is not set up properly.  Please set up and try again later.", type: "Export")]
        self.mainMenu.reloadData()
        viewDidLoad()
      }
    }
    else if (mainMenuOption.type == "ResetSubmission") {
      let defaults = UserDefaults.standard
      let answerArray = ["","","","","","","","","","","","","","","","","","","",""]
      let defaultSubmissionsArray = [[String]]()
      defaults.set(answerArray, forKey: "Answers")
      defaults.set(0, forKey: "NumberOfAnswers")
      defaults.set(defaultSubmissionsArray, forKey: "Submissions")
      mainViewVariables.mainMenuOptions = [MainMenuOption(title: "Responses were reset!", type: "Generic")]
      self.mainMenu.reloadData()
      viewDidLoad()
    }
  }
  func resetApp() {
    let defaults = UserDefaults.standard
    let questionArray = ["What is your name?", "What school do you attend?", "What is your expected graduation date?", "What is your GPA?","What is your email?", "How did you hear about us?", "Have you applied online?","","","","","","","","","","","","","",""]
    let answerArray = ["","","","","","","","","","","","","","","","","","","",""]
    let defaultSubmissionsArray = [[String]]()
    defaults.set("iCruit", forKey: "CompanyName")
    defaults.set("iCruit", forKey: "SelectedName")
    defaults.set("Black", forKey: "Color")
    defaults.set("Black", forKey: "SelectedColor")
    defaults.set(questionArray, forKey: "Questions")
    defaults.set(answerArray, forKey: "Answers")
    defaults.set(0, forKey: "NumberOfAnswers")
    defaults.set(7, forKey: "NumberOfQuestions")
    defaults.set(defaultSubmissionsArray, forKey: "Submissions")
    defaults.set(false, forKey:"IsLocked")
    defaults.set("", forKey:"Password")
    defaults.set(0, forKey:"WrongPasswords")
  }
  
  func configuredMailComposeViewController() -> MFMailComposeViewController {
    let mailComposerVC = MFMailComposeViewController()
    mailComposerVC.mailComposeDelegate = self
    mailComposerVC.setSubject("Potential Applicant Data")
    mailComposerVC.setMessageBody("Attached to this email is a CSV of potential applicant data.", isHTML: false)
    let csvStringData = generateStringForCSV()
    if let data = (csvStringData as NSString).data(using: String.Encoding.utf8.rawValue){
      //Attach File
      mailComposerVC.addAttachmentData(data, mimeType: "text/plain", fileName: "applicants.csv")
    }
    return mailComposerVC
  }
  
  func generateStringForCSV () -> NSMutableString {
    let delimiter = ","
    let stringData:NSMutableString  = NSMutableString()
    let defaults = UserDefaults.standard
    let submissions = defaults.array(forKey: "Submissions") as! [[String]]
    let questions = defaults.array(forKey: "Questions") as! [String]
    var isFirst = true
    
    for question in questions {
      if (!isFirst && (question != "")) {
        stringData.append(delimiter)
      }
      else {
        isFirst = false
      }
      stringData.append(question)
    }
    stringData.append("\n")
    
    for submission in submissions {
      isFirst = true
      for entry in submission {
        if (!isFirst && (entry != "")) {
          stringData.append(delimiter)
        }
        else {
          isFirst = false
        }
        stringData.append(entry)
      }
      stringData.append("\n")
    }
    
    return stringData
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
    mainViewVariables.mainMenuOptions = [MainMenuOption(title: "Reset Response Data", type: "ResetSubmission")]
    self.mainMenu.reloadData()
    viewDidLoad()
  }
}

struct mainViewVariables{
  static var title = "iCruit"
  static var mainMenuOptions = [MainMenuOption(title:"iCruit allows you to create a custom experience for potential applicants to give you information about themselves.", type:"Tutorial"),MainMenuOption(title:"Take a look in the Admin menu to change the questions, color of questions and titles, edit your company's name, view responses, export data via email, and finally reset the app!", type:"Tutorial"),MainMenuOption(title:"You can add up to a maximum of 20 questions.", type:"Tutorial"),MainMenuOption(title:"iCruit doesn't require a Wi-Fi connection to gather data, but you will need to be connected to export data.", type:"Tutorial"),MainMenuOption(title:"In the Lock/Unlock menu, you'll find an option to present the questions to applicants as well as lock/unlock the admin menu with a password", type:"Tutorial"),MainMenuOption(title:"Don't forget your password as you will not be able to access the data without it.", type:"Tutorial"),MainMenuOption(title:"If you do forget the password, you can reset the app by repeatedly submitting an incorrect password.", type:"Tutorial"),MainMenuOption(title:"I hope you enjoy the app, and if you have any questions, concerns or comments, email me at jordanmartin@ksu.edu.", type:"Tutorial")]
  static var color = UIColor.black
  static var background = UIColor.white
}

extension CenterViewController: SidePanelViewControllerDelegate {
  func didSelectMenuOption(_ menuOption: MenuOption) {
    mainViewVariables.title = menuOption.title
    if (menuOption.titleString == "Color") {
        mainViewVariables.mainMenuOptions = MainMenuOption.editColorOptions()
    }
    else if (menuOption.titleString == "Company") {
      mainViewVariables.mainMenuOptions = MainMenuOption.editCompanyOptions()
    }
    else if (menuOption.titleString == "Present") {
      mainViewVariables.mainMenuOptions = MainMenuOption.presentQuestionOptions()
      let defaults = UserDefaults.standard
      let token = defaults.string(forKey: "CompanyName")
      mainViewVariables.title = String(token!)
    }
    else if (menuOption.titleString == "Questions") {
      mainViewVariables.mainMenuOptions = MainMenuOption.editQuestionOptions()
    }
    else if (menuOption.titleString == "Responses") {
      mainViewVariables.mainMenuOptions = MainMenuOption.submissionOptions()
    }
    else if (menuOption.titleString == "Lock") {
      mainViewVariables.mainMenuOptions = MainMenuOption.lockOptions()
      mainViewVariables.title = "Lock/Unlock"
    }
    else if (menuOption.titleString == "Reset") {
      mainViewVariables.mainMenuOptions = MainMenuOption.resetOptions()
    }
    else if (menuOption.titleString == "Export") {
      mainViewVariables.mainMenuOptions = MainMenuOption.exportOptions()
    }
    else if (menuOption.titleString == "Tutorial") {
      mainViewVariables.mainMenuOptions = [MainMenuOption(title:"iCruit allows you to create a custom experience for potential applicants to give you information about themselves.", type:"Tutorial"),MainMenuOption(title:"Take a look in the Admin menu to change the questions, color of questions and titles, edit your company's name, view responses, export data via email, and finally reset the app!", type:"Tutorial"),MainMenuOption(title:"You can add up to a maximum of 20 questions.", type:"Tutorial"),MainMenuOption(title:"iCruit doesn't require a Wi-Fi connection to gather data, but you will need to be connected to export data.", type:"Tutorial"),MainMenuOption(title:"In the Lock/Unlock menu, you'll find an option to present the questions to applicants as well as lock/unlock the admin menu with a password", type:"Tutorial"),MainMenuOption(title:"Don't forget your password as you will not be able to access the data without it.", type:"Tutorial"),MainMenuOption(title:"If you do forget the password, you can reset the app by repeatedly submitting an incorrect password.", type:"Tutorial"),MainMenuOption(title:"I hope you enjoy the app, and if you have any questions, concerns or comments, email me at jordanmartin@ksu.edu.", type:"Tutorial")]
      mainViewVariables.title = "iCruit"
    }
    delegate?.collapseSidePanels?()
    self.mainMenu.reloadData()
    viewDidLoad()
  }
}

