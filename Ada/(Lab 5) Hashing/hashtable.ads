GENERIC

  TYPE Item IS PRIVATE;
   Table_Size: Long_Integer;
   WITH PROCEDURE Put(X: Item);	--Required for PrintTable
   WITH PROCEDURE Key(X: Item; Y: OUT String);	--Required to retrieve the key from the object data.
   PACKAGE HashTable IS

      PROCEDURE Initialize(Collisiontype: IN Integer; Nullitem: IN Item; Removeditem: IN Item);
      PROCEDURE Insert(Key: IN String; Data: IN Item);
      PROCEDURE Remove(Key: IN String; Data: OUT Item);
      PROCEDURE Get(Key: IN String; Data: OUT Item);
      PROCEDURE GetMinProbes(X: OUT Integer);
      PROCEDURE GetMaxProbes(X: OUT Integer);
      PROCEDURE GetAvgProbes(X: OUT Float);
      PROCEDURE ResetStatistics;
      PROCEDURE PrintTable;
      PROCEDURE ResetTable;
      PROCEDURE SetCollisionHandler(Collisiontype: IN Integer);
   END HashTable;





