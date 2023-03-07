functor
import
   OS
   Browser
   Ports
define
   fun {Player Others}
      {Ports.new_port_object2
       proc {$ Msg}
          {Delay 1000}
	  case Msg of ball then
	     Ran={OS.rand} mod {Width Others} + 1
	  in        
             {Browser.browse Ran}  
	     {Send Others.Ran ball}
	  end
       end}
   end
   P1={Player others(P2 P3)}
   P2={Player others(P1 P3)}
   P3={Player others(P1 P2)}
   {Send P1 ball}	
end

