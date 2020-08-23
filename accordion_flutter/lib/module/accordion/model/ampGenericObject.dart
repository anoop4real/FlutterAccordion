enum ObjectType {
  type_category,
  type_product,
  type_subproduct,
}

class AMPGenericObject {
  String identifier = "";
  String name;
  String parentName;
  bool canBeExpanded = false;
  bool isExpanded = false;
  int level;
  int type;
  List<AMPGenericObject> children = List<AMPGenericObject>();
  ObjectType objectType;
}
