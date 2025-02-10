import 'package:flutter/material.dart';
import 'package:flutter_application_2/logic/cubit.dart';
import 'package:flutter_application_2/logic/model.dart';
import 'package:flutter_application_2/logic/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditNote extends StatefulWidget {
  NoteModel noteModel;
  EditNote({required this.noteModel});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.noteModel.title;
    descriptionController.text = widget.noteModel.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Edit ${widget.noteModel.title} Note',
            style: TextStyle(
                color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          TextField(
            controller: titleController,
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
          ),
          SizedBox(height: 20),
          BlocBuilder<NotesCubit, NotesStates>(
            builder: (context, state) => TextButton(
              child: Text(
                state is EditNoteLoadingState ? 'Updating' : 'Update',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: state is EditNoteLoadingState
                  ? () {}
                  : () {
                      BlocProvider.of<NotesCubit>(context).editNote(
                          widget.noteModel,
                          titleController.text,
                          descriptionController.text);
                      Navigator.pop(context);
                    },
            ),
          )
        ],
      ),
    );
  }
}
