Generic
   NumS, M, Lo   : Float;
   TYPE MyType IS PRIVATE;
   WITH PROCEDURE Put(X : MyType);
Package Stack IS
   PROCEDURE Push (Item : IN MyType; Status : OUT Boolean);
   PROCEDURE Pop (Item : OUT MyType; Status : OUT Boolean);
   PROCEDURE Reallocate (Item : IN MyType; Status :    OUT Boolean);
   PROCEDURE MoveStack;
END Stack;
