import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/logic/cubit.dart';
import 'package:flutter_application_2/logic/states.dart';
import 'package:flutter_application_2/screens/add_note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Notes',
            style: TextStyle(
                color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.teal, size: 20.0),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (_) => AddNote()));
        },
      ),
      body: BlocBuilder<NotesCubit, NotesStates>(
        builder: (context, state) => ListView(
          children: [
            for (int i = 0;
                i < BlocProvider.of<NotesCubit>(context).userNotes.length;
                i++)
              InkWell(
                onTap: () {},
                onLongPress: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal,
                  ),
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(
                        BlocProvider.of<NotesCubit>(context).userNotes[i].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        BlocProvider.of<NotesCubit>(context)
                            .userNotes[i]
                            .createdAt,
                        style: TextStyle(color: Colors.white, fontSize: 15.0)),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                      iconSize: 20.0,
                      onPressed: () {},
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
