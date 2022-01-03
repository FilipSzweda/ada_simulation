with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with bufor;

package konsument is
   Number_Of_Consumers: constant Integer := 2;
   subtype Consumer_Type is Integer range 1 .. Number_Of_Consumers;
   package Random_Assembly is new
     Ada.Numerics.Discrete_Random(bufor.Assembly_Type);

-- Consumer gets an arbitrary assembly of several products from the buffer
   task type Consumer is
      -- Give the Consumer an identity
      entry Start(Consumer_Number: in Consumer_Type;
		    Consumption_Time: in Integer);
   end Consumer;
end konsument;
