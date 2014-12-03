GENERIC
   TYPE SortElement IS PRIVATE;
   WITH PROCEDURE getItem(Job: Out SortElement);
   WITH PROCEDURE printItem(Job: In SortElement);
   S: Integer;
PACKAGE Sort IS
   PROCEDURE TopoSort;
   PROCEDURE GetElement(X: OUT SortElement; Y: OUT SortElement);
   PROCEDURE Printlist;
   PROCEDURE Result;
   PROCEDURE ReadElement;
END Sort;