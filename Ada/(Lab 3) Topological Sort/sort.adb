WITH Ada.Text_IO; USE Ada.Text_IO;
WITH Unchecked_Conversion;
PACKAGE BODY Sort IS

   TYPE Node;
   TYPE Nodept IS ACCESS Node;

   TYPE Node IS RECORD
      Info: SortElement;
      link: Nodept;
   END RECORD;

   TYPE Field IS RECORD
      Cnt: Integer := 0;
      Pt: Nodept;
   END RECORD;

   Pt1: Nodept;
   Check: Integer;
   max : constant Integer := 10;
   Top: ARRAY(0..max) OF Field;
   F : SortElement;
   R : SortElement;
   T : Integer;
   A : SortElement;
   B : SortElement;

   Arr: ARRAY(1..S) OF SortElement;

   FUNCTION Pos IS NEW Unchecked_Conversion(SortElement, Integer);
   FUNCTION Val IS NEW Unchecked_Conversion(Integer, SortElement);

   PROCEDURE GetElement(X: out SortElement; Y: out SortElement) IS
   BEGIN
      T := T+1;
      X := Arr(T);
      T := T+1;
      Y := Arr(T);
   END GetElement;

   PROCEDURE ReadElement IS
   BEGIN
      getItem(A);
      WHILE A /= val(0)  LOOP
         Arr(T) := A;
         T := T+1;
         getItem(A);
      END LOOP;

   END ReadElement;

   PROCEDURE PrintList IS
   BEGIN
      T:=0;
      WHILE T < S LOOP
         GetElement(A,B);
         printItem(A);Put(" < ");printItem(B);New_Line;
         Top(pos(B)).Cnt := Top(pos(B)).Cnt + 1;
         Pt1 := NEW Node;
         Pt1.Info := B;
         Pt1.Link := Top(pos(A)).Pt;
         Top(pos(A)).Pt := Pt1;
      END LOOP;New_Line;
   END Printlist;

   PROCEDURE Result IS
   BEGIN
      IF Check /= 0 THEN

         Put("No Solution. Loop exists in: ");
         FOR T IN 1..Max LOOP
            Top(T).Cnt := 0;
         END LOOP;

         FOR T in 1..Max LOOP
            Pt1 := Top(T).Pt;
            Top(T).Pt := NULL;
            if pt1 /= null then
               WHILE Pt1 /= NULL LOOP
                  if Top(pos(Pt1.Info)).Cnt = 0 then
                     Top(pos(Pt1.Info)).Cnt := T;
                  END IF;
                  IF Pt1.link /= NULL THEN
                     Pt1 := Pt1.Link;
                  ELSE
                     Pt1 := NULL;
                  END IF;
               END LOOP;
            END IF;
         END LOOP;

         T := 1;
         WHILE Top(T).Cnt = 0 LOOP
            T := T + 1;
         END LOOP;

         LOOP
            Top(T).pt := NEW Node'(val(1), Top(T).pt);
            T := Top(T).Cnt;
            EXIT WHEN Top(T).pt /= null;
         END LOOP;

         LOOP
            printItem(val(T));Put(", ");
            Top(T).Pt := NULL;
            T := Top(T).Cnt;
            IF Top(T).Pt = NULL THEN
               printItem(val(T));Put(", ");
               EXIT;
            END IF;
         END LOOP;

      ELSE
         Put("Topological Sort Completed Successfully!");New_Line;
      END IF;
   END Result;


   PROCEDURE TopoSort IS
   BEGIN

      Top(0).Cnt := 0;
      FOR T IN 1..max LOOP
         IF Top(T).Cnt = 0 THEN
            Top(pos(R)).Cnt := T;
            R := val(T);
         END IF;
      END LOOP;
      F := val(Top(0).Cnt);

      Put("Possible Topological sort: ");
      WHILE Pos(F) /= 0 LOOP
         printItem(F);Put(", ");
         Check := Check - 1;
         Pt1 := Top(pos(F)).Pt;
         Top(pos(F)).Pt := NULL;
         WHILE Pt1 /= NULL LOOP
            Top(pos(Pt1.Info)).Cnt := Top(pos(Pt1.Info)).Cnt - 1;
            IF Top(pos(Pt1.Info)).Cnt = 0 THEN
               Top(pos(R)).Cnt := pos(Pt1.Info);
               R := Pt1.Info;
            END IF;
            Pt1 := Pt1.Link;
         END LOOP;
         F := val(Top(pos(F)).Cnt);
      END LOOP;New_Line(2);

   END TopoSort;


BEGIN

   R := Val(0);
   Check := max;

   For T IN 1..max LOOP
      Top(T).Cnt := 0;
      Top(T).Pt := NULL;
   END LOOP;

   T := 1;

END Sort;