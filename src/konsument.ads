package konsument is
-- Consumer gets an arbitrary assembly of several products from the buffer
   task type Consumer is
      -- Give the Consumer an identity
      entry Start(Consumer_Number: in Consumer_Type;
		    Consumption_Time: in Integer);
   end Consumer;
end konsument;
