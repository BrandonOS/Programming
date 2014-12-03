with Ada.Text_IO; use Ada.Text_IO;
with Unchecked_Conversion;

generic
   type item is private;
   arrayMax: integer;
package Generics is 
   procedure setMax(x: in integer);
   
   procedure Push(myItem: in item; err: out boolean);
   procedure Pop(myItem: out item; err: out boolean);
   
   function intToChar is new Unchecked_Conversion(Integer, Character);
   function charToInt is new Unchecked_Conversion(Character, Integer);
   package IntIO is new Ada.Text_IO.Integer_IO(integer); use IntIO;

   max: integer;
   top: integer := 0;
   err: boolean;
end Generics;