import 'package:flutter/cupertino.dart';
import 'notes.dart';

class NotesProviders extends ChangeNotifier {
  final List<Notes> _notes = <Notes>[];

  List<Notes> get getNotes {
    return _notes;
  }

  void addNotes(String title, String descriptions) {
    Notes note = Notes(title, descriptions);

    _notes.add(note);

    notifyListeners();
  }

  void removeNotes(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
