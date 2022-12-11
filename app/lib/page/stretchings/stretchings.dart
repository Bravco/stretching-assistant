import 'package:app/model/stretching.dart';
import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

//Data
import 'package:app/data/stretchings.dart';

//Libaries
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

//Widgets
import 'package:app/widget/appbar.dart';

//Pages
import 'package:app/page/stretchings/stretching/stretching.dart';
import 'package:app/page/stretchings/create.dart';

class StretchingsPage extends StatefulWidget {
  const StretchingsPage({Key? key}) : super(key: key);

  @override
  State<StretchingsPage> createState() => _StretchingsPageState();
}

class _StretchingsPageState extends State<StretchingsPage> {
  List<Widget> buildListView(BuildContext context) {
    List<Widget> temp = [];

    temp.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: const [
            Expanded(
              child: Divider(
                thickness: 2,
                color: utils.color0Alt,
                indent: 16,
                endIndent: 16,
              ),
            ),
            Text(
              "PRESETS",
              style: TextStyle(
                color: utils.color0Alt,
                fontWeight: FontWeight.w300,
                fontSize: 28,
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 2,
                color: utils.color0Alt,
                indent: 16,
                endIndent: 16,
              ),
            ),
          ],
        ),
      ),
    );

    for (int i = 0; i < stretchings.length; i++) {
      temp.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StretchingPage(stretchingIndex: i),
                ),
              );
            },
            splashColor: utils.color10Alt,
            child: Ink(
              width: 320,
              height: 160,
              color: utils.color30,
              child: StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: utils.color10,
                                      width: 2,
                                    )),
                                  ),
                                  child: Text(
                                    stretchings[i].title.toUpperCase(),
                                    style: const TextStyle(
                                      color: utils.color0,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${
                                    stretchings[i].stretches <= 10
                                    ? "Short"
                                    : stretchings[i].stretches <= 25
                                      ? "Medium"
                                      : "Long"
                                  } • ${stretchings[i].stretches} stretches",
                                  style: const TextStyle(
                                    color: utils.color0Alt,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Image(
                              image: stretchings[i].logo,
                              width: 104,
                              height: 104,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      );
    }

    temp.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: const [
            Expanded(
              child: Divider(
                thickness: 2,
                color: utils.color0Alt,
                indent: 16,
                endIndent: 16,
              ),
            ),
            Text(
              "CUSTOM",
              style: TextStyle(
                color: utils.color0Alt,
                fontWeight: FontWeight.w300,
                fontSize: 28,
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 2,
                color: utils.color0Alt,
                indent: 16,
                endIndent: 16,
              ),
            ),
          ],
        ),
      ),
    );

    for (int i = 0; i < customStretchings.length; i++) {
      temp.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: FocusedMenuHolder(
            blurBackgroundColor: utils.color60,
            onPressed: () {},
            menuWidth: MediaQuery.of(context).size.width - 32 * 2,
            menuItems: [
              FocusedMenuItem(
                backgroundColor: utils.color30,
                title: const Text(
                  "Edit",
                  style: TextStyle(
                    color: utils.color0Alt,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailingIcon: const Icon(
                  Icons.edit,
                  color: utils.color0Alt,
                ),
                onPressed: () {},
              ),
              FocusedMenuItem(
                backgroundColor: utils.color10Alt,
                title: const Text(
                  "Delete",
                  style: TextStyle(
                    color: utils.color0Alt,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailingIcon: const Icon(
                  Icons.delete,
                  color: utils.color0Alt,
                ),
                onPressed: () {
                  setState(() {
                    CustomStretching deletedItem = customStretchings.removeAt(i);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text("Deleted ${deletedItem.title}"),
                        action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            setState(() => customStretchings.insert(i, deletedItem));
                          },
                        ),
                      ),
                    );
                  });
                },
              ),
            ],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StretchingPage(isCustom: true,stretchingIndex: i),
                  ),
                );
              },
              splashColor: utils.color10Alt,
              child: Ink(
                width: 320,
                height: 160,
                color: utils.color30,
                child: StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                        color: utils.color10,
                                        width: 2,
                                      )),
                                    ),
                                    child: Text(
                                      customStretchings[i].title,
                                      style: const TextStyle(
                                        color: utils.color0,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${
                                      customStretchings[i].stretches.length <= 10
                                      ? "Short"
                                      : customStretchings[i].stretches.length <= 25
                                        ? "Medium"
                                        : "Long"
                                    } • ${customStretchings[i].stretches.length} stretches",
                                    style: const TextStyle(
                                      color: utils.color0Alt,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const Image(
                                image: AssetImage("assets/stretchings/karate/logo.png"),
                                width: 104,
                                height: 104,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
        ),
      );
    }

    temp.add(
      IconButton(
        icon: const Icon(
          Icons.add,
          color: utils.color0Alt,
        ),
        iconSize: 40,
        splashColor: utils.color10Alt,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateStretchingPage(),
            ),
          ).then((value) => setState(() {}));
        },
      ),
    );

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPf(title: "Stretchings"),
      body: ListView(
        children: buildListView(context),
      ),
    );
  }
}