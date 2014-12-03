WITH Ada.Text_IO;
WITH Ada.Direct_IO;
WITH Ada.Numerics.Generic_Elementary_Functions;
WITH Unchecked_Conversion;

PACKAGE BODY HashTable IS
   PACKAGE intIO IS NEW Ada.Text_IO.Integer_IO(Integer); USE intIO ;
   PACKAGE Long_IO IS NEW Ada.Text_IO.Integer_IO(Long_Integer);
   PACKAGE Math IS NEW Ada.Numerics.Generic_Elementary_Functions(Float);

   FUNCTION StringToInteger IS NEW Unchecked_Conversion(String, Long_Integer);
   FUNCTION CharToInteger IS NEW Unchecked_Conversion(Character, Long_Integer);


   PACKAGE AHashFile IS NEW Ada.Direct_IO(Item); USE AHashFile;

   Init:Boolean:=False;
   Hash_File:AHashFile.File_Type;
   Collision_Type:Integer:=0;
   N:Integer;
   Removed_Type: Item;
   Null_Type: Item;

   Minprobes:Integer:=Standard.Integer(Table_Size);
   Maxprobes:Integer:=1;
   Avgprobes:Float:=1.0;
   Lookups:Integer:=0;
   Totalprobes:Integer:=0;


   PROCEDURE Initialize(Collisiontype: IN Integer; Nullitem: Item; Removeditem: IN Item) IS

   BEGIN
      Init:=True;
      SetCollisionHandler(Collisiontype);
      Removed_Type:=Removeditem;
      Null_Type:=Nullitem;
      ResetTable;
   END Initialize;



   PROCEDURE Insert(Key: String; Data: IN Item) IS

      Hash:Long_Integer;
      Random:Integer:=1;
      Offset:Integer;
      TempItem:Item;
   BEGIN
      IF Init THEN
         ----Original Hash
         ------------------
         Hash:= CharToInteger(Key(1)) +  CharToInteger(key(10));
         Hash:= Hash * 512;
         Hash:= Hash + StringToInteger(Key(15..16));
         Hash:= Hash / 256;
         Hash:= Hash mod 128;

         -- First one
         -- Hash:= (ABS(StringToInteger(Key(1..5))) + ABS(StringToInteger(Key(4..5)))) mod Table_Size;

         -- Second One
         -- Hash:= (ABS(StringToInteger(Key(1..6))/2) + ABS(StringToInteger(Key(7..13)))/3)          mod Table_Size;
         --- Third One
         --Hash:= (ABS(StringToInteger(Key(1..2))) - ABS(CharToInteger(Key(1))) + ABS(StringToInteger(Key(3..4))) + ABS(StringToInteger(Key(1..3)))) mod Table_Size;

         IF Collision_Type = 0 THEN
            FOR I IN 0..Table_Size-1 LOOP
               Read(Hash_File, TempItem, Count(((Hash+I) mod Table_Size)+1));
               IF TempItem = Null_Type OR TempItem = Removed_Type THEN
                  Write(Hash_File, Data, To => Count(((Hash+I) mod Table_Size)+1));
                  EXIT;
               END IF;
            END LOOP;
         ELSE
            WHILE 1=1 LOOP
               Random:=Random * 5;
               Random:=Random mod 2**(N+2);
               IF Random = 1 THEN
                  EXIT;
               END IF;
               Offset:=Random / 4;
               IF Long_Integer(Offset) < Table_Size THEN
                  Read(Hash_File, TempItem, Count(((Hash+Long_Integer(Offset)) mod Table_Size)+1));
                  IF TempItem = Null_Type OR TempItem = Removed_Type THEN
                     Write(Hash_File, Data, To => Count(((Hash+Long_Integer(Offset)) mod Table_Size)+1));
                     EXIT;
                  END IF;
               END IF;
            END LOOP;
         END IF;
      END IF;
   END Insert;

   PROCEDURE Remove(Key: IN String; Data: OUT Item) IS

      Hash:Long_Integer;
      Random:Integer:=1;
      Offset:Integer;
      TempItem:Item;
      Tempkey:String(1..16);
   BEGIN
      IF Init THEN
         --Original Hash
         --Hash:= (ABS(StringToInteger(Key(13..14))) + ABS(StringToInteger(Key(15..16)))) mod Table_Size;
         --Attempt 1
         Hash:= (ABS(StringToInteger(Key(1..2))) + ABS(StringToInteger(Key(4..5)))) mod Table_Size;
         --Attempt 2
         --Hash:= (ABS(StringToInteger(Key(1..2))) + ABS(StringToInteger(Key(5..6)))) mod Table_Size;
         --Hash:= Hash + ABS(StringToInteger(Key(3..4))) mod Table_Size;
         --Attempt 3
         --Hash:= (ABS(StringToInteger(Key(1..2))) - ABS(StringToInteger(Key(5..6))) * ABS(StringToInteger(Key(3..4)))) mod Table_Size;
         --Hash:= Hash + ABS(StringToInteger(Key(3..4))) mod Table_Size;

         IF Collision_Type = 0 THEN
            FOR I IN 0..Table_Size-1 LOOP
               Read(Hash_File, TempItem, Count(((Hash+I) mod Table_Size)+1));
               HashTable.Key(Tempitem,Tempkey);
               IF Tempkey = Key THEN
                  Data:=TempItem;
                  Write(Hash_File, Removed_Type, To => Count(((Hash+I) mod Table_Size)+1));
                  EXIT;
               END IF;
            END LOOP;
         ELSE
            WHILE 1=1 LOOP
               Random:=Random * 5;
               Random:=Random mod 2**(N+2);
               IF Random = 1 THEN
                  EXIT;
               END IF;
               Offset:=Random / 4;
               IF Long_Integer(Offset) < Table_Size THEN
                  Read(Hash_File, TempItem, Count(((Hash+Long_Integer(Offset)) mod Table_Size)+1));
                  HashTable.Key(Tempitem,Tempkey);
                  IF Tempkey = Key THEN
                     Data:=TempItem;
                     Write(Hash_File, Removed_Type, To => Count(((Hash+Long_Integer(Offset)) mod Table_Size)+1));
                     EXIT;
                  END IF;
               END IF;
            END LOOP;
         END IF;
      END IF;
   END Remove;

   PROCEDURE Get(Key: IN String; Data: OUT Item) IS

      Hash:Long_Integer;
      Random:Integer:=1;
      Offset:Integer;
      Probecnt:Integer:=0;
      Found:Boolean;
      TempItem:Item;
      Tempkey:String(1..16);
   BEGIN

      IF Init THEN
         Lookups:=Lookups+1;
         --Original Hash
         --Hash:= (ABS(StringToInteger(Key(13..14))) + ABS(StringToInteger(Key(15..16)))) mod Table_Size;
         --Attempt 1
         Hash:= (ABS(StringToInteger(Key(1..2))) + ABS(StringToInteger(Key(4..5)))) mod Table_Size;
         --Attempt 2
         --Hash:= (ABS(StringToInteger(Key(1..2))) + ABS(StringToInteger(Key(5..6)))) mod Table_Size;
         --Hash:= Hash + ABS(StringToInteger(Key(3..4))) mod Table_Size;
         --Attempt 3
         --Hash:= (ABS(StringToInteger(Key(1..2))) - ABS(StringToInteger(Key(5..6))) * ABS(StringToInteger(Key(3..4)))) mod Table_Size;
         --Hash:= Hash + ABS(StringToInteger(Key(3..4))) mod Table_Size;
         IF Collision_Type = 0 THEN
            FOR I IN 0..Table_Size-1 LOOP
               Probecnt:=Probecnt+1;
               Read(Hash_File, TempItem, Count(((Hash+I) mod Table_Size)+1));
               HashTable.Key(TempItem,Tempkey);
               IF Tempkey = Key THEN
                  Data:=TempItem;
                  Found:=True;
                  EXIT;
               END IF;
            END LOOP;
         ELSE
            WHILE 1=1 LOOP
               Random:=Random * 5;
               Random:=Random mod 2**(N+2);
               IF Random = 1 THEN
                  EXIT;
               END IF;
               Offset:=Random / 4;
               IF Long_Integer(Offset) < Table_Size THEN
                  Probecnt:=Probecnt+1;
                  Read(Hash_File, TempItem, Count(((Hash+Long_Integer(Offset)) mod Table_Size)+1));
                  HashTable.Key(Tempitem,Tempkey);
                  IF Tempkey = Key THEN
                     Data:=TempItem;
                     Found:=True;
                     EXIT;
                  END IF;
               END IF;
            END LOOP;
         END IF;


         IF Found THEN
            Totalprobes:= Totalprobes + Probecnt;
            Avgprobes:= Float(Totalprobes) / Float(Lookups);

            IF Maxprobes < Probecnt THEN
               Maxprobes:=Probecnt;
            END IF;
            IF Minprobes > Probecnt THEN
               Minprobes:=Probecnt;
            END IF;
         END IF;
      END IF;
   END Get;

   PROCEDURE GetMinProbes(X: OUT Integer) IS
   BEGIN
      X:=Minprobes;
   END GetMinProbes;

   PROCEDURE GetMaxProbes(X: OUT Integer) IS
   BEGIN
      X:=Maxprobes;
   END GetMaxProbes;

   PROCEDURE GetAvgProbes(X: OUT Float) IS
   BEGIN
      X:=Avgprobes;
   END GetAvgProbes;

   PROCEDURE GetTotalProbes(X: OUT Integer) IS
   BEGIN
      X:=Totalprobes;
   END GetTotalProbes;

   PROCEDURE ResetStatistics IS
   BEGIN
      Minprobes:=Standard.Integer(Table_Size);
      Maxprobes:=1;
      Avgprobes:=1.0;
      Lookups:=0;
      Totalprobes:=0;
   END ResetStatistics;

   PROCEDURE PrintTable IS
      Tempitem:Item;
   BEGIN
      IF Is_Open(Hash_File) THEN
         FOR I IN 1..Table_Size LOOP
            Read(Hash_File, Tempitem, Count(I));
            Long_IO.Put(I);Ada.Text_IO.Put(" ");Put(Tempitem);Ada.Text_IO.Put_Line("");
         END LOOP;
      ELSE
         Ada.Text_IO.Put_Line("Object needs to be initialized first.");
      END IF;
   END PrintTable;

   PROCEDURE ResetTable IS
   BEGIN
      IF Is_Open(Hash_File) THEN
         Close(Hash_File);
      END IF;
      Create(Hash_File, Mode => InOut_File, Name => "hashtabledata.diorf" );
      FOR I IN 1..Table_Size LOOP
         Write(Hash_File, Null_Type, To => Count(I));
      END LOOP;
   END ResetTable;

   PROCEDURE SetCollisionHandler(Collisiontype: IN Integer) IS
      Temp:Integer:=0;
   BEGIN
      Collision_Type:=Collisiontype;
      IF Collision_Type /= 0 THEN
         N:=Integer( Float'Ceiling(Math.Log( Float(Table_Size) ) / Math.Log( 2.0 )));
      END IF;
   END SetCollisionHandler;
END HashTable;


