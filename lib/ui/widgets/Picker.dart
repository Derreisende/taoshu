import 'dart:convert';

import 'package:booksea/ui/pages/cart/cart_controller.dart';
import 'package:booksea/ui/pages/category/category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:get/get.dart';
//import 'package:percentage_flutter/config/city.dart';


 double _kPickerSheetHeight = Get.height/2.7;
 double _kPickerItemHeight = 36.0.px;

typedef StringClickCallback = void Function(int selectIndex,Object selectStr);
typedef ArrayClickCallback = void Function( List<int> selecteds,List<dynamic> strData);
typedef PickerConfirmCityCallback = void Function(
    List<String> stringData, List<int> selecteds);

class PickHelper {
  ///普通简易选择器
  static void openSimpleDataPicker<T>(
      BuildContext context, {
        @required List<T> list,
        String title,  //选择器标题
        @required T value,
        PickerDataAdapter adapter,
        @required StringClickCallback onConfirm,
      }) {
    var incomeIndex = 0;
    if (list != null) {
      for (int i = 0; i < list.length; i++) {
        if (list[i] == value) {
          incomeIndex = i;
          break;
        }
      }
    }
    openModalPicker(context,
        adapter: adapter ??
            PickerDataAdapter(
              pickerdata: list,
              isArray: false,
            ),
        onConfirm: (Picker picker, List<int> selecteds){
          onConfirm(selecteds[0],list[selecteds[0]]);
        },
        selecteds: [incomeIndex],
        title: title);
  }

  ///数字选择器
  static void openNumberPicker(
      BuildContext context, {
        String title,
        List<NumberPickerColumn> datas,
        NumberPickerAdapter adapter,
        @required PickerConfirmCallback onConfirm,
      }) {
    openModalPicker(context,
        adapter: adapter ?? NumberPickerAdapter(data: datas ?? []),
        title: title,
        onConfirm: onConfirm);
  }

  ///日期选择器
  // static void openDateTimePicker(
  //     BuildContext context, {
  //       String title,
  //       DateTime maxValue,
  //       DateTime minValue,
  //       DateTime value,
  //       DateTimePickerAdapter adapter,
  //       @required PickerConfirmCallback onConfirm,
  //     }) {
  //   openModalPicker(context,
  //       adapter: adapter ??
  //           DateTimePickerAdapter(
  //               type: PickerDateTimeType.kYMD,
  //               isNumberMonth: true,
  //               yearSuffix: "年",
  //               maxValue: maxValue ?? DateUtil.after(year: 20),
  //               minValue: minValue ?? DateUtil.before(year: 100),
  //               value: value ?? DateTime.now(),
  //               monthSuffix: "月",
  //               daySuffix: "日"),
  //       title: title,
  //       onConfirm: onConfirm);
  // }


  ///地址选择器
  static void openCityPicker(BuildContext context,
      { String title = "",
        @required PickerConfirmCityCallback onConfirm,
        String selectCity=""}) async{
    var address = await rootBundle.loadString('assets/eAddress.json');
    var CityData = json.decode(address);
    var proIndex = 0;
    var cityIndex = 0;
    openModalPicker(context,
        adapter: PickerDataAdapter(
            data:List<PickerItem>.from(CityData.asMap().keys.map((provincePos) {
              var province = CityData[provincePos];
              //省份
              String provin = province['province'].substring(0,province['province'].length-1);
              List cities = province['cities'];
              return PickerItem(
                  text: Container(
                      alignment: Alignment.center,
                      child: Text(provin,style: TextStyle(fontSize: 14.px))),
                  value: provin,
                  children: List<PickerItem>.from(
                      cities.asMap().keys.map((cityPos) {
                        //城市
                        var city=cities[cityPos];
                        String cityStr = city['city'].substring(0,city['city'].length-1);
                        if(city['city'] == selectCity){
                          proIndex=provincePos;
                          cityIndex=cityPos;
                        }
                        return PickerItem(text: Container(
                            alignment: Alignment.center,
                            child: Text(cityStr,style: TextStyle(fontSize: 14.px),)));
                      })
                  )
              );
            })
            )
        ),
        title: title,
        onConfirm: (picker, selecteds) {
          var p = CityData[selecteds[0]];
          List cities = p['cities'];
          onConfirm([p['province'], cities[selecteds[1]]['city']], selecteds);
        },
        selecteds: [proIndex,cityIndex]);
  }

  // 图书分类
  static void openCategoryPicker(BuildContext context,
      { String title = "",
        @required PickerConfirmCityCallback onConfirm,
        String selectCategory=""}) async{
    CategoryController cateCtl = Get.find<CategoryController>();
    List categories = cateCtl.category;
    var firstIndex = 0;
    var secondIndex = 0;
    openModalPicker(context,
        adapter: PickerDataAdapter(
            data:List<PickerItem>.from(categories.asMap().keys.map((cateFirst) {
              //分类项
              var category = categories[cateFirst];
              List secondCategory = category.secondCategory;
              return PickerItem(
                  text: Container(
                      alignment: Alignment.center,
                      child: Text(category.firstCategory,style: TextStyle(fontSize: 14.px))),
                  value: category.firstCategory,
                  children: List<PickerItem>.from(
                      secondCategory.asMap().keys.map((cateSecond) {
                        //城市
                        var secondCate=secondCategory[cateSecond];
                        if(secondCate.cateName == selectCategory){
                          firstIndex=cateFirst;
                          secondIndex=cateSecond;
                        }
                        return PickerItem(text: Container(
                            alignment: Alignment.center,
                            child: Text(secondCate.cateName,style: TextStyle(fontSize: 14.px),)));
                      })
                  )
              );
            })
            )
        ),
        title: title,
        onConfirm: (picker, selecteds) {
          var p = categories[selecteds[0]];
          List secondCategory = p.secondCategory;
          onConfirm([p.firstCategory, secondCategory[selecteds[1]].cateName], selecteds);
        },
        selecteds: [firstIndex,secondIndex]);
  }

  static void openModalPicker(
      BuildContext context, {
        @required PickerAdapter adapter,  //选项数据
        String title,           //选择器标题
        List<int> selecteds,    //选中项序号
        @required PickerConfirmCallback onConfirm,  //确认回调
      }) {
    new Picker(
      adapter: adapter,
      title: new Text(title ?? ""),
      selecteds: selecteds,
      cancel: buildHeadText("取消", (){
        Get.back();
        FocusManager.instance.primaryFocus.unfocus();
      }),
      confirmText: "确定",
      cancelTextStyle: TextStyle(color: Colors.black,fontSize: 16.0.px),
      confirmTextStyle: TextStyle(color: Colors.black,fontSize: 16.0.px),
      textAlign: TextAlign.center,
      itemExtent: _kPickerItemHeight,  //选项的高度
      height: _kPickerSheetHeight,     //选择器的高度
      selectedTextStyle: TextStyle(color: Colors.black,fontSize: 18.px),
      onConfirm: onConfirm
    ).showModal(context);
  }
}

Widget buildHeadText(String text,Function callback){
  return TextButton(
      onPressed: callback,
      child: Text(text,style: TextStyle(fontSize: 16.px),),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          //默认状态使用灰色
          return Colors.black;
        },
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //默认不使用背景颜色
          return Colors.transparent;
        }),
        overlayColor: MaterialStateProperty.all(Colors.transparent)
      ),
  );
}