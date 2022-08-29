import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/add_other_category_bloc/add_other_category_bloc.dart';
import '../controllers/month_selected_bloc/month_selected_bloc.dart';
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
  String? myCategory, month, url, name;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void addNewCat() {
    BlocProvider.of<AddOtherCategoryBloc>(context)
        .add(AddNewCategory(data: textEditingController.text));
    textEditingController.clear();
  }

  void reset() {
    name = "";
    url = null;
    month = null;
    BlocProvider.of<MonthSelectedBloc>(context).add(RemoveOccasion());
    BlocProvider.of<AddCategoryBloc>(context)
        .add(OnSubmitCategory(data: myCategory ?? ""));
    BlocProvider.of<AddOtherCategoryBloc>(context).add(SubmitNewCategory());
    BlocProvider.of<UploadImageBloc>(context).add(OnSubmit());
    BlocProvider.of<UploadDataFireStoreBloc>(context).add(OnSubmitForUpload());
    myCategory = null;
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
                return Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .4,
                      width: MediaQuery.of(context).size.width * .5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: networkImages(state.url, null),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          try {
                            await FirebaseStorage.instance
                                .ref()
                                .child("image/${state.name}")
                                .delete();
                            BlocProvider.of<UploadImageBloc>(context)
                                .add(OnRemoveImage());
                            url = null;
                            name = null;
                          } catch (e) {
                            alertDialog(context, "Not Able to remove Image :(");
                          }
                        },
                        icon: const Icon(Icons.cancel_outlined,
                            color: Colors.red))
                  ],
                );
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
            BlocBuilder<AddCategoryBloc, AddCategoryState>(builder: (_, state) {
              if (state is AddCategoryInitial) {
                return const CircularProgressIndicator.adaptive();
              } else if (state is AddCategoryLoaded) {
                myCategory = state.select;
                return DropdownButton(
                  value: state.select,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: state.data
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    BlocProvider.of<AddCategoryBloc>(context)
                        .add(OnSelectCategory(myCategory: value.toString()));
                    if (value == "occasion") {
                      BlocProvider.of<MonthSelectedBloc>(context)
                          .add(IsOccasion());
                      BlocProvider.of<AddOtherCategoryBloc>(context)
                          .add(RemoveCategoryField());
                    } else if (value == "other") {
                      BlocProvider.of<MonthSelectedBloc>(context)
                          .add(RemoveOccasion());
                      BlocProvider.of<AddOtherCategoryBloc>(context)
                          .add(ShowTextField());
                    } else {
                      BlocProvider.of<MonthSelectedBloc>(context)
                          .add(RemoveOccasion());
                      BlocProvider.of<AddOtherCategoryBloc>(context)
                          .add(RemoveCategoryField());
                    }
                  },
                );
              } else if (state is AddCategoryError) {
                return Text(TextResources().blocError);
              } else {
                return Text(TextResources().noData);
              }
            }),
            const SizedBox(height: 10),
            BlocBuilder<MonthSelectedBloc, MonthSelectedState>(
                builder: (_, state) {
              if (state is MonthSelectedLoading) {
                month = null;
                return const SizedBox();
              } else if (state is MonthSelectedLoaded) {
                month = state.selected;
                return DropdownButton(
                  value: state.selected,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: state.data
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    BlocProvider.of<MonthSelectedBloc>(context)
                        .add(OnSelectMonth(month: value.toString()));
                  },
                );
              } else if (state is MonthSelectedError) {
                return Text(TextResources().blocError);
              } else {
                return Text(TextResources().noData);
              }
            }),
            BlocBuilder<AddOtherCategoryBloc, AddOtherCategoryState>(
                builder: (_, state) {
              if (state is AddOtherCategoryInitial) {
                return const SizedBox();
              } else if (state is AddOtherCategoryShowTextField) {
                myCategory = null;
                return Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                          cursorColor:
                              BlocProvider.of<DarkModeBloc>(context).isDark
                                  ? ColorResources().focusedBorderTextFieldDark
                                  : ColorResources().focusedBorderTextField,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: TextResources().addCatName,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        BlocProvider.of<DarkModeBloc>(context)
                                                .isDark
                                            ? ColorResources()
                                                .focusedBorderTextFieldDark
                                            : ColorResources()
                                                .focusedBorderTextField)),
                          ),
                          keyboardType: TextInputType.text,
                          onSubmitted: (s) => addNewCat()),
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        minWidth: MediaQuery.of(context).size.width * .5,
                        color: BlocProvider.of<DarkModeBloc>(context).isDark
                            ? ColorResources().colorPickerButtonDark
                            : ColorResources().colorPickerButton,
                        onPressed: () => addNewCat(),
                        child: Text(TextResources().addCatName))
                  ],
                );
              } else if (state is AddOtherCategoryData) {
                myCategory = state.data;
                return InkWell(
                  onTap: () => BlocProvider.of<AddOtherCategoryBloc>(context)
                      .add(RemoveCategory()),
                  child: Chip(
                    elevation: 20,
                    padding: const EdgeInsets.all(8),
                    shadowColor: BlocProvider.of<DarkModeBloc>(context).isDark
                        ? ColorResources().chipShadowDark
                        : ColorResources().chipShadow,
                    label:
                        Text(state.data, style: const TextStyle(fontSize: 20)),
                  ),
                );
              } else if (state is AddOtherCategoryError) {
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
                await alertDialog(
                    context, TextResources().successItemToFireStore);
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
                      if (myCategory == null || url == null) {
                        alertDialog(
                            context,
                            (url == null && myCategory == null)
                                ? TextResources().whenImgCatNotThere
                                : (url == null)
                                    ? TextResources().whenImgNotThere
                                    : TextResources().whenCatNotThere);
                      } else {
                        BlocProvider.of<UploadDataFireStoreBloc>(context).add(
                            UploadData(
                                url: url!,
                                name: name!,
                                category: [myCategory!],
                                months: month ?? ""));
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

Container imageContainer(context, Widget child) => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorResources().uploadImgContainer),
    height: MediaQuery.of(context).size.height * .4,
    width: MediaQuery.of(context).size.width * .5,
    child: child);
