import 'package:flutter/material.dart';
import 'package:learnify_client/components/avatar_image.dart';

class QuestionCard extends StatefulWidget {
  final String name;
  final String title;
  final String description;
  final Image image;
  final int voteCount, answersCount;

  const QuestionCard(
      {required this.name,
      required this.title,
      required this.description,
      required this.image,
      this.voteCount = 0,
      this.answersCount = 0});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.voteCount,
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const QuestionScreen(),
      //   ),
      // ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          // color: Colors.blue,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 5),
            child: Container(
              padding: EdgeInsets.all(10),
              // child: Text('hello ', style: TextStyle(color: Colors.white)),
              // duration: Duration(seconds: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //------- head ---------
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 60),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomAvatarImage(
                                image: widget.image.image,
                                // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                              ),
                              SizedBox(height: 5),
                              Text(
                                widget.name,
                                style: TextStyle(color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 9,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black)),
                              SizedBox(height: 5),
                              Text(widget.description,
                                  style: TextStyle(color: Colors.black45))
                            ]),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          // onPressed: () => setState(() => isOpen = !isOpen),
                          child: Center(
                              child: Icon(Icons.more_vert, color: Colors.blue)),
                        ),
                      ),
                    ],
                  ),

                  // //------- body ---------
                  // SizedBox(height: 10),

                  // if (isOpen)

                  //------- footer ---------
                  Divider(color: Colors.black),
                  // SizedBox(height: 5),
                  Container(
                    constraints: BoxConstraints(maxHeight: 25),
                    // color: Colors.lightGreenAccent,
                    padding: EdgeInsets.symmetric(vertical: 0),
                    // margin: EdgeInsets.symmetric(vertical: -5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(widget.answersCount.toString() + " Answers",
                            style: TextStyle(color: Colors.blue)),
                        Text(widget.voteCount.toString() + " Votes",
                            style: TextStyle(color: Colors.blue)),
                        FlatButton.icon(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () => setState(() => widget.voteCount),
                          icon: const Icon(
                            Icons.arrow_drop_up,
                            color: Colors.greenAccent,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          label: const Text(
                            'UpVote',
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
