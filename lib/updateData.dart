import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Widgets/customtextfield.dart';

class UpdataTodo extends StatefulWidget {
  final String id;
  final Map<String, dynamic> document;
  const UpdataTodo({super.key, required this.document, required this.id});

  @override
  State<UpdataTodo> createState() => _UpdataTodoState();
}

class _UpdataTodoState extends State<UpdataTodo> {
  late TextEditingController titlecontroller;
  late TextEditingController discriptioncontroller;
  final List<String> category = ["Personal", "Work", " Casual"];

  late String selectedCateg;

  @override
  void initState() {
    String title = widget.document["title"] ?? "Nothing Here ";
    String discription = widget.document["title"] ?? "Nothing Here ";
    titlecontroller = TextEditingController(text: title);
    discriptioncontroller = TextEditingController(text: discription);

    selectedCateg = category[0];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    titlecontroller.dispose();
    discriptioncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      primary: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      "Task Content",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("Todo")
                              .doc(widget.id)
                              .delete();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
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
                  hintText: "Update Title",
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
                  maxLines: 4,
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
                                ? const Color.fromARGB(255, 133, 101, 178)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
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
                SizedBox(
                  height: height / 2.75,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("Todo")
                              .doc(widget.id)
                              .update({
                            "title": titlecontroller.text,
                            "discription": discriptioncontroller.text,
                            "category": selectedCateg,
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 133, 101, 178),
                        ),
                        child: const Text(
                          "Update",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
