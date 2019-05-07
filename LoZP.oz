%usamos el intérprete de Scheme del libro Structure and Interpretation of Computer Programs como inspiración
%Mariana Rodriguez
%Pedro Salazar
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

   else {Browse 'Chispas Batman'}
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

fun{IsValue Exp}

end

fun{IsVariable Exp}

end

fun{IsDefvar Exp}

end

fun{IsDefun Exp}

end

fun{IsUnification Exp}

end

fun{IsConditional Exp}

end

fun{IsApplication Exp}

end

end