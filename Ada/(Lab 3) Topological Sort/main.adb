with Ada.Text_IO; use Ada.Text_IO;
WITH Sort;

procedure main is

   Size : Integer;

   PACKAGE MyInt_IO IS NEW Ada.Text_IO.Integer_IO(Integer);

   TYPE CharType IS (Q, A, B, C, D, E, F, G, H, I, J, K, L);
   PACKAGE Char_IO IS NEW Ada.Text_IO.Enumeration_IO(CharType);

   PROCEDURE put(X: IN CharType) IS
   BEGIN
       Char_IO.Put(X);
   END put;
   PROCEDURE get(X: OUT CharType) IS
   BEGIN
       Char_IO.Get(X);
   END get;

   PROCEDURE Get(X: OUT Integer) IS
   BEGIN
      MyInt_IO.Get(X);
   END Get;
   PROCEDURE put(X: IN Integer) IS
   BEGIN
      MyInt_IO.put(X);
   END put;

BEGIN

   Put("1. Integer Topological Sort.");New_Line;
   Put("2. Character Topological Sort.");New_Line;
   put("Select a type of sort: ");
   Get(Size);New_Line;


   IF Size = 1 THEN
      Get(Size);
      NumberSort:
         declare
         PACKAGE NumSort IS NEW Sort(Integer, get, put, Size); USE NumSort;
      BEGIN
         Put("Begin Integer sort");New_Line;
         Put("Enter number of items: ");

         ReadElement;

         put("List to process: ");New_Line;
         printList;

         TopoSort;
         Result;
      END NumberSort;
      -- End Number sort
  ELSE
      Put("Begin Character sort");New_Line;
      Put("Enter number of items: ");
      Get(Size);
      CharacterSort:
         declare
         PACKAGE CharSort IS NEW Sort(CharType, get, put, Size); USE CharSort;
      BEGIN
         ReadElement;

         put("List to process: ");New_Line;
         printList;

         TopoSort;

         Result;

      END CharacterSort;
      -- End Character Sort

   END IF;

END main;
