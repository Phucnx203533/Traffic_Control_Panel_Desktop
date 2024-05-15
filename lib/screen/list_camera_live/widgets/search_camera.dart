import 'package:flutter/material.dart';


class SearchCamera extends StatelessWidget {
  const SearchCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child:
          SizedBox(
            height: 64,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:24,
                    vertical: 14,
                  ),
                  child: Icon(
                    Icons.search,
                  ),
                ),
                hintText: "Tìm kiếm theo id của camera",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  borderSide: const BorderSide(
                    color: Color(0xFF0D0D26),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  borderSide: const BorderSide(color: Color(0xFFF2F2F3)),
                ),
                filled: true,
                fillColor: Color(0xFFF2F2F3),
              ),
            ),
          ),
        ),
        // HorizontalSpace(value: 16, ctx: context),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.filter_alt_outlined,
          ),
        ),
      ],
    );
  }
}