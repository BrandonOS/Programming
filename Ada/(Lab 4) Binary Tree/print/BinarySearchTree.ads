with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

PACKAGE BinarySearchTree IS

   TYPE St10 IS NEW String(1..10);
   TYPE BSTreePt IS PRIVATE;

   TYPE Names IS (Burris, Sewell, Lee, Vanek, Hall, Buck, Morgan, Carazo, Rios, Ryba, Caldwell, Montes, Houck, Sodmann, ZRoot);
   PACKAGE NamesIO IS NEW Ada.Text_IO.Enumeration_IO(Names); USE NamesIO;

   PROCEDURE DeleteRandomNode(pt: IN BSTreePt);
   PROCEDURE FindCustomerIterative(Name: IN Names; pt: out BSTreePt; Status: OUT Boolean);
   PROCEDURE FindCustomerRecursive(Root: IN BSTreePt; Name: IN Names; pt: out BSTreePt; Status: OUT Boolean);
   PROCEDURE InsertBinarySearchTree(Root: IN OUT BSTreePt; Name: IN Names; Phone: IN St10);
   PROCEDURE PreOrder(Pt: IN BSTreePt);
   PROCEDURE PostOrderIterative(Pt: IN BSTreePt);
   PROCEDURE PostOrderRecursive(Pt: IN BSTreePt);
   PROCEDURE ReverseInOrder(Pt: IN BSTreePt);
   PROCEDURE TraversePt(Pt: IN BSTreePt);

   FUNCTION InOrderSuccessor(Pt: IN BSTreePt) RETURN BSTreePt;
   FUNCTION CustomerName(Pt: IN BSTreePt) RETURN Names;
   FUNCTION CustomerPhone(Pt: IN BSTreePt) RETURN St10;
   FUNCTION CreateTree RETURN BSTreePt;

   procedure push(pt: in BSTreePt);
   procedure pop(pt: out BSTreePt);
   function empty return Boolean;

   PRIVATE TYPE Customer IS RECORD
      Name: Names;
      Phone: St10;
   END RECORD;

   TYPE Node;
   TYPE BSTreept IS ACCESS Node;

   TYPE Node IS RECORD
      Llink, Rlink: BSTreePt;
      Ltag, Rtag: Boolean;
      Info: Customer;
   END RECORD;

   type stack is array(Integer range<>) of BSTreePt;

   PROCEDURE Avail IS NEW Ada.Unchecked_Deallocation(Node, BSTreePT);

END BinarySearchTree;