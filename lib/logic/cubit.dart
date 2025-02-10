import 'package:flutter_application_2/logic/model.dart';
import 'package:flutter_application_2/logic/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import 'package:http/http.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(InitNoteState());

  List<NoteModel> _userNotes = [];
  List<NoteModel> get userNotes => _userNotes;

  void createNote({required String title, required String description}) async {
    emit(CreateNewNoteLoadingState());
    DateTime nowValue = DateTime.now();
    Map<String, dynamic> newData = {
      'noteTitle': title,
      'noteDescription': description,
      'createdAt': nowValue.toString().substring(0, 10)
    };
    Response response = await post(
        Uri.parse(
            'https://mynote-119c8-default-rtdb.firebaseio.com/notes.json'),
        body: json.encode(newData));
    if (response.statusCode == 200) {
      NoteModel newObj = NoteModel(
          id: json.decode(response.body)['name'],
          title: title,
          description: description,
          createdAt: nowValue.toString().substring(0, 10),
          isBinned: false);
      _userNotes.insert(0, newObj);
      emit(CreateNoteSuccessState());
    } else {
      emit(CreateNoteErrorState());
    }
  }

  void getNotes() async {
    emit(GetNotesLoadingState());
    Response response = await get(Uri.parse(
        'https://mynote-119c8-default-rtdb.firebaseio.com/notes.json'));
    if (response.statusCode == 200) {
      var myData = json.decode(response.body);
      myData.forEach((k, v) {
        _userNotes.add(NoteModel(
            id: k,
            title: v['noteTitle'],
            description: v['noteDescription'],
            createdAt: v['createdAt'],
            isBinned: false));
      });
      emit(GetNotesSuccessState());
    } else {
      emit(GetNotesErrorState());
    }
  }

  void editNote(
      NoteModel noteModel, String newTitle, String newDescription) async {
    emit(EditNoteLoadingState());
    Map<String, String> newData = {};
    if (noteModel.title != newTitle) {
      noteModel.title = newTitle;
      newData['noteTitle'] = newTitle;
    }
    if (noteModel.description != newDescription) {
      noteModel.description = newDescription;
      newData['noteDescription'] = newDescription;
    }
    Response response = await patch(
        Uri.parse(
            'https://mynote-119c8-default-rtdb.firebaseio.com/notes/${noteModel.id}.json'),
        body: json.encode(newData));
    if (response.statusCode != 200) {
      emit(EditNoteErrorState());
    } else {
      emit(UpdateNoteState());
    }
  }

  void deleteNote(int index, NoteModel noteModel) async {
    emit(DeleteNoteLoadingState());
    Response response = await delete(Uri.parse(
        'https://mynote-119c8-default-rtdb.firebaseio.com/notes/${noteModel.id}.json'));
    if (response.statusCode != 200) {
      emit(DeleteNoteErorrState());
    } else {
      userNotes.removeAt(index);
      emit(DeleteNoteState());
    }
  }

  void pinNote(NoteModel noteModel, int currentIndex) {
    if (noteModel.isBinned) {
      userNotes.removeAt(currentIndex);
      userNotes.add(noteModel);
      sortNotesByDate();
    } else {
      userNotes.removeAt(currentIndex);
      userNotes.insert(0, noteModel);
    }
    noteModel.isBinned = !noteModel.isBinned;
    emit(PinNoteState());
  }

  void sortNotesByDate() {
    _userNotes.sort((i, x) => i.createdAt.compareTo(x.createdAt));
    emit(SortState());
  }
}
