import 'package:animeto/bussiness_logic/cubit/filter/filter_cubit.dart';
import 'package:animeto/constants/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

TextStyle? normalStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

class BottomSheetModel {
  runBottomSheet({required BuildContext context}) {
    showBottomSheet(context: context, builder: (context) => bottomWidget());
  }
}

class Drop extends StatefulWidget {
  List<String> values = [];
  String? itemValue;
  void Function(String?)? onChanged;
  Drop(
      {super.key,
      required this.values,
      required this.itemValue,
      required this.onChanged});

  @override
  State<Drop> createState() => _DropState();
}

class _DropState extends State<Drop> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: widget.itemValue,
        items: widget.values
            .map(
              (String e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: normalStyle,
                ),
              ),
            )
            .toList(),
        onChanged: widget.onChanged);
  }
}

class bottomWidget extends StatefulWidget {
  const bottomWidget({super.key});

  @override
  State<bottomWidget> createState() => _bottomWidgetState();
}

class _bottomWidgetState extends State<bottomWidget> {
  String type = 'all';
  String genres = 'all';
  late int genresIndex = 0;
  String rate = 'all';
  String order = 'all';
  String status = 'all';
  late String queries;
  String filteredby({required List<String> filters}) {
    return filters.where((element) => !element.contains('all')).join('&');
  }

  Row filterRow({required String? filter, required Drop drop}) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          "$filter :",
          style: normalStyle,
        ),
        const Spacer(),
        drop,
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  ElevatedButton button(
      {required String text,
      required double padding,
      required BuildContext context,
      required void Function()? onPressed}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: padding)),
        onPressed: onPressed,
        child: Text(text));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        filterRow(
            filter: filtersLists.filterKeys[0],
            drop: Drop(
              itemValue: type,
              values: filtersLists.filterByType,
              onChanged: (p0) {
                setState(() {
                  type = p0!;
                });
              },
            )),
        filterRow(
            filter: filtersLists.filterKeys[1],
            drop: Drop(
              itemValue: genres,
              values: filtersLists.filterByGenres,
              onChanged: (p0) {
                setState(() {
                  genres = p0!;
                  genresIndex = filtersLists.filterByGenres.indexOf(genres);
                });
              },
            )),
        filterRow(
            filter: filtersLists.filterKeys[2],
            drop: Drop(
              itemValue: rate,
              values: filtersLists.filterByRate,
              onChanged: (p0) {
                setState(() {
                  rate = p0!;
                });
              },
            )),
        filterRow(
            filter: filtersLists.filterKeys[3],
            drop: Drop(
              itemValue: order,
              values: filtersLists.filterByOrder,
              onChanged: (p0) {
                setState(() {
                  order = p0!;
                });
              },
            )),
        filterRow(
            filter: filtersLists.filterKeys[4],
            drop: Drop(
              itemValue: status,
              values: filtersLists.filterByStatus,
              onChanged: (p0) {
                setState(() {
                  status = p0!;
                });
              },
            )),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            button(
                text: "Reset",
                padding: 40,
                context: context,
                onPressed: () {
                  BlocProvider.of<FilterCubit>(context)
                      .filterAnimes(filter: "");
                  Navigator.of(context).pop();
                }),
            button(
              text: "Filter",
              padding: 80,
              context: context,
              onPressed: () {
                queries = filteredby(filters: [
                  '${filtersLists.filterKeys[0]}=$type',
                  '${filtersLists.filterKeys[1]}=$genresIndex',
                  '${filtersLists.filterKeys[2]}=$rate',
                  '${filtersLists.filterKeys[3]}=$order',
                  '${filtersLists.filterKeys[4]}=$status',
                ]);

                print(queries);
                BlocProvider.of<FilterCubit>(context)
                    .filterAnimes(filter: queries);
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    );
  }
}
