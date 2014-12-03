WITH Ada.Text_IO;    USE Ada.Text_IO;

PACKAGE BODY Stack IS
   PACKAGE IntIO IS NEW Ada.Text_IO.Integer_IO(Integer);    USE IntIO;
   PACKAGE FloatIO IS NEW Ada.Text_IO.Float_IO(Float);    USE FloatIO;

   St    : ARRAY (Integer (Lo) .. Integer (M)) OF MyType;
   Top   : ARRAY (0 .. Integer (M + 1.0)) OF Integer;
   Base  : ARRAY (0 .. Integer (M + 1.0)) OF Integer;
   One   : ARRAY (1 .. Integer (NumS + 1.0)) OF Integer;
   Input : Integer;    

   FUNCTION Floor (Num : Float) RETURN Integer IS
      Tmp : Integer;
   BEGIN
      Tmp:= Integer(Num);
      IF Float(Tmp) <= Num THEN
         RETURN Tmp;
      ELSE
         RETURN Tmp - 1;
      END IF;
   END Floor;

   PROCEDURE Push (Item : IN MyType; Status : OUT Boolean) IS
   BEGIN

      FOR Ans IN 1..Integer(NumS) LOOP
         Put("  ");
         Put(Ans, 1);
         Put(". Stack ");
         Put(Ans,1);
         New_Line;
      END LOOP;
      Put("Push to which stack: ");
      Get(Input);
      Put("Stack ");       Put(Input,1);      Put(" was selected.");
      New_Line(2);
      Top(Input) := Top(Input) + 1;
      IF Top(Input) > Base(Input + 1) THEN

         Put("Overflow ocurred. Reallocating memory.");
         New_Line(2);
         Put("Before Reallocation. Memory status: ");
         New_Line;
         Put("____________________________________");
         New_Line;
         FOR I IN 1..Integer(NumS) LOOP
            Put("|  base(");      Put(I,1);
            Put(") = ");          Put(Base(I),3);
            Put("  |  top(");      Put(I,1);
            Put(") = ");       Put(Top(I),3);
            Put("  |");
            New_Line;
         END LOOP;
         Put("¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯");
         New_Line(2);
         Put("Before Reallocation. Content status: ");
         New_Line;
         Top(Input) := Top(Input) - 1;
         FOR I IN 1..Integer(NumS) LOOP
            FOR J IN Base(I) + 1 .. Top(I) LOOP
               Put("Stack ");                 Put(I,1);
               Put(" | Position ");         Put(J,1);
               Put(" = ");      Put( St(J) );
               New_Line;
            END LOOP;
         END LOOP;
         New_Line(2);
         Top(Input) := Top(Input) + 1;
         Reallocate(Item, Status);
      ELSE
         St( Top(Input) ) := Item;
         Status := True;
      END IF;
   END Push;

   PROCEDURE Pop ( Item : OUT MyType; Status : OUT Boolean) IS
   BEGIN
      Put("Pop from which stack: ");
      New_Line;
      FOR Ans IN 1..Integer(NumS) LOOP
         Put(Ans,1);
         Put(". Stack ");
         Put(Ans,1);
         New_Line;
      END LOOP;
      Get(Input);     Put("Option ");
      Put(Input,1);    Put(" was selected.");
      New_Line(2);

      IF Top(Input) = Base(Input) THEN
         Status := False;
      ELSE
         Item := St( Top(Input) );
         Top(Input) := Top(Input) - 1;
         Status := True;
      END IF;
   END Pop;

  PROCEDURE Reallocate ( Item : IN MyType; Status :    OUT Boolean) IS
      TotalInc   : Float   := 0.0;
      MinSpace, Alpha, Beta, Sigma, Tau : Float;
      AvailSpace : Integer;
   BEGIN
      MinSpace := (M - Lo) * 0.1;
      AvailSpace := Floor(M - Lo);

      FOR I IN REVERSE 1..Integer(NumS) LOOP
         AvailSpace := AvailSpace - ( Top(I) - Base(I) );
         IF Top(I) > One(I) THEN
            One(I + 1) := Top(I) - One(I);
            TotalInc := TotalInc + Float( One(I + 1) );
         ELSE
            One(I + 1) := 0;
         END IF;
      END LOOP;

      IF AvailSpace < Floor(MinSpace - 1.0) THEN
         Status := False;
      ELSE
         Alpha := 0.07 * Float(AvailSpace) / NumS;
         Beta := 0.93 * Float(AvailSpace) / TotalInc;
         Sigma := 0.0;
         One(1) := Base(1);
         Status := True;

         FOR I IN 2..Integer(NumS) LOOP
            Tau := Sigma + Alpha + Float( One(I) ) * Beta;
            One(I) := One(I - 1) + Top(I - 1) - Base(I - 1) + Floor(Tau) -
               Floor(Sigma);
            Sigma := Tau;
         END LOOP;

         Top(Input) := Top(Input) - 1;
         MoveStack;
         Top(Input) := Top(Input) + 1;
         St( Top(Input) ) := Item;

         Put("After Reallocation. Memory status: ");
         New_Line;
         Put("____________________________________");
         New_Line;
         FOR I IN 1..Integer(NumS) LOOP
            One(I) := Top(I);
            Put("|  base(");
            Put(I,1);
            Put(") = ");
            Put(Base(I),3);
            Put("  |  top(");
            Put(I,1);
            Put(") = ");
            Put(Top(I),3);
            Put("  |");
            New_Line;
         END LOOP;
         Put("¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯");
         New_Line(2);
         Put("After Reallocation. Content Status: ");
         New_Line;
         FOR I IN 1..Integer(NumS) LOOP
            FOR J IN Base(I) + 1 .. Top(I) LOOP
               Put("Stack ");
               Put(I,1);
               Put(" | Position ");
               Put(J,1);
               Put(" = ");
               Put( St(J) );
               New_Line;
            END LOOP;
         END LOOP;
         New_Line(2);
      END IF;
   END Reallocate;

   PROCEDURE MoveStack IS
      Tmp : Integer;
   BEGIN
      FOR I IN REVERSE 2..Integer(NumS) LOOP
         IF One(I) > Base(I) THEN
            Tmp := One(I) - Base(I);
            FOR J IN Top(I) .. Base(I) + 1 LOOP
               St( J + Tmp ) := St(J);
            END LOOP;
            Base(I) := One(I);
            Top(I) := Top(I) + Tmp;
         END IF;
      END LOOP;

      FOR I IN 2..Integer(NumS) LOOP
         IF One(I) < Base(I) THEN
            Tmp := Base(I) - One(I);
            FOR J IN Base(I) + 1 .. Top(I) LOOP
               St( J - Tmp ) := St(J);
            END LOOP;
            Base(I) := One(I);
            Top(I) := Top(I) - Tmp;
         END IF;
      END LOOP;
   END MoveStack;

BEGIN
   FOR I IN 1..Integer(NumS) LOOP
      Top(I) := Floor( Float( I - 1 ) / NumS * (M + 2.0) + Lo );
      Base(I) := Top(I);
      One(I) := Top(I);
   END LOOP;
   Base( Integer(NumS + 1.0) ) := Integer(M);
END Stack;
