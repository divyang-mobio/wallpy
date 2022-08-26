import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/add_category_bloc/add_category_bloc.dart';
import '../resources/resources.dart';
import '../widgets/network_image.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../controllers/upload_image_bloc/upload_image_bloc.dart';
import '../widgets/admin_upload_image.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController textEditingController = TextEditingController();
  List<String>? myCategory;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            BlocBuilder<UploadImageBloc, UploadImageState>(builder: (_, state) {
              if (state is UploadImageInitial) {
                return const SizedBox();
              } else if (state is UploadImageLoaded) {
                return SizedBox(
                    height: 150,
                    width: 150,
                    child: networkImages(state.url, null));
              } else if (state is UploadImageError) {
                return Text(TextResources().blocError);
              } else {
                return Text(TextResources().noData);
              }
            }),
            MaterialButton(
                onPressed: () {
                  uploadImage(context);
                },
                child: BlocBuilder<UploadImageBloc, UploadImageState>(builder: (_, state) {
                  if (state is UploadImageInitial) {
                    return Text("test Image");
                  } else if (state is UploadImageLoaded) {
                    return Text("Upload Image");
                  } else if (state is UploadImageError) {
                    return Text(TextResources().blocError);
                  } else {
                    return Text(TextResources().noData);
                  }
                }), ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: TextField(
                cursorColor: BlocProvider.of<DarkModeBloc>(context).isDark
                    ? ColorResources().focusedBorderTextFieldDark
                    : ColorResources().focusedBorderTextField,
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: "Add Category",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: BlocProvider.of<DarkModeBloc>(context).isDark
                              ? ColorResources().focusedBorderTextFieldDark
                              : ColorResources().focusedBorderTextField)),
                ),
                keyboardType: TextInputType.text,
                onSubmitted: (s) {
                  myCategory?.add(textEditingController.text);
                  callBloc(context, myCategory ?? []);
                  textEditingController.clear();
                },
              ),
            ),
            MaterialButton(
                onPressed: () {
                  myCategory?.add(textEditingController.text);
                  callBloc(context, myCategory ?? []);
                  textEditingController.clear();
                },
                child: const Text("Add Category")),
            BlocBuilder<AddCategoryBloc, AddCategoryState>(builder: (_, state) {
              if (state is AddCategoryInitial) {
                return const SizedBox();
              } else if (state is AddCategoryLoaded) {
                myCategory = state.myCategory;
                return Wrap(spacing: 5, runSpacing: 5, children: [
                  for (var i in state.myCategory)
                    Chip(
                      elevation: 20,
                      padding: const EdgeInsets.all(8),
                      shadowColor: Colors.black,
                      label: Text(i, style: const TextStyle(fontSize: 20)),
                    ),
                ]);
              } else if (state is AddCategoryError) {
                return Text(TextResources().blocError);
              } else {
                return Text(TextResources().noData);
              }
            }),
            MaterialButton(onPressed: () {}, child: const Text("Submit")),
          ]),
        ),
      ),
    );
  }
}

void callBloc(context, List<String> data) =>
    BlocProvider.of<AddCategoryBloc>(context)
        .add(AddCategory(myCategory: data));
