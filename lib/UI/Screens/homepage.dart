import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/Widgets/customtextfield.dart';
import 'package:taskapp/Firebase/fire_auth_methods.dart';
import 'package:taskapp/updateData.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController discriptioncontroller = TextEditingController();
  final List<String> category = ["Personal", "Work", " Casual"];
  final Map<String, Color> categoryColors = {
    "Personal": const Color.fromARGB(255, 122, 204, 125),
    "Work": Color.fromARGB(255, 72, 95, 223),
    "Casual": const Color.fromARGB(255, 219, 162, 76),
  };

  late String selectedCateg;
  String id = "";
  List<Select> selected = [];

  @override
  void initState() {
    selectedCateg = category[0];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    titlecontroller.dispose();
    discriptioncontroller.dispose();
  }

  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 135, 90, 161),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SizedBox(
                      height: 700,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Center(
                              child: Text(
                                "Add New task",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(
                                thickness: 1.5,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Title",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              textEditingController: titlecontroller,
                              hintText: "Add Title",
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Discription",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              textEditingController: discriptioncontroller,
                              hintText: "Description",
                              maxLines: 3,
                            ),
                            SizedBox(
                              height: 80,
                              child: ListView.builder(
                                itemCount: category.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  final categ = category[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCateg = categ;
                                          //debugPrint(categ);
                                        });
                                      },
                                      child: Chip(
                                        backgroundColor: selectedCateg == categ
                                            ? const Color.fromARGB(
                                                255, 133, 101, 178)
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        label: Text(categ),
                                        labelStyle: TextStyle(
                                          color: selectedCateg == categ
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Expanded(
                                //   child: ElevatedButton(
                                //     onPressed: () {
                                //       Navigator.pop(context);
                                //     },
                                //     style: ElevatedButton.styleFrom(
                                //       backgroundColor: const Color.fromARGB(
                                //           255, 213, 144, 131),
                                //     ),
                                //     child: const Text("Cancle"),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: 20,
                                // ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("Todo")
                                          .add({
                                        "title": titlecontroller.text,
                                        "discription":
                                            discriptioncontroller.text,
                                        "category": selectedCateg,
                                      });
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50),
                                      backgroundColor: const Color.fromARGB(
                                          255, 133, 101, 178),
                                    ),
                                    child: const Text(
                                      "Create",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: const Icon(Icons.add)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Image.asset("assets/redshirtgirl.png"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hey",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Soul Reaper",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 135, 90, 161),
                    borderRadius: BorderRadius.circular(22)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Manage Your \n       Tasks",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              "assets/swirly-arrow.png",
                              height: 45,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Image.asset(
                              "assets/todo.png",
                              height: 45,
                              width: 50,
                            )
                          ],
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Tasks",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text("No Tasks"));
                    }

                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> document =
                                snapshot.data?.docs[index].data()
                                    as Map<String, dynamic>;
                            Color leftTileColor =
                                categoryColors[document["category"]] ??
                                    Colors.transparent;
                            selected.add(Select(
                                id: snapshot.data?.docs[index].id as String,
                                checkValue: false));

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdataTodo(
                                          document: document,
                                          id: snapshot.data?.docs[index].id
                                              as String)),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 90,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color.fromARGB(
                                          255, 240, 243, 240)),
                                  child: Row(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: selectedCateg.isEmpty
                                              ? Colors.amberAccent
                                              : leftTileColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          )),
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            // color: selected[index].checkValue ==
                                            //         true
                                            //     ? Colors.grey.withOpacity(0.5)
                                            //     : Colors.transparent,
                                            child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title:
                                                  Text("${document["title"]}"),
                                              subtitle: Text(
                                                "${document["discription"]}",
                                                maxLines: 1,
                                              ),
                                              trailing: Checkbox(
                                                activeColor: leftTileColor,
                                                checkColor: Colors.white,
                                                value:
                                                    selected[index].checkValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selected[index].checkValue =
                                                        !selected[index]
                                                            .checkValue;
                                                  });
                                                },
                                                shape: const CircleBorder(),
                                              ),
                                            ),
                                          ),

                                          //Text("${document["category"]}"),
                                        ],
                                      ),
                                    ))
                                  ]),
                                ),
                              ),
                            );
                          }),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Select {
  late String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}
