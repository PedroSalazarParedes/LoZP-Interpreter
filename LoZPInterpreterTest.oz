
declare
fun{Interpret L Ctx}
   L
end

fun{MyEval Exp Env}
   
   if {IsValue Exp}
   then Exp
      
   elseif {IsVaraible Exp}
   then {LookupVariable Exp Env}

   elseif {IsUnification Exp}
   then {EvalUnification Exp Env}

   elseif {IsDefun Exp}
   then {EvalDefun Exp Env}

   elseif {IsConditional Exp}
   then {EvalConditional Exp Env}

   elseif {IsApplication Exp}
   then {MyApply {MyEval {Operator Exp} Env}
    {ListOfValues {Operands Exp} Env}}
      
   end
end

fun{MyApply Proc Args}
   Proc
end
