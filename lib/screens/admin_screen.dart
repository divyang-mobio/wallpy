import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/category_bloc/category_bloc.dart';
import '../widgets/alert_box.dart';
import '../controllers/add_category_bloc/add_category_bloc.dart';
import '../controllers/upload_data_fireStore_bloc/upload_data_fire_store_bloc.dart';
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
  List<String> myCategory = [];
  String? url;
  String? name;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void testText() {
    if (textEditingController.text.contains(RegExp('^[a-zA-Z]+'))) {
      myCategory.add(textEditingController.text);
      callBloc(context, myCategory);
      textEditingController.clear();
    }
  }

  void reset() {
    myCategory = [];
    name = "";
    url = null;
    callBloc(context, []);
    BlocProvider.of<UploadImageBloc>(context).add(OnSubmit());
    BlocProvider.of<UploadDataFireStoreBloc>(context).add(OnSubmitForUpload());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TextResources().adminAppTitle)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            const SizedBox(height: 10),
            BlocBuilder<UploadImageBloc, UploadImageState>(builder: (_, state) {
              if (state is UploadImageInitial) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<UploadImageBloc>(context)
                        .add(OnButtonClick());
                    uploadImage(context);
                  },
                  child: imageContainer(context,
                      Center(child: Text(TextResources().uploadImgButton))),
                );
              } else if (state is OnUploadButtonClick) {
                return imageContainer(
                    context, Center(child: Text(TextResources().uploadingImg)));
              } else if (state is UploadImageLoaded) {
                url = state.url;
                name = state.name;
                return SizedBox(
                    height: MediaQuery.of(context).size.height * .4,
                    width: MediaQuery.of(context).size.width * .5,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: networkImages(state.url, null)));
              } else if (state is UploadImageError) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<UploadImageBloc>(context)
                        .add(OnButtonClick());
                    uploadImage(context);
                  },
                  child: imageContainer(context,
                      Center(child: Text(TextResources().errorAtUploadImg))),
                );
              } else {
                return imageContainer(
                    context, Center(child: Text(TextResources().noData)));
              }
            }),
            const SizedBox(height: 10),
            // BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
            //   if (state is CategoryLoading) {
            //     return const CircularProgressIndicator.adaptive();
            //   } else if (state is CategoryLoaded) {
            //     return DropdownButton(
            //       value: "select",
            //       icon: const Icon(Icons.keyboard_arrow_down),
            //       items: state.data
            //           .map((e) => DropdownMenuItem(
            //                 value: e["name"],
            //                 child: Text(e['name']
            //                     .toString()
            //                     .toUpperCase()),
            //               ))
            //           .toList(),
            //       onChanged: (value) {},
            //     );
            //   } else if (state is CategoryError) {
            //     return Center(child: Text(TextResources().blocError));
            //   } else {
            //     return Center(child: Text(TextResources().noData));
            //   }
            // }),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: TextField(
                cursorColor: BlocProvider.of<DarkModeBloc>(context).isDark
                    ? ColorResources().focusedBorderTextFieldDark
                    : ColorResources().focusedBorderTextField,
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: TextResources().addCatName,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: BlocProvider.of<DarkModeBloc>(context).isDark
                              ? ColorResources().focusedBorderTextFieldDark
                              : ColorResources().focusedBorderTextField)),
                ),
                keyboardType: TextInputType.text,
                onSubmitted: (s) => testText(),
              ),
            ),
            const SizedBox(height: 10),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: MediaQuery.of(context).size.width * .5,
                color: BlocProvider.of<DarkModeBloc>(context).isDark
                    ? ColorResources().colorPickerButtonDark
                    : ColorResources().colorPickerButton,
                onPressed: () => testText(),
                child: Text(TextResources().addCatName)),
            const SizedBox(height: 10),
            BlocBuilder<AddCategoryBloc, AddCategoryState>(builder: (_, state) {
              if (state is AddCategoryInitial) {
                return const SizedBox();
              } else if (state is AddCategoryLoaded) {
                myCategory = state.myCategory;
                return Wrap(spacing: 5, runSpacing: 5, children: [
                  for (var i in state.myCategory)
                    InkWell(
                      onTap: () {
                        myCategory.remove(i);
                        callBloc(context, myCategory);
                      },
                      child: Chip(
                        elevation: 20,
                        padding: const EdgeInsets.all(8),
                        shadowColor:
                            BlocProvider.of<DarkModeBloc>(context).isDark
                                ? ColorResources().chipShadowDark
                                : ColorResources().chipShadow,
                        label: Text(i, style: const TextStyle(fontSize: 20)),
                      ),
                    ),
                ]);
              } else if (state is AddCategoryError) {
                return Text(TextResources().blocError);
              } else {
                return Text(TextResources().noData);
              }
            }),
            const SizedBox(height: 10),
            BlocConsumer<UploadDataFireStoreBloc, UploadDataFireStoreState>(
                listener: (context, state) async {
              if (state is UploadDataFireStoreSuccess) {
                reset();
                await alertDialog(context, TextResources().successDownloaded);
              }
            }, builder: (context, state) {
              if (state is UploadDataFireStoreInitial) {
                return MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    minWidth: MediaQuery.of(context).size.width * .5,
                    color: BlocProvider.of<DarkModeBloc>(context).isDark
                        ? ColorResources().colorPickerButtonDark
                        : ColorResources().colorPickerButton,
                    onPressed: () {
                      if (myCategory.isEmpty || url == null) {
                        alertDialog(
                            context,
                            (url == null && myCategory.isEmpty)
                                ? TextResources().whenImgCatNotThere
                                : (url == null)
                                    ? TextResources().whenImgNotThere
                                    : TextResources().whenCatNotThere);
                      } else {
                        BlocProvider.of<UploadDataFireStoreBloc>(context).add(
                            UploadData(
                                url: url!, name: name!, category: myCategory));
                      }
                    },
                    child: Text(TextResources().submitItemToFireStore));
              } else if (state is UploadDataFireStoreProcess ||
                  state is UploadDataFireStoreSuccess) {
                return const CircularProgressIndicator.adaptive();
              } else if (state is UploadDataFireStoreError) {
                return Text(TextResources().blocError);
              } else {
                return Text(TextResources().noData);
              }
            }),
          ]),
        ),
      ),
    );
  }
}

void callBloc(context, List<String> data) =>
    BlocProvider.of<AddCategoryBloc>(context)
        .add(AddCategory(myCategory: data));

Container imageContainer(context, Widget child) => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorResources().uploadImgContainer),
    height: MediaQuery.of(context).size.height * .4,
    width: MediaQuery.of(context).size.width * .5,
    child: child);
