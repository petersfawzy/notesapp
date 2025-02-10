import 'package:flutter/material.dart';
import 'package:flutter_application_2/logic/cubit.dart';
import 'package:flutter_application_2/logic/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Create New Note',
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
                state is CreateNewNoteLoadingState ? 'Loading' : 'Add',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: state is CreateNewNoteLoadingState
                  ? () {}
                  : () {
                      if (titleController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        return;
                      }
                      BlocProvider.of<NotesCubit>(context).createNote(
                          title: titleController.text,
                          description: descriptionController.text);
                      Navigator.pop(context);
                    },
            ),
          )
        ],
      ),
    );
  }
}
