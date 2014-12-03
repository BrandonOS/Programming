with Ada.Text_IO; use Ada.Text_IO;
with Generics;

procedure main is
   type MonthName is(January, February, March, April, May, June, July, August, September, October, November, December);
   package MonthNameIO is new Ada.Text_IO.Enumeration_IO(MonthName); use MonthNameIO;
   type DateType is record
      month: MonthName;
      date: integer range 1..31;
      year: integer;
   end record;

   package IntIO is new Ada.Text_IO.Integer_IO(integer); use IntIO;

   package intGen is new Generics(integer, 255);
   package charGen is new Generics(character, 255);
   package dateGen is new Generics(DateType, 255);

   close: integer := 1;
   stackType: integer range 1..3;
   max: integer;
   ---Init Vars

   i, diff: integer;
   quit: integer := 1;

   word, continue, myChar: character;

   myInt: integer := 1;

   procedure reset_Vars is
   begin
      i :=0;
      myInt := 1;

      word:= 'a';
      continue:= 'y';
   end;

   procedure processInt is
      use intGen;
   begin
   quit := 1; diff := 0;
   while quit = 1 loop
      put("Enter numbers (Separated by [Space] terminated with a [0]: ");
      new_line(2);
      while myInt /= 0 and err = false loop
         Diff := Diff + 1;
         get(myInt);
            IF MyInt /= 0 THEN
               Push(MyInt, Err);
            else
               Push(Diff - 1, Err);
               diff := 0;
            end if;
      end loop;

      put("Pop? ");
      get(continue);

      while continue ='y' and err = false loop
         Pop(diff, err);
         if err = false then
         put(diff, 5);
            for i in 1..diff loop            --exclude prev one
               Pop(myInt, err); put(myInt, 5);
            end loop;
         new_line;

         put("Pop? ");
         get(continue);
        end if;
      end loop;
      put("Process more [1] = Yes   [0] = No: ");
      get(quit);
      reset_Vars;      err := false;
   end loop;
   end processInt;
   ----- End Integers ---------

   procedure processChar is
      use charGen;
   begin
      quit := 1; diff := 0;
      while quit = 1 loop
         -- begin actual procedure
         put("Enter a name (Separated by [Space] terminated with a [#]: ");
         new_line(2);

         --Get the names
         WHILE Word /= '#' AND Err = False LOOP
            diff := diff + 1;
            get(word);
            if word = '#' or word = ' ' then
               Push( IntToChar(Diff - 1), Err);
               diff := 0;
            else
               Push(word, err);
            END IF;
         END LOOP;

         put("Pop? ");
         get(continue);
         -- Spill the names out
         while continue ='y' and err = false loop
            Pop(myChar, err); new_line;
            if err = false then
               diff := charToInt(myChar);
               put(diff);
               for i in 1 ..diff loop
                  Pop(myChar, err);
                  put(myChar);
               end loop;
               new_line;
               put("Pop? ");
               get(continue);
            end if;
         end loop;
         put("Process more [1] = Yes   [0] = No: ");
         get(quit);
         reset_Vars; err := false;
      end loop;
   end processChar;

   --- Begin Date ---------
   procedure printDate( adate: in DateType) is
   begin
	put(aDate.month);  put(aDate.date ,3); put(","); put(aDate.year, 5); new_line;
   end printDate;

   procedure getDate( adate: out DateType) is
   begin
      put("Enter month: ");get(aDate.month);
      put("Enter date: ");get(aDate.date);
      put("Enter year: ");get(aDate.year);
   end;

   procedure processDates is
      use dateGen;
      aDate: DateType;
   begin
   quit := 1; diff := 1;
   while quit = 1 loop
      while myInt /= 0 and err = false loop
         getDate(aDate);
         Push(aDate, err);
         if (err = false) then
            put("Continue? [1] = Yes   [0] = No: ");
            get(myInt);
          end if;
      end loop;
      err := false;
      put("Pop? ");
      get(continue);
      while continue ='y' and err /= true loop
         Pop(aDate, err);
            if err = false then
               printDate(aDate);
               put("Pop? ");
               get(continue);
            end if;
      end loop;
      put("Process more [1] = Yes   [0] = No: ");
      get(quit);
      reset_Vars;  err := false;
   end loop;
   end;
begin
   while close = 1 loop
      put("Enter Stack size: ");
      get(max);
      new_line;

      put_line("  1. Integer");
      put_line("  2. Character");
      put_line("  3. Dates");

      put("  Choose a Stack type: ");
      get(stackType);   new_line;
      case stackType is
         when 1 =>
            intGen.setMax(max);
            processInt;
         when 2 =>
            charGen.setMax(max);
            processChar;
         when 3 =>
            dateGen.setMax(max);
            processDates;
      end case;


      put("[1] to Continue, [0] to close: ");
      get(close);

      new_line;
      put_line(" -------------------- ");
      new_line;
   end loop;
end main;