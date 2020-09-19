import Foundation
import RealmSwift

class NotesList: Object {
    dynamic var objects = List<Note>()
}

class Note: Object {
    @objc dynamic var content = ""
    @objc dynamic var isCompleted = false
}

let arr = NotesList()

class NotesPersistance {
    static let shared = NotesPersistance()
    private let realm = try! Realm()
    
    func addNote(content: String, isCompleted: Bool = false) {
        let note = Note()
        note.content = content
        note.isCompleted = isCompleted
        
        try! realm.write {
            realm.objects(NotesList.self).first?.objects.append(note)
        }
    }
    
    func addArray() {
        try! realm.write {
            realm.add(arr)
        }
    }
    
    func removeNote(index: Int) {
        try! realm.write {
            realm.objects(NotesList.self).first?.objects.remove(at: index)
        }
    }
    
    func changeNoteState(index: Int) -> Bool {
        try! realm.write {
            let note = realm.objects(NotesList.self).first?.objects[index]
            note?.isCompleted = !(note?.isCompleted ?? true)
            return note?.isCompleted ?? false
        }
    }
    
    func moveNote(fromIndex: Int, toIndex: Int) {
        try! realm.write {
            guard let movingNote = realm.objects(NotesList.self).first?.objects[fromIndex] else { return }
            let array = realm.objects(NotesList.self).first?.objects
            array?.remove(at: fromIndex)
            array?.insert(movingNote, at: toIndex)
        }
    }
    
}
