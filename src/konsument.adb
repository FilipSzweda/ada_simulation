package body konsument is
task body Consumer is
      subtype Consumption_Time_Range is Integer range 4 .. 8;
      package Random_Consumption is new
	Ada.Numerics.Discrete_Random(Consumption_Time_Range);
      G: Random_Consumption.Generator;	--  random number generator (time)
      G2: Random_Assembly.Generator;	--  also (assemblies)
      Consumer_Nb: Consumer_Type;
      Consumption: Integer;
      Assembly_Type: Integer;
      Consumer_Name: constant array (1 .. Number_Of_Consumers)
	of String(1 .. 13)
	:= ("Consumer n. 1", "Consumer n. 2");
   begin
      accept Start(Consumer_Number: in Consumer_Type;
		     Consumption_Time: in Integer) do
	 Random_Consumption.Reset(G);	--  ustaw generator
	 Random_Assembly.Reset(G2);	--  tez
	 Consumer_Nb := Consumer_Number;
	 Consumption := Consumption_Time;
      end Start;
      Put_Line("Started consumer " & Consumer_Name(Consumer_Nb));
      loop
	 delay Duration(Random_Consumption.Random(G)); --  simulate consumption
	 Assembly_Type := Random_Assembly.Random(G2);
    -- take an assembly for consumption
    select
       B.Deliver(Assembly_Type, Consumer_Name(Consumer_Nb));
     or delay 1.0;
       Assembly_Type := Random_Assembly.Random(G2);
       Put_Line(Consumer_Name(Consumer_Nb) & " changed his mind, they want to order " &
                  To_String(Assembly_Name(Assembly_Type)) & " now");
       B.Deliver(Assembly_Type, Consumer_Name(Consumer_Nb));
    end select;
      end loop;
   end Consumer;
end konsument;
