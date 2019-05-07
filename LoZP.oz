
declare

%'main' function
fun{Interpret L Ctx}
   L
end

%Eval
fun{MyEval Exp Env}
   if {IsValue Exp}
   then Exp
      
   elseif {IsVaraible Exp}
   then {LookupVariable Exp Env}

   elseif {IsDefvar Exp}
   then {EvalDefvar Exp Env}

   elseif {IsDefun Exp}
   then {EvalDefun Exp Env}

   elseif {IsUnification Exp}
   then {EvalUnification Exp Env}

   elseif {IsConditional Exp}
   then {EvalConditional Exp Env}

   elseif {IsApplication Exp}
   then {MyApply {MyEval Exp.1 Env}
	 {ListOfValues Exp.2 Env}}

   else {Browse 'Syntax error?'}
      
   end
end

%Apply
fun{MyApply Proc Args}
   if {IsInMozart Exp}
   then {ApplyMozartProc Proc Args}

   elseif {IsCompund Proc}
   then {EvalSec {GetBody Proc}
   {ExtendEnv {GetArgs Proc} Args {GetProcEnv Proc}}}

   else {Browse 'yucas'}
      
   end
end

