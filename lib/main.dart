import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'entities/product.dart';
import 'model/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider.value(
        value: ProductModel(),
        child: const MyHomePage(title: 'e-Commerce'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<ProductModel>(builder: (context, ProductModel model, _) {
        if (model.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                primary: false,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ...model.getAllCategoryList.map((c) => TextButton(
                            onPressed: () {
                              model.filterByCategory(c.id);
                              model.selectedFilter = c.id;
                            },
                            child: Text(
                              c.toString(),
                              style: TextStyle(
                                color: (model.selectedFilter == c.id)
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          )),
                      TextButton(
                        onPressed: () {
                          model.filterByCategory(null);
                        },
                        child: Text('Show All',
                            style: TextStyle(
                              color: (model.selectedFilter == null)
                                  ? Colors.blue
                                  : Colors.black,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(10),
                itemCount: model.getAllProductsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (BuildContext context, int index) {
                  Product p = model.getAllProductsList[index];

                  return Material(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(p.image),
                                            fit: BoxFit.cover))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(p.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text("Rs.${p.price}")
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  p.favorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: p.favorite ? Colors.red : Colors.black,
                                ),
                                onPressed: () {
                                  model.toggleFavorite(p);
                                },
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
