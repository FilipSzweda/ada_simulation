-- A skeleton of a program for an assignment in programming languages
-- The students should rename the tasks of producers, consumers, and the buffer
-- Then, they should change them so that they would fit their assignments
-- They should also complete the code with constructions that lack there
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; 
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with bufor;
with konsument;
with producent;

procedure Main is
   Number_Of_Products: constant Integer := 5;
   Number_Of_Assemblies: constant Integer := 3;
   Number_Of_Consumers: constant Integer := 2;
   subtype Product_Type is Integer range 1 .. Number_Of_Products;
   subtype Assembly_Type is Integer range 1 .. Number_Of_Assemblies;
   subtype Consumer_Type is Integer range 1 .. Number_Of_Consumers;
   Product_Name: constant array (Product_Type) of Unbounded_String
     := (To_Unbounded_String("Egg"), To_Unbounded_String("Potato"), To_Unbounded_String("Beef"), To_Unbounded_String("Sausage"), To_Unbounded_String("Bacon"));
   Assembly_Name: constant array (Assembly_Type) of Unbounded_String
     := (To_Unbounded_String("English Breakfast"), To_Unbounded_String("Roasted Beef with Potatoes"), To_Unbounded_String("Fried Eggs with Bacon"));
   package Random_Assembly is new
     Ada.Numerics.Discrete_Random(Assembly_Type);
   type My_Str is new String(1 ..256);
   
   P: array ( 1 .. Number_Of_Products ) of producent.Producer;
   K: array ( 1 .. Number_Of_Consumers ) of konsument.Consumer;
   B: Bufor.Buffer;

   

   

   
   
begin
   for I in 1 .. Number_Of_Products loop
      P(I).Start(I, 10);
   end loop;
   for J in 1 .. Number_Of_Consumers loop
      K(J).Start(J,12);
   end loop;
end Main;


