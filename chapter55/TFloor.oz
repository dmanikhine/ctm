functor
import
   Ports
   Timer
   Browser
   OS
export
   floor:Floor
define
   fun {Floor Num Init Lifts}
   %Tid={Timer.timer}
   Fid={Ports.new_port_object Init
	fun {$ Msg state(Called)}
	   case Called
	   of notcalled then Lran in
	      {Browser.browse  'notcalled'}
              state(called)
	      % case Msg
	      % of arrive(Ack) then
	      %	 {Browser.browse  'Lift at floor '#Num#': open doors '}
	      %	 {Send Tid starttimer(5000 Fid)}
	      %	 state(doorsopen(Ack))
	      % [] call then
	      %	 {Browser.browse  'Floor '#Num#' calls a lift! '}
	      %	 Lran=Lifts.(1+{OS.rand} mod {Width Lifts})
	      %	 {Send Lran call(Num)}
	      %  state(called)
	      %  end
	   [] called then
	      case Msg
	      of arrive(Ack) then
		 {Browser.browse  'Lift at floor '#Num#': open doors '}
		 {Send Tid starttimer(5000 Fid)}
		 state(doorsopen(Ack))
	      [] call then
		 state(called)
	      end
	   [] doorsopen(Ack) then
	      case Msg
	      of stoptimer then
		 {Browser.browse  'Lift at floor '#Num#': close doors '}
		 Ack=unit
		 state(notcalled)
	      [] arrive(A) then
		 A=Ack
		 state(doorsopen(Ack))
	      [] call then
		 state(doorsopen(Ack))
	      end
	   end
	end}      
   in Fid end
end
