PACKAGE BODY BinarySearchTree IS

   Z, T, S, Pa, R, P, Q: BSTreePt;
   Phone: St10;

   stk: stack(1..50);
   num: Integer range 0..50 := 0;

   PROCEDURE DeleteRandomNode(Pt: IN BSTreePt) IS
   BEGIN

	  T := Pt;
	  Pa := T;

	  --Find Parent Of Node To Delete.
	  IF Pa.LTag = False AND Pa.RTag = False THEN
		IF Pa.LLink.RLink = T THEN
			Pa := Pa.LLink;
	    ELSE
			Pa := Pa.RLink;
		END IF;
	  ELSE
		IF Pa.LTag AND Pa.RTag THEN
			WHILE Pa.LTag /= FALSE LOOP
				Pa := Pa.LLink;
			END LOOP;
			IF Pa.LLink.RLink = T THEN
				Pa := Pa.LLink;
			ELSE
				Pa := T;
				WHILE Pa.RTag /= FALSE LOOP
					Pa := Pa.RLink;
				END LOOP;
				Pa := Pa.RLink;
			END IF;
		ELSE
			IF Pa.LTag = False AND Pa.RTag THEN
				IF Pa.LLink.RLink = T THEN
					Pa := Pa.LLink;
				ELSE
					Pa := Pa.RLink;
					WHILE Pa.RTag /= FALSE LOOP
						Pa := Pa.RLink;
					END LOOP;
					Pa := Pa.RLink;
				END IF;
			Else
				IF Pa.RLink.LLink = T THEN
					Pa := Pa.RLink;
				ELSE
					Pa := Pa.LLink;
					WHILE Pa.LTag /= FALSE LOOP
						Pa := Pa.LLink;
					END LOOP;
					Pa := Pa.LLink;
				END IF;
			END If;
		END IF;
	  END IF;

	  --Delete Node
	  If T.RTag = False THEN
	     IF Pa.RLink = T THEN
		    Pa.RTag := T.RTag;
			Pa.RLink := T.RLink;
		 ELSE
		    Pa.LTag := T.LTag;
			Pa.LLink := T.LLink;
		 End If;
		 Avail(T);
      Else
	     If T.LTag = False THEN
		    IF Pa.RLink = T THEN
		       Pa.RTag := T.RTag;
			   Pa.RLink := T.RLink;
		    ELSE
		       Pa.LTag := T.RTag;
			   Pa.LLink := T.RLink;
		    End If;
		    Avail(T);
         Else
		    P := T.RLink;
			If P.LTag = False THEN
			   IF Pa.RLink = T THEN
			      Pa.RLink := P;
			   ELSE
				  Pa.LLink := P;
			   End If;
			   P.LTag := Pt.LTag;
			   P.LLink := Pt.LLink;
			   Avail(T);
			ELSE
			   S := P.LLink; --look for inorder succ
			   Z := T.LLink; --look for inorder pred
			   WHILE S.LTag /= FALSE LOOP
			      P := S;
				  S := S.LLink;
			   END LOOP;
			   WHILE Z.RTag /= FALSE LOOP
				   Z := Z.RLink;
			   END LOOP;
			   If Pa.RLink = T THEN
			      Pa.RLink := S;
			   Else
			      Pa.LLink := S;
			   END IF;
			   P.LTag  := S.LTag;
			   Z.RLink := S;
			   S.LTag  := T.LTag;
			   S.LLink := T.LLink;
			   S.RLink := T.RLink;
			   S.RTag  := T.RTag;
			   Avail(T);
			END IF;
	     END IF;
	  END IF;

   END DeleteRandomNode;

   PROCEDURE PreOrder(Pt: IN BSTreePt) IS
   BEGIN
    Z := Pt;
	IF Pt = R THEN
	     Put("Traversing tree starting from ROOT.");New_Line;
		 Z := Pt.LLink;
	  ELSE
         Put("Traversing tree starting from: ");NamesIO.Put(CustomerName(Pt));New_Line;
      END IF;
	Put("Phone     / Name");New_Line;

	Q := Z;

	LOOP
		Phone := CustomerPhone(Q);
		For IP IN 1..10 LOOP
			Put(Phone(IP));
		END LOOP;Put("/ ");
		NamesIO.Put(CustomerName(Q));New_Line;
		IF Q.LTag THEN
			Q := Q.LLink;
		ELSE
			IF Q.RTag = False THEN
				Q := Q.RLink.RLink;
			ELSE
				Q := Q.RLink;
			END IF;
		END IF;
		IF Q = R THEN
			Q := Q.LLink;
		END IF;
		EXIT WHEN Q = Z;
	END LOOP;

   END PreOrder;

   PROCEDURE ReverseInOrder(Pt: IN BSTreePt) IS
   BEGIN

		IF Pt /= R THEN

			IF Pt.RTag THEN
				ReverseInOrder(Pt.RLink);
			END IF;

			Phone := CustomerPhone(Pt);
			For IP IN 1..10 LOOP
				Put(Phone(IP));
			END LOOP;Put("/ ");
			NamesIO.Put(CustomerName(Pt));New_Line;

			IF Pt.LTag THEN
				ReverseInOrder(Pt.LLink);
			END IF;

		ELSE

			ReverseInOrder(Pt.LLink);

		END IF;

   END ReverseInOrder;
   
   PROCEDURE PostOrderIterative(Pt: IN BSTreePt) IS
   BEGIN
		IF Pt = R Then
			P := Pt.LLink;
		ELSE 
			P := Pt;
		END IF;
		T := P;
		
		LOOP
			Push(T);
			IF P.RTag THEN
				T := P.RLink;
			ELSE
				WHILE NOT T.LTag Loop
					T := T.LLink;
				END LOOP;
        T := T.LLink;
			END IF;
			P := T;
                  
			IF Pt = R Then
				EXIT WHEN P = Pt.LLink;
			ELSE 
				EXIT WHEN P = Pt;
			END IF;
         
		END LOOP;
		     put("---> Here");   
		WHILE NOT empty LOOP
			pop(P);
			Phone := CustomerPhone(P);
			For IP IN 1..10 LOOP
				Put(Phone(IP));
			END LOOP;Put("/ ");
			NamesIO.Put(CustomerName(P));New_Line;
		END LOOP;
		
   END PostOrderIterative;

   procedure push(pt: in BSTreePt) is
   begin
      if num < 10 then
         num := num + 1;
         stk(num) := pt;
      end if;
   end push;

   procedure pop(pt: out BSTreePt) is
   begin
      if num /= 0 then
         pt := stk(num);
         num := num - 1;
      end if;
   end pop;

   function empty return Boolean is
   begin
		if num = 0 then
			return true;
		END IF;
		return false;
   end empty;

   PROCEDURE PostOrderRecursive(Pt: IN BSTreePt) IS
   BEGIN

		IF Pt /= R THEN

			IF Pt.LTag THEN
				PostOrderRecursive(Pt.LLink);
			END IF;

			IF Pt.RTag THEN
				PostOrderRecursive(Pt.RLink);
			END IF;

			Phone := CustomerPhone(Pt);
			For IP IN 1..10 LOOP
				Put(Phone(IP));
			END LOOP;Put("/ ");
			NamesIO.Put(CustomerName(Pt));New_Line;

		ELSE
			PostOrderRecursive(Pt.LLink);
		END IF;

   END PostOrderRecursive;


   PROCEDURE InsertBinarySearchTree(Root: IN OUT BSTreePt; Name: IN Names; Phone: St10) IS
   BEGIN

      Q := NEW Node;
      Q.LTag  := False;
      Q.LLink := NULL;
      Q.Info.Name  := Name;
      Q.Info.Phone := Phone;
      Q.RLink := NULL;
      Q.RTag  := False;

      IF R.LTag = False THEN
         Q.LTag  := R.Ltag;
         Q.LLink := R.LLink;
         Q.RLink := R;
         Q.RTag  := False;
         R.LTag  := True;
         R.LLink := Q;
      ELSE
         P := R.LLink;
         LOOP
            IF Name /= P.Info.Name THEN
               IF Name > P.Info.Name THEN
                  IF P.RTag THEN
                     P := P.RLink;
                  ELSE
                     Q.LTag  := False;
                     Q.LLink := P;
                     Q.RLink := P.RLink;
                     Q.RTag  := P.RTag;
                     P.RTag  := True;
                     P.RLink := Q;
                     EXIT;
                  END IF;

               ELSE
                  IF P.LTag THEN
                     P := P.LLink;
                  ELSE
                     Q.LTag  := P.LTag;
                     Q.LLink := P.LLink;
                     Q.RLink := P;
                     Q.RTag  := False;
                     P.LTag  := True;
                     P.LLink := Q;
                     EXIT;
                  END IF;

               END IF;

            ELSE
               IF P.RTag = False THEN
                  Q.LTag  := False;
                  Q.LLink := P;
                  Q.RLink := P.RLink;
                  Q.RTag  := P.RTag;
                  P.RTag  := True;
                  P.RLink := Q;
                  EXIT;
               ELSE
                  P := P.RLink;
                  WHILE P.LTag LOOP
                     P := P.LLink;
                  END LOOP;
                  Q.LTag  := P.LTag;
                  Q.LLink := P.LLink;
                  Q.RLink := P;
                  Q.RTag  := False;
                  P.LTag  := True;
                  P.LLink := Q;
                  EXIT;
               END IF;

            END IF;
         END LOOP;
      END IF;

   END InsertBinarySearchTree;

   PROCEDURE FindCustomerIterative(Name: IN Names; Pt: OUT BSTreePt; Status: OUT Boolean) IS
   BEGIN

      P := R.LLink;
      Status := False;
      LOOP
         IF Name /= P.Info.Name THEN
            IF Name > P.Info.Name THEN
			   IF P.RTag THEN
			      P := P.RLink;
			   ELSE
			      EXIT;
			   END IF;
            ELSE
			   IF P.LTag THEN
                  P := P.LLink;
			   ELSE
			      EXIT;
			   END IF;
            END IF;
         ELSE
            Pt := P;
            Status := True;
            EXIT;
         END IF;
      END LOOP;

   END FindCustomerIterative;

   PROCEDURE FindCustomerRecursive(Root: IN BSTreePt; Name: IN Names; pt: OUT BSTreePt; Status: OUT Boolean) IS
   BEGIN

      IF Root.RLink = Root THEN
         P := Root.LLink;
      ELSE
         P := Root;
      END IF;
      Status := False;

      IF Name /= P.Info.Name THEN
         IF Name < P.Info.Name THEN
            IF P.LTag THEN
               FindCustomerRecursive(P.LLink, Name, Pt, Status);
            END IF;
         ELSE
            IF P.RTag THEN
               FindCustomerRecursive(P.RLink, Name, Pt, Status);
            END IF;
         END IF;
      ELSE
         Pt := P;
         Status := True;
      END IF;

   END FindCustomerRecursive;

   PROCEDURE TraversePt(Pt: IN BSTreePt) IS
   BEGIN
	  IF Pt = R THEN
	     Put("Traversing tree starting from ROOT.");New_Line;
	  ELSE
         Put("Traversing tree starting from: ");NamesIO.Put(CustomerName(Pt));New_Line;
      END IF;
      Put("Phone     / Name");New_Line;

	  Q := Pt;
      WHILE Q.LTag LOOP
         Q := Q.LLink;
      END LOOP;
	  P := Q;

      LOOP

	     T := P;

         Phone := CustomerPhone(P);
         For IP IN 1..10 LOOP
            Put(Phone(IP));
         END LOOP;Put("/ ");
         NamesIO.Put(CustomerName(P));New_Line;

		 P := T.RLink;
		 IF T.RTag THEN
		    WHILE P.LTag LOOP
			   P := P.LLink;
			END LOOP;
		 END IF;

		 If P = R THEN
		    WHILE P.LTag LOOP
			   P := P.LLink;
		    END LOOP;
		 END IF;

         EXIT WHEN P = Q;
      END LOOP;

   END TraversePt;

   FUNCTION InOrderSuccessor(Pt: IN BSTreePt) RETURN BSTreePt IS
   BEGIN

      P := Pt.RLink;
      IF Pt.RTag THEN
         WHILE P.LTag LOOP
            P := P.LLink;
         END LOOP;
      END IF;
      RETURN P;

   END InOrderSuccessor;

   FUNCTION CustomerName(Pt: IN BSTreePt) RETURN Names IS
   BEGIN

      RETURN Pt.Info.Name;

   END CustomerName;

   FUNCTION CustomerPhone(Pt: IN BSTreePt) RETURN St10 IS
   BEGIN

      RETURN Pt.Info.Phone;

   END CustomerPhone;

   FUNCTION CreateTree RETURN BSTreePt IS
   BEGIN
      R := NEW Node;
      R.LTag  := False;
      R.LLink := R;
      R.RLink := R;
      R.RTag  := True;
      RETURN R;
   END CreateTree;

END BinarySearchTree;