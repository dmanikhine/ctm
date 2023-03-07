functor
import
   Ports
export
   timer:Timer
define
   fun {Timer}
      {Ports.new_port_object2
       proc {$ Msg}
	  case Msg of starttimer(T Pid) then
	     thread {Delay T} {Send Pid stoptimer}  end
	  end
       end}
   end
end