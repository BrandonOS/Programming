WITH Ada.Text_IO; USE Ada.Text_IO;WITH BinarySearchTree;
USE BinarySearchTree;

PROCEDURE Main IS
   PACKAGE IntIO IS NEW Ada.Text_IO.Integer_IO(Integer);   USE IntIO;
   IP     : Integer  := 1;
   R, Pt  : BSTreePt;
   Name   : Names;
   Phone  : St10;
   Status : Boolean;
BEGIN
   R := CreateTree;
   Pt := R;
   WHILE IP /= 5 LOOP
      Put("What you want to do?"); New_Line;
      Put("1. Insert "); New_Line;
      Put("2. Search"); New_Line;
      Put("3. Traverse"); New_Line;
      Put("4. Delete"); New_Line;
      Put("5. Exit"); New_Line;
      Put("Make your selection: ");
      Get(IP);
      Put(IP,1);
      New_Line(2);
      CASE IP IS
         WHEN 1 =>
            Put("  Enter Name: ");
            NamesIO.Get(Name);
            NamesIO.Put(Name);
            New_Line;

            Put("  Enter Phone: ");
            FOR IP IN 1..10 LOOP
               Get(Phone(IP));
               Put(Phone(IP));
            END LOOP;
            New_Line;
            InsertBinarySearchTree(Pt, Name, Phone);
            Put("Insertion Successfull.");
            New_Line(2);

         WHEN 2 =>
            Put("1. Iteratively"); new_line;
            Put("2. Recursively"); new_line;
            Put("How do you want to search: ");
            Get(IP);
            Put(IP,1);
            New_Line(2);
            Put("Enter name: ");

            NamesIO.Get(Name);
            NamesIO.Put(Name);
            New_Line;
            IF IP = 1 THEN
               FindCustomerIterative(Name, Pt, Status);
               IF Status THEN
                  Name := CustomerName(Pt);
                  Phone := CustomerPhone(PT);
                  Put("Record has been found using iterative method.");
                  New_Line;
                  NamesIO.Put(Name);
                  Put(": ");
                  FOR IP IN 1..10 LOOP
                     Put(Phone(IP));
                  END LOOP;
                  New_Line(2);
               ELSE
                  Put("That name does not exist in the tree.");
                  New_Line(2);
               END IF;
            ELSE
               FindCustomerRecursive(R, Name, Pt, Status);
               IF Status THEN
                  Name := CustomerName(Pt);
                  Phone := CustomerPhone(PT);
                  Put("Record has been found using Recursive method.");
                  New_Line;
                  NamesIO.Put(Name);
                  Put(": ");
                  FOR IP IN 1..10 LOOP
                     Put(Phone(IP));
                  END LOOP;
                  New_Line(2);
               ELSE
                  Put("That name does not exist in the tree.");
                  New_Line(2);
               END IF;
            END IF;

         WHEN 3 =>
            Put("1. InOrder - 3"); New_Line;
            Put("2. ReverseInOrder - 1"); New_Line;
            Put("3. PreOrder - 4");New_Line;
            Put("4. PostOrder - 2");New_Line;
            Put("How would you like to traverse : ");
            Get(IP);
            Put(IP,1);
            New_Line;
            IF IP = 1 THEN
               Put("1. Name"); New_Line;
               Put("2. Root"); New_Line;
               Put("Pick a method of traversal: ");
               Get(IP);
               Put(IP,1);
               New_Line;
               IF IP = 1 THEN
                  Put(" Enter a name: ");
                  NamesIO.Get(Name);
                  NamesIO.Put(Name);
                  New_Line;
                  FindCustomerIterative(Name, Pt, Status);
                  IF Status THEN
                     TraversePt(Pt);
                  ELSE
                     Put("Name is not in the tree.");
                     New_Line(2);
                  END IF;
               ELSE
                  TraversePt(R);
               END IF;
            ELSE
               IF IP = 2 THEN
                  ReverseInOrder(R);
               ELSE
                  IF IP = 3 THEN
                     Put("1. Name"); New_Line;
                     Put("2. Root"); New_Line;
                     Put("Pick a method of traversal: ");
                     Get(IP);
                     Put(IP,1);
                     New_Line;
                     IF IP = 1 THEN
                        Put("Enter a name: ");
                        NamesIO.Get(Name);
                        NamesIO.Put(Name);
                        New_Line;
                        FindCustomerIterative(Name, Pt, Status);
                        IF Status THEN
                           PreOrder(Pt);
                        ELSE
                           Put("That name does not exist in the tree.");
                           New_Line(2);
                        END IF;
                     ELSE
                        PreOrder(R);
                     END IF;
                  ELSE
                      Put("1. Iterative"); New_Line;
                      Put("2. Recursive"); New_Line;
                      Put("Pick a method of traversal: ");
                     Get(IP);
                     Put(IP,1);
                     New_Line;
                     IF IP = 1 THEN
                        PostorderIterative(R);
                     ELSE
                        PostorderRecursive(R);
                     END IF;
                  END IF;
               END IF;
            END IF;

         WHEN 4 =>
            Put("Enter a name: ");
            NamesIO.Get(Name);
            NamesIO.Put(Name);
            New_Line;
            FindCustomerIterative(Name, Pt, Status);
            IF Status THEN
               DeleteRandomNode(Pt);
               Put("Node of name '");
               NamesIO.Put(Name);
               Put("' was deleted succesfully.");
               New_Line(2);
            ELSE
               Put("That name does not exist in the tree.");
               New_Line(2);
            END IF;

         WHEN OTHERS =>
            EXIT;

      END CASE;

   END LOOP;

   Put("Bye!");


END Main;