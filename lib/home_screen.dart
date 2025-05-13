import 'package:chatbot_ai_facilitated/live_score_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<LiveScoreModel> _liveScoreList = [];
  final FirebaseFirestore db = FirebaseFirestore.instance;
  // final bool _inProgress = false;
  //
  // @override
  // void initState(){
  //   super.initState();
  //   _getLiveScoreList();
  // }
  // Future<void> _getLiveScoreList() async {
  //   _liveScoreList.clear();
  //   _inProgress = true;
  //   setState(() {});
  //   final QuerySnapshot snapshot = await db.collection("football").get();
  //   for(QueryDocumentSnapshot doc in snapshot.docs) {
  //
  //     LiveScoreModel liveScoreModel = LiveScoreModel.fromJson(doc.id, doc.data() as Map<String, dynamic>);
  //
  //     _liveScoreList.add(liveScoreModel);
  //   }
  //   _inProgress = false;
  //   setState(() {
  //
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live score"),
      ),
      body:  StreamBuilder(
            stream: db.collection('football').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData == false) {
                return const SizedBox();
              }
              _liveScoreList.clear();
              for (QueryDocumentSnapshot doc in snapshot.data!.docs) {
                LiveScoreModel liveScoreModel = LiveScoreModel.fromJson(
                    doc.id, doc.data() as Map<String, dynamic>);

                _liveScoreList.add(liveScoreModel);
              }

              return ListView.builder(
                itemCount: _liveScoreList.length,
                itemBuilder: (context, index) {
                  LiveScoreModel liveScore = _liveScoreList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          liveScore.isRunning ? Colors.green : Colors.grey,
                      radius: 8,
                    ),
                    title: Text(liveScore.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Team 1: ${liveScore.team1}'),
                        Text('Team 2: ${liveScore.team2}'),
                        Text('Winner Team: ${liveScore.winnerTeam}')
                      ],
                    ),
                    trailing: Text(
                      '${liveScore.team1Score}: ${liveScore.team2Score}',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              );
            }),

    );
  }
}
