functor
import
   Controller
   Lift
   Floor
define
   proc {Building FN LN ?Floors ?Lifts}
      Lifts={MakeTuple lifts LN}
      for I in 1..LN do Cid in
	 Cid={Controller.controller state(stopped 1 Lifts.I)}
	 Lifts.I={Lift.lift I state(1 nil false) Cid Floors}
      end
      Floors={MakeTuple floors FN}
      for I in 1..FN do
	 Floors.I={Floor.floor I state(notcalled) Lifts}
      end
   end
F L in
{Building 10 2 F L}
{Send F.9 call}
{Send F.10 call}
{Send L.1 call(4)}
{Send L.2 call(5)}
end
