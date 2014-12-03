package body Generics is
   myStack: array(1..arrayMax) of item;

   procedure setMax(x: in integer) is
   begin
      max := x;
      err := false;
   end;

   procedure Push(myItem: in item; err: out boolean) is
   begin
   if top < max then
         err := false;
         top := top + 1;
         myStack(top) := myItem;
   else
         err := true;
         put("Overflow!");
   end if;
   end Push;

   procedure Pop(myItem: out item; err: out boolean) is
   begin
     if top = 0 then
         put("Underflow!"); new_line;
         err := true;
      else
         err := false;
         myItem:= myStack(top);
         top:= top - 1;
      end if;
   end Pop;
end Generics;