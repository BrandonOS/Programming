WITH Ada.Text_IO;USE Ada.Text_IO;
WITH HashTable;

PROCEDURE Main IS
   PACKAGE IntIO IS NEW Ada.Text_IO.Integer_IO(Integer);  USE IntIO;
   PACKAGE FloatIO IS NEW Ada.Text_IO.Float_IO(Float);  USE FloatIO;
                           
   TYPE String16 IS ARRAY (1 .. 16) OF Character;
   PROCEDURE String16_Put ( X : IN String16) IS
   BEGIN
      Ada.Text_IO.Put(String(X));
   END String16_Put;

   PROCEDURE String16_Key (X : IN String16; Y : OUT String) IS
       BEGIN
          Y:=String(X);
       END String16_Key;

       PACKAGE Hashtbl IS NEW HashTable(String16,128,String16_Put,  String16_Key);    USE Hashtbl;
       Removed_Item : CONSTANT String16 := " &&&            ";
       Null_Item : CONSTANT String16 := "                ";
       WordsFile : File_Type;
       Tempkey : String (1 .. 16);
       Tempkeylen : Integer;
       Min : Integer;
       Max : Integer;
       Avg : Float;

   BEGIN
      Hashtbl.Initialize(0, Null_Item, Removed_Item);
      Open(WordsFile,In_File,"Words200D16.txt");  
      
      FOR I IN 1..64 LOOP
         IF End_Of_File(WordsFile) THEN
            Put_Line(
               "Words200D16.txt too short!");
            EXIT;
         END IF;
         Get_Line(WordsFile,Tempkey,Tempkeylen);
         Skip_Line(WordsFile);
         Insert(Tempkey,String16(Tempkey));
      END LOOP;
      Close(WordsFile);

      Open(WordsFile,In_File,"Words200D16.txt");
      FOR I IN 1..30 LOOP
         IF End_Of_File(WordsFile) THEN
            Put_Line(
               "Words200D16.txt too short!");
            EXIT;
         END IF;
         Get_Line(WordsFile,Tempkey,Tempkeylen);
         Skip_Line(WordsFile);
         Hashtbl.Get(Tempkey,String16(Tempkey));
       END LOOP;
       Close(WordsFile);

   Put_Line("Statistics for Part A (Linear Probe at 50% full)");
   Put_Line("Statistics of first 30 lookups:");
   GetMinProbes(Min);
   GetMaxProbes(Max);
   GetAvgProbes(Avg);
   Put("Min probes: ");      Put(Min);
   New_Line;
   Put("Max probes: ");        Put(Max);
   New_Line;
   Put("Avg probes: ");        Put(Avg);
   New_Line(2);

   -- Perform a lookup on last 30 keys (starting at line 34)
   Put_Line("Resetting Stats!");
   ResetStatistics;
   Open(WordsFile,In_File,"Words200D16.txt");
   Set_Line(WordsFile,34);
   FOR I IN 1..30 LOOP
      IF End_Of_File(WordsFile) THEN
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Hashtbl.Get(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Put_Line("Statistics of last 30 lookups:");
   GetMinProbes(Min);
   GetMaxProbes(Max);
   GetAvgProbes(Avg);
   Put("Min probes: ");    Put(Min);
   New_Line;
   Put("Max probes: ");     Put(Max);
   New_Line;
   Put("Avg probes: ");     Put(Avg);
   New_Line(2);

   --C part A.
   Put_Line("Table for Part A (Linear Probe at 50% full)");
   PrintTable;
   New_Line;

   --C part B.
   Hashtbl.Initialize(0,Null_Item,Removed_Item);


   Open(WordsFile,In_File,"Words200D16.txt");
   FOR I IN 1..109 LOOP
      IF End_Of_File(WordsFile) THEN
         Put_Line(
            "Words200D16.txt is shorter than expected. It may be corrupt.");
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Insert(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Open(WordsFile,In_File,"Words200D16.txt");
   FOR I IN 1..30 LOOP
      IF End_Of_File(WordsFile) THEN
         Put_Line(
            "Words200D16.txt is shorter than expected. It may be corrupt.");
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Hashtbl.Get(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Put_Line("Statistics for Part B (Linear Probe at 85% full)");
   Put_Line("Statistics of first 30 lookups:");
   GetMinProbes(Min);
   GetMaxProbes(Max);
   GetAvgProbes(Avg);
   Put("Min probes: ");      Put(Min);
   New_Line;
   Put("Max probes: ");      Put(Max);
   New_Line;
   Put("Avg probes: ");      Put(Avg);
   New_Line(2);

   Put_Line("Resetting Stats!");
   ResetStatistics;
   Open(WordsFile,In_File,"Words200D16.txt");
   Set_Line(WordsFile,79);
   FOR I IN 1..30 LOOP
      IF End_Of_File(WordsFile) THEN
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Hashtbl.Get(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Put_Line("Statistics of last 30 lookups:");
   GetMinProbes(Min);
   GetMaxProbes(Max);
   GetAvgProbes(Avg);
   Put("Min probes: ");    Put(Min);
   New_Line;
   Put("Max probes: ");    Put(Max);
   New_Line;
   Put("Avg probes: ");    Put(Avg);
   New_Line(2);

   Put_Line("Table for Part B (Linear Probe at 85% full)");
   PrintTable;
   New_Line;

   --Random Probe
   Hashtbl.Initialize(1,Null_Item,Removed_Item);
   Put_Line("Hashing collision handler set for random probe. (Part C)");

    Open(WordsFile,In_File,"Words200D16.txt");
   FOR I IN 1..64 LOOP
      IF End_Of_File(WordsFile) THEN
         Put_Line(
            "Words200D16.txt is shorter than expected. It may be corrupt.");
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Insert(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Open(WordsFile,In_File,"Words200D16.txt");
   FOR I IN 1..30 LOOP
      IF End_Of_File(WordsFile) THEN
         Put_Line(
            "Words200D16.txt is shorter than expected. It may be corrupt.");
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Hashtbl.Get(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Put_Line("Statistics for Part C (Random Probe at 50% full)");

   Put_Line("Statistics of first 30 lookups:");
   GetMinProbes(Min);
   GetMaxProbes(Max);
   GetAvgProbes(Avg);
   Put("Min probes: ");
   Put(Min);
   New_Line;
   Put("Max probes: ");
   Put(Max);
   New_Line;
   Put("Avg probes: ");
   Put(Avg);
   New_Line;
   New_Line;

   Put_Line("Resetting Stats!");
   ResetStatistics;
   Open(WordsFile,In_File,"Words200D16.txt");
   Set_Line(WordsFile,34);
   FOR I IN 1..30 LOOP
      IF End_Of_File(WordsFile) THEN
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Hashtbl.Get(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Put_Line("Statistics of last 30 lookups:");
   GetMinProbes(Min);
   GetMaxProbes(Max);
   GetAvgProbes(Avg);
   Put("Min probes: ");
   Put(Min);
   New_Line;
   Put("Max probes: ");
   Put(Max);
   New_Line;
   Put("Avg probes: ");
   Put(Avg);
   New_Line;
   New_Line;

   --Table  A part C.
   Put_Line("Table for Part C (Random Probe at 50% full)");
   PrintTable;
   New_Line;

   --Clear the table
   Hashtbl.Initialize(1,Null_Item,Removed_Item);

   Open(WordsFile,In_File,"Words200D16.txt");
   FOR I IN 1..109 LOOP
      IF End_Of_File(WordsFile) THEN
         Put_Line(
            "Words200D16.txt is shorter than expected. It may be corrupt.");
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Insert(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Open(WordsFile,In_File,"Words200D16.txt");
   FOR I IN 1..30 LOOP
      IF End_Of_File(WordsFile) THEN
         Put_Line(
            "Words200D16.txt is shorter than expected. It may be corrupt.");
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Hashtbl.Get(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Put_Line("Statistics for Part C (Random Probe at 85% full)");

   Put_Line("Statistics of first 30 lookups:");
   GetMinProbes(Min);
   GetMaxProbes(Max);
   GetAvgProbes(Avg);
   Put("Min probes: ");    Put(Min);
   New_Line;
   Put("Max probes: ");    Put(Max);
   New_Line;
   Put("Avg probes: ");     Put(Avg);
   New_Line;
   New_Line;

   Put_Line("Resetting Stats!");
   ResetStatistics;
   Open(WordsFile,In_File,"Words200D16.txt");
   Set_Line(WordsFile,79);
   FOR I IN 1..30 LOOP
      IF End_Of_File(WordsFile) THEN
         EXIT;
      END IF;
      Get_Line(WordsFile,Tempkey,Tempkeylen);
      Skip_Line(WordsFile);
      Hashtbl.Get(Tempkey,String16(Tempkey));
   END LOOP;
   Close(WordsFile);

   Put_Line("Statistics of last 30 lookups:");
   GetMinProbes(Min);
   GetMaxProbes(Max);
   GetAvgProbes(Avg);
   Put("Min probes: ");
   Put(Min);
   New_Line;
   Put("Max probes: ");
   Put(Max);
   New_Line;
   Put("Avg probes: ");
   Put(Avg);
   New_Line;
   New_Line;

   Put_Line("Table for Part C (Random Probe at 85% full)");
   PrintTable;
   New_Line;


END Main;
