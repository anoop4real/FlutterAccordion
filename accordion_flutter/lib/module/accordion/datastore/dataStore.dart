import 'package:accordionflutter/module/accordion/model/ampGenericObject.dart';

class DataStore {
  List<AMPGenericObject> dataRows = List<AMPGenericObject>();

  DataStore() {
    //Initialize with test data
    createTestData();
  }

  // Creates a list of Category objects
  void createTestData() {
    for (var i = 0; i <= 15; i++) {
      AMPGenericObject object = AMPGenericObject();
      object.identifier = 'Category $i';
      object.name = 'Category $i';
      object.parentName = 'No Parent';
      object.isExpanded = false;
      object.level = 0; // For padding or indentation
      object.type = 0;

      if (i.isEven) {
        object.canBeExpanded = true;
      } else {
        object.canBeExpanded = false;
      }
      dataRows.add(object);
    }
  }

  void collapseCellsFromIndexOf(AMPGenericObject object) {
    final index = dataRows.indexOf(object);
    // If no index found then return
    if (index == -1) {
      return;
    }
    final collapseCol = numberOfCellsToBeCollapsed(object);
    // Find the end index by adding the count to start index+1
    final end = index + 1 + collapseCol;
    // Remove all the objects in that range from the main array so that number of rows are maintained properly
    dataRows.removeRange(index+1, end);
    object.isExpanded = false;
  }

  int numberOfCellsToBeCollapsed(AMPGenericObject object) {
    var total = 0;
    if (object.isExpanded) {
      // Set the expanded status to no
      object.isExpanded = false;
      final child = object.children;
      total = child.length;
      // traverse through all the children of the parent and get the count.
      child.forEach((productData) {
        total += numberOfCellsToBeCollapsed(productData);
      });
    }
    return total;
  }

  void fetchChildrenforParentAndExpand(AMPGenericObject parentObject) {
    var index = dataRows.indexOf(parentObject);
    if (index == -1) {
      return;
    }
    // If canBeExpanded then only we need to create child
    if (parentObject.canBeExpanded) {
      parentObject.isExpanded = true;

      if (parentObject.children.isNotEmpty) {
        parentObject.children.forEach((prodData) {
          dataRows.insert(index + 1, prodData);
          index += 1;
        });
        return;
      }
      // The children property of the parent will be filled with this objects
      // If the parent is of type Category, then fetch the Product.
      if (parentObject.type == 0) {
        for (var i = 0; i <= 10; i++) {
          AMPGenericObject object = AMPGenericObject();
          object.identifier = parentObject.identifier + 'Product $i';
          object.name = 'Product $i';
          object.level = parentObject.level + 1;
          object.parentName = "Child $i of Level ${object.level}";
          // This is used for setting the indentation level so that it look like an accordion view
          object.type = 1; //OBJECT_TYPE_Product;
          object.isExpanded = false;

          if (i % 2 == 0) {
            object.canBeExpanded = true;
          } else {
            object.canBeExpanded = false;
          }
          parentObject.children.add(object);
          dataRows.insert(index + 1, object);
          index += 1;
        }
      } else {
        for (var i = 0; i <= 10; i++) {
          AMPGenericObject object = AMPGenericObject();
          object.identifier = parentObject.identifier + 'SubProduct $i';
          object.name = 'SubProduct $i';
          object.level = parentObject.level + 1;
          object.parentName = "Child $i of Level ${object.level}";
          // This is used for setting the indentation level so that it look like an accordion view
          object.type = 1; //OBJECT_TYPE_Product;
          object.isExpanded = false;
          // SubProducts need not expand
          object.canBeExpanded = false;
          parentObject.children.add(object);
          dataRows.insert(index + 1, object);
          index += 1;
        }
      }
    }
  }

  int numberOfItems() {
    return this.dataRows.length;
  }

  AMPGenericObject itemAt(int index) {
    return this.dataRows[index];
  }
}
