functor
import
   Ports
   Timer
export
   controller:Controller
define
   fun {Controller Init}
      Tid={Timer.timer}
      Cid={Ports.new_port_object Init
	   fun {$ Msg state(Motor F Lid)}
	      case Motor
	      of running then
		 case Msg
		 of stoptimer then
		 {Send Lid 'at'(F)}
		 state(stopped F Lid)
	      end
	   [] stopped then
	      case Msg
	      of step(Dest) then
		 if F==Dest then
		    state(stopped F Lid)
		 elseif F<Dest then
		    {Send Tid starttimer(5000 Cid)}
		    state(running F+1 Lid)
		 else % F>Dest
		    {Send Tid starttimer(5000 Cid)}
		    state(running F-1 Lid)
		 end
	      end
	   end
	end}
in Cid end
end