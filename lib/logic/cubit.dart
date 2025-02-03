import 'package:flutter_application_2/logic/model.dart';
import 'package:flutter_application_2/logic/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(InitNoteState());

  List<NoteModel> _userNotes = [
    NoteModel(
        id: 1,
        title: 'Grocery',
        description: 'description',
        createdAt: '20-12-2025',
        isBinned: false),
    NoteModel(
        id: 1,
        title: 'Gym',
        description: 'description',
        createdAt: '25-12-2025',
        isBinned: false),
    NoteModel(
        id: 1,
        title: 'Bostan Mall',
        description: 'description',
        createdAt: '10-12-2025',
        isBinned: false),
  ];
  List<NoteModel> get userNotes => _userNotes;

  void createNote({required String title, required String description}) {
    DateTime nowValue = DateTime.now();
    NoteModel newObj = NoteModel(
        id: 5,
        title: title,
        description: description,
        createdAt: nowValue.toString(),
        isBinned: false);
    _userNotes.insert(0, newObj);
    emit(CreateNoteSuccessState());
  }

  void getNotes() {}

  void editNote() {}

  void deleteNote() {}

  void pinNote() {}
}
