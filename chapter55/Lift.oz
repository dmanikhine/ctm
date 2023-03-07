functor
import
   Ports
   Browser
   Schedule
export
   lift:Lift
define
   fun {Lift Num Init Cid Floors}
   {Ports.new_port_object Init
    fun {$ Msg state(Pos Sched Moving)}
       case Msg
       of call(N) then
	  {Browser.browse  'Lift '#Num#' needed at floor  '#N}
	  if N==Pos andthen {Not Moving} then
	     {Wait {Send Floors.Pos arrive($)}}
	     state(Pos Sched false)
	  else Sched2 in
	     Sched2={Schedule.schedule Sched N}
	     if {Not Moving} then
		{Send Cid step(N)} end
	     state(Pos Sched2 true)
	  end
       []  'at'(NewPos) then
	  {Browser.browse  'Lift  '#Num#' at floor '#NewPos}
	  case Sched
	  of S|Sched2 then
	     if NewPos==S then
		{Wait {Send Floors.S arrive($)}}
		if Sched2==nil then
		   state(NewPos nil false)
		else
		   {Send Cid step(Sched2.1)}
		   state(NewPos Sched2 true)
		end
	     else
		{Send Cid step(S)}
		state(NewPos Sched Moving)
	     end
	  end
       end
    end}
   end
end
