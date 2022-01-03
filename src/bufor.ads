with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with producent;
package bufor is
   Number_Of_Assemblies: constant Integer := 3;
   subtype Assembly_Type is Integer range 1 .. Number_Of_Assemblies;
   Assembly_Name: constant array (bufor.Assembly_Type) of Unbounded_String
     := (To_Unbounded_String("English Breakfast"), To_Unbounded_String("Roasted Beef with Potatoes"), To_Unbounded_String("Fried Eggs with Bacon"));

   -- In the Buffer, products are assemblied into an assembly
   task type Buffer is
      -- Accept a product to the storage provided there is a room for it
      entry Take(Product: in producent.Product_Type; Number: in Integer);
      -- Deliver an assembly provided there are enough products for it
      entry Deliver(Assembly: in Assembly_Type; Consumer_Name_String: in String);
   end Buffer;
   B: Buffer;
end bufor;
