package body bufor is
   task body Buffer is
      Storage_Capacity: constant Integer := 30;
      type Storage_type is array (Product_Type) of Integer;
      Storage: Storage_type
	:= (0, 0, 0, 0, 0);
      Assembly_Content: array(Assembly_Type, Product_Type) of Integer
	:= ((3, 0, 0, 2, 0), -- English Breakfast, 3x Egg and 2x Sausage
	    (0, 2, 1, 0, 0), -- Roasted Beef with Potatoes, 2x Potato and 1x Beef
	    (2, 0, 0, 0, 3)); -- Fried Eggs with Bacon, 2x Egg and 3x Bacon
      Max_Assembly_Content: array(Product_Type) of Integer;
      Assembly_Number: array(Assembly_Type) of Integer
	:= (1, 1, 1);
      In_Storage: Integer := 0;

      procedure Setup_Variables is
      begin
	 for W in Product_Type loop
	    Max_Assembly_Content(W) := 0;
	    for Z in Assembly_Type loop
	       if Assembly_Content(Z, W) > Max_Assembly_Content(W) then
		  Max_Assembly_Content(W) := Assembly_Content(Z, W);
	       end if;
	    end loop;
	 end loop;
      end Setup_Variables;

      function Can_Accept(Product: Product_Type) return Boolean is
	 Free: Integer;		--  free room in the storage
	 -- how many products are for production of arbitrary assembly
	 Lacking: array(Product_Type) of Integer;
	 -- how much room is needed in storage to produce arbitrary assembly
	 Lacking_room: Integer;
	 MP: Boolean;			--  can accept
      begin
	 if In_Storage >= Storage_Capacity then
	    return False;
	 end if;
	 -- There is free room in the storage
	 Free := Storage_Capacity - In_Storage;
	 MP := True;
	 for W in Product_Type loop
	    if Storage(W) < Max_Assembly_Content(W) then
	       MP := False;
	    end if;
	 end loop;
	 if MP then
	    return True;		--  storage has products for arbitrary
	       				--  assembly
	 end if;
	 if Integer'Max(0, Max_Assembly_Content(Product) - Storage(Product)) > 0 then
	    -- exactly this product lacks
	    return True;
	 end if;
	 Lacking_room := 1;			--  insert current product
	 for W in Product_Type loop
	    Lacking(W) := Integer'Max(0, Max_Assembly_Content(W) - Storage(W));
	    Lacking_room := Lacking_room + Lacking(W);
	 end loop;
	 if Free >= Lacking_room then
	    -- there is enough room in storage for arbitrary assembly
	    return True;
	 else
	    -- no room for this product
	    return False;
	 end if;
      end Can_Accept;

      function Can_Deliver(Assembly: Assembly_Type) return Boolean is
      begin
	 for W in Product_Type loop
	    if Storage(W) < Assembly_Content(Assembly, W) then
	       return False;
	    end if;
	 end loop;
	 return True;
      end Can_Deliver;

      procedure Storage_Contents is
      begin
	 for W in Product_Type loop
	    Put_Line("Storage contents: " & Integer'Image(Storage(W)) & " "
		       & To_String(Product_Name(W)));
	 end loop;
      end Storage_Contents;

   begin
      Put_Line("Kitchen opened");
      Setup_Variables;
      loop
	 accept Take(Product: in Product_Type; Number: in Integer) do
	   if Can_Accept(Product) then
	      Put_Line("Accepted product " & To_String(Product_Name(Product)) & " n." &
		Integer'Image(Number));
	      Storage(Product) := Storage(Product) + 1;
	      In_Storage := In_Storage + 1;
       else
          Put_Line("Rejected product " & To_String(Product_Name(Product)) & " n." &
		    Integer'Image(Number));
	   end if;
	 end Take;
	 Storage_Contents;
	 accept Deliver(Assembly: in Assembly_Type; Consumer_Name_String: in String) do
	    if Can_Deliver(Assembly) then
	       Put_Line(Consumer_Name_String & " took dish " &
		   To_String(Assembly_Name(Assembly)) & " number " &
          Integer'Image(Assembly_Number(Assembly)));
	       for W in Product_Type loop
		  Storage(W) := Storage(W) - Assembly_Content(Assembly, W);
		  In_Storage := In_Storage - Assembly_Content(Assembly, W);
	       end loop;
	       Assembly_Number(Assembly) := Assembly_Number(Assembly) + 1;
	    else
            Put_Line("Could not make " &
            To_String(Assembly_Name(Assembly)) & " for " &
            Consumer_Name_String);
	    end if;
	 end Deliver;
	 Storage_Contents;
      end loop;
   end Buffer;
end bufor;
