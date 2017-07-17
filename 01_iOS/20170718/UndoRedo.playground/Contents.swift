//: Playground - noun: a place where people can play
import Foundation

enum Color {
    case red, blue, yellow
}

struct Annotation: Hashable, Equatable {
    let id: UUID
    var color: Color
    
    init(id: UUID = UUID(), color: Color) {
        self.id = id
        self.color   = color
    }
    
    var hashValue: Int {
        return self.id.hashValue
    }
    
    static func ==(lhs: Annotation, rhs: Annotation) -> Bool {
        return lhs.id == rhs.id
    }
}

struct UndoRedoStep<T> {
    let oldValue: T?
    let newValue: T?
    
    /// converts and undo step into a redo step and vice-versa
    func flip() -> UndoRedoStep<T> {
        return UndoRedoStep(oldValue: self.newValue, newValue: self.oldValue)
    }
}

// MARK: scaffolding

class DB {
    var state: Set<Annotation> = []
    
    init() { }
    
    func saveAnnotation(annotation: Annotation) {
        // Replace old with new
        self.state.remove(annotation)
        self.state.insert(annotation)
    }
    
    func  delete(annotation: Annotation) {
        self.state.remove(annotation)
    }
    
    func create(annotation: Annotation) {
        self.state.insert(annotation)
    }
}

class AnnotationStore {
    var db: DB
    var state: Set<Annotation> = []
    
    var undoStack: [UndoRedoStep<Annotation>] = []
    var redoStack: [UndoRedoStep<Annotation>] = []
    
    init(db: DB) {
        self.db = db
    }
    
    func annotationById(annotationId: UUID) -> Annotation? {
        return self.state.first { $0.id == annotationId }
    }
    
    func save(annotation: Annotation, isUndoRedo: Bool = false) {
        if !isUndoRedo {
            let oldValue = self.annotationById(annotationId: annotation.id)
            let undoStep = UndoRedoStep(oldValue: oldValue, newValue: annotation)
            self.undoStack.append(undoStep)
            self.redoStack = []
        }
        self.state.remove(annotation)
        self.state.insert(annotation)
        
        self.db.saveAnnotation(annotation: annotation)
    }
    
    func delete(annotation: Annotation, isUndoRedo: Bool = false) {
        if !isUndoRedo {
            let oldValue = self.annotationById(annotationId: annotation.id)
            let undoStep = UndoRedoStep(oldValue: oldValue, newValue: nil)
            self.undoStack.append(undoStep)
            self.redoStack = []
        }
        self.state.remove(annotation)
        self.db.delete(annotation: annotation)
    }
    
    func undo() {
        guard let undoRedoStep = self.undoStack.popLast() else {
            return
        }
        self.perform(undoRedoStep: undoRedoStep)
        self.redoStack.append(undoRedoStep.flip())
    }
    
    func redo() {
        guard let undoRedoStep = self.redoStack.popLast() else {
            return
        }
        self.perform(undoRedoStep: undoRedoStep)
        self.undoStack.append(undoRedoStep.flip())
    }
    
    func perform(undoRedoStep: UndoRedoStep<Annotation>) {
        switch (undoRedoStep.oldValue, undoRedoStep.newValue) {
        case let (oldValue?, _?):
            self.save(annotation: oldValue, isUndoRedo: true)
        case let (oldValue?, nil):
            self.save(annotation: oldValue, isUndoRedo: true)
        case let (nil, newValue?):
            self.delete(annotation: newValue, isUndoRedo: true)
        default:
            fatalError("Undo step with neither old nor new value makes no sense")
        }
    }
}

// MARK: Util
func performAndPrint(closure: () -> Void) {
    closure()
    print("Store")
    print(store.state)
    print("DB")
    print(db.state)
}


// MARK: Test code
let db = DB()
let store = AnnotationStore(db: db)

var annotation = Annotation(color: .red)
store.save(annotation: annotation)
annotation.color = .blue
store.save(annotation: annotation)
annotation.color = .yellow
store.save(annotation: annotation)
store.delete(annotation: annotation)

print(store.state)
print(db.state)

performAndPrint {
    store.undo()
}

performAndPrint {
    store.undo()
}

performAndPrint {
    store.undo()
}

performAndPrint {
    store.undo()
}

performAndPrint {
    store.redo()
}

performAndPrint {
    store.redo()
}


performAndPrint {
    store.redo()
}


performAndPrint {
    store.redo()
}

performAndPrint {
    store.undo()
}
