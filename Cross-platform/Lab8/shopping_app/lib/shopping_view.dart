import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping_app/crud_interface.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/shopping_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({Key? key}) : super(key: key);

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  final nameController = TextEditingController();
  final costController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Список покупок"),
      ),
      body: ValueListenableBuilder<Box<ShoppingModel>>(
        valueListenable: purchaseBox.listenable(),
        builder: (context, box, _) {
          List<ShoppingModel> shoppingList = CRUDInterface.readAllElements();
          return ListView.builder(
              itemCount: shoppingList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Text("${shoppingList[i].cost} ₽"),
                  title: Text(shoppingList[i].name.toString()),
                  subtitle: Text(shoppingList[i].createdDate.toString()),
                  onLongPress: () {  CRUDInterface.deleteElement(shoppingList[i]);  },
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                              child: SizedBox(
                                  height: 200,
                                  child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                          children: [
                                            TextField(
                                              decoration: const InputDecoration(label: Text("Название товара")),
                                              controller: nameController,
                                            ),
                                            TextField(
                                              decoration: const InputDecoration(label: Text("Стоимость")),
                                              controller: costController,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  final name = nameController.text;
                                                  final cost = costController.text;
                                                  CRUDInterface.updateElement(shoppingList[i], name, double.parse(cost));
                                                  Navigator.pop(context);
                                                  },
                                                child: const Text("Сохранить")
                                            )
                                      ])
                                  )
                              )
                          );
                        });
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                    child: SizedBox(
                        height: 200,
                        child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(children: [
                              TextField(
                                decoration: const InputDecoration(
                                    label: Text("Название товара")),
                                controller: nameController,
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                    label: Text("Стоимость")),
                                controller: costController,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    final name = nameController.text;
                                    final cost = costController.text;
                                    CRUDInterface.createElement(
                                        name, double.parse(cost));
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Сохранить"))
                            ]))));
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    costController.dispose();
    purchaseBox.close();
    super.dispose();
  }
}
