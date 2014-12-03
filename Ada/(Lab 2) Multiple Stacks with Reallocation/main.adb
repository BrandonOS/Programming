WITH Ada.Text_IO;
USE Ada.Text_IO;
WITH Stack;

PROCEDURE Main IS

   PACKAGE IntIO IS NEW Ada.Text_IO.Integer_IO(Integer);      USE IntIO;
   PACKAGE FloatIO IS NEW Ada.Text_IO.Float_IO(Float);         USE FloatIO;

   TYPE Names IS ( Burris, Rios, Cooper, Bennett, Garza, Morgan,
          McLeod, Chen, Wills, McGuire, Cho, Hall, Ji, Withrow, Keo, Ihezukwu,
          Davies, Smith, Sparks, Vieira, Bing, Gurung, Varol);

   PACKAGE NamesIO IS NEW Ada.Text_IO.Enumeration_IO(Names);  USE NamesIO;

   TYPE MonthName IS
         (January, February, March, April,
          May, June, July, August,
          September, October, November, December);
   TYPE Date IS
      RECORD
         Month : MonthName;
         Day   : Integer RANGE 1 .. 31;
         Year  : Integer;
      END RECORD;

   PACKAGE MonthIO IS NEW Ada.Text_IO.Enumeration_IO(MonthName);   USE MonthIO;

   NumS   : Float;
   M      : Float;
   Lo     : Float;
   Input  : Integer RANGE 1 .. 3 := 1;
   StackType  : Integer RANGE 1 .. 2;
   Status : Boolean              := True;

   PROCEDURE Print (
         X : Names) IS
   BEGIN
      NamesIO.Put(X);
   END Print;
   PROCEDURE Prin (
         Y : Date) IS
   BEGIN
      MonthIO.Put(Y.Month);
   END Prin;

BEGIN

   Put("What do you want to create: ");   New_Line(2);
   Put(" Names Stack = [1] "); New_Line;
   Put(" Dates Stack = [2] "); New_Line;
   put("Make your selection: ");
   Get(StackType);
   New_Line;

   CASE StackType IS
      WHEN 1 =>
         Put("--------------------");New_Line;
         Put(" Names Stack");New_Line;
         put("--------------------");
         New_Line(2);
         Put("Enter the size of the stack: "); Get(M);
         Put("  Stack of size: "); Put( Integer(M),2);
         New_Line(2);

         Put("Enter number of stacks: "); Get(NumS);
         Put("  ");Put(Integer(NumS),2);   Put(" total Stacks.");
         New_Line(2);

         Put("Select a starting point: ");
         Get(Lo);

         Put("  Starting point is: "); Put(Integer(Lo),1);
         New_Line(2);

         NameStack:
            DECLARE
            PACKAGE MyStack IS NEW Stack(NumS, M, Lo, Names, Print);
            USE MyStack;
            Item : Names;
         BEGIN
            WHILE Input /= 3 LOOP
               Put("Which function would you like: ");          New_Line;
               Put(" 1. Push.");           New_Line;
               Put(" 2. Pop.");        New_Line;
               Put(" 3. Terminate! ");    New_Line;
               Put("Make your selection: ");        Get(Input);

               Put("Option "); Put(Input,1); Put(" was selected.");
               New_Line(2);

               CASE Input IS
                  WHEN 1 =>
                     Put("Enter a name to push: ");
                     Get(Item);
                     Push(Item, Status);
                     IF Status THEN
                        Put("Name '");     Put(Item);
                        Put("' succesfully Pushed.");
                        New_Line(2);
                     ELSE
                        Put("Not enough memory. Come back with more space.");
                        New_Line(2);
                        Input := 3;
                     END IF;
                  WHEN 2=>
                     Pop(Item, Status);
                     IF Status THEN
                        Put("Name '"); Put(Item);
                        Put("' succesfully popped.");
                        New_Line(2);
                     ELSE
                        Put("Underflow!");
                        New_Line(2);
                     END IF;
                  WHEN 3 =>
                     Put("Adios!");
               END CASE;
            END LOOP;
         END NameStack;

         WHEN 2 =>

         Put("--------------------");New_Line;
         Put(" Dates Stack");  New_Line;
         Put("--------------------"); New_Line(2);


         Put("Enter the size of the stack: ");      Get(M);
         Put("  Stack of size: ");   Put( Integer(M),2);
         New_Line(2);

         Put("How many Stacks? ");
         Get(NumS);

         Put(Integer(NumS),2);     Put(" total Stacks.");
         New_Line(2);

         Put("Starting point? ");     Get(Lo);
         Put("  starting point is: ");     Put(Integer(Lo),1);
         New_Line(2);

         DateStack:
            DECLARE
            PACKAGE MyStack IS NEW Stack(NumS, M, Lo, Date, Prin);
            USE MyStack;
            Item : Date;
         BEGIN
            WHILE Input /= 3 LOOP
               Put("What do you want to do? ");    New_Line(2);
               Put("1. Push.");    New_Line;
               Put("2. Pop.");     New_Line;
               Put("3. Terminate! ");    New_Line;

               Put("Make your selection: ");
               Get(Input);
               Put("Option ");   Put(Input,1);  Put(" was selected.");
               New_Line(2);

               CASE Input IS
                  WHEN 1 =>
                     Put("Enter the date( Month Day Year): ");
                     Get(Item.Month);
                     Get(Item.Day);
                     Get(Item.Year);

                     Put("Date ");   Put(Item.Month);  Put(", ");   Put(Item.Day,2);

                     Put(" ");   Put(Item.Year,4);  Put(" entered.");  New_Line;
                     Push(Item, Status);
                     IF Status THEN
                        Put("The date  succesfully pushed.");
                        New_Line(2);
                     ELSE
                        Put(
                           "Not enough memory. Come back with more space or dont come at all.");
                        New_Line(2);
                        Input := 3;
                     END IF;
                  WHEN 2=>
                     Pop(Item, Status);
                     IF Status THEN
                        Put("The date'");
                        Put(Item.Month);
                        Put(", ");
                        Put(Item.Day,2);
                        Put(" ");
                        Put(Item.Year,4);
                        Put("' succesfully popped.");
                        New_Line(2);
                     ELSE
                        Put("Underflow!");
                        New_Line(2);
                     END IF;
                  WHEN 3 =>
                     Put("Adios!");
               END CASE;
            END LOOP;
         END DateStack;
   END CASE;
END Main;