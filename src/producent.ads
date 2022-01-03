with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
limited with bufor;
package producent is
   Number_Of_Products: constant Integer := 5;
   subtype Product_Type is Integer range 1 .. Number_Of_Products;
   Product_Name: constant array (producent.Product_Type) of Unbounded_String
     := (To_Unbounded_String("Egg"), To_Unbounded_String("Potato"), To_Unbounded_String("Beef"), To_Unbounded_String("Sausage"), To_Unbounded_String("Bacon"));

-- Producer produces determined product
   task type Producer is
      -- Give the Producer an identity, i.e. the product type
      entry Start(Product: in Product_Type; Production_Time: in Integer);
   end Producer;
end producent;
