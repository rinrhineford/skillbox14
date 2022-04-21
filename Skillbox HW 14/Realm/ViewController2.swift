import UIKit
import RealmSwift

class ViewController2: UIViewController {
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Новая задача", message: nil, preferredStyle: .alert)
        let cancelAlertAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        let addAlertAction = UIAlertAction(title: "Добавить", style: .cancel, handler: { alert in
            if let newNote = alertController.textFields?.first?.text {
                NotesPersistance.shared.addNote(content: newNote)
                self.tableView.reloadData()
            }
        })
        alertController.addAction(cancelAlertAction)
        alertController.addAction(addAlertAction)
        alertController.addTextField { textField in
            textField.placeholder = "Содержание"
        }
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.tableView.reloadData()
        })
    }
    
    @IBOutlet weak var tableView: UITableView!
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotesPersistance.shared.addArray()
        tableView.tableFooterView = UIView()
    }
}

extension ViewController2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(NotesList.self).first?.objects.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! NotesTableViewCell
        let currentNote = realm.objects(NotesList.self).first?.objects[indexPath.row]
        cell.descriptionLabel.text = currentNote?.content
        if (currentNote?["isCompleted"] as? Bool) == true {
            cell.indicatorImageView.image = UIImage(named: "blue-checkmark-done")
        } else {
            cell.indicatorImageView.image = UIImage(named: "blue-checkmark")
        }
        
        if tableView.isEditing {
            cell.descriptionLabel.alpha = 0.5
            cell.indicatorImageView.alpha = 0.5
        } else {
            cell.descriptionLabel.alpha = 1
            cell.indicatorImageView.alpha = 1
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            NotesPersistance.shared.removeNote(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! NotesTableViewCell
        if NotesPersistance.shared.changeNoteState(index: indexPath.row) {
            cell.indicatorImageView.image = UIImage(named: "blue-checkmark-done")
        } else {
            cell.indicatorImageView.image = UIImage(named: "blue-checkmark")
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        NotesPersistance.shared.moveNote(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
