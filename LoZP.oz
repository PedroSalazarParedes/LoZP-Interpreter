%usamos el intérprete de Scheme del libro Structure and Interpretation of Computer Programs como inspiración
%Mariana Rodriguez
%Pedro Salazar
declare

%'main' function

%Eval
fun{Interpret Exp Env}

   if {IsValue Exp}
   then Exp
      
   elseif {IsVariable Exp}
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
   then {MyApply Exp.1 {Map fun{$ X} {Interpret X Env} end Exp.2} Env}

   else raise chispasBatman end
   end
end

%Apply
fun{MyApply Proc Args Env}

   {Interpret {LookupBody Proc} {ExtendEnv Args Env}}

end

fun {LookupVariable Exp Env} x end
fun {LookupBody Proc} x end
fun {ExtendEnv Args Env} x end
fun {EvalDefvar Exp Env} x end
fun {EvalDefun Exp Env} x end
fun {EvalUnification Exp Env} x end
fun {EvalConditional Exp Env} x end

fun{IsValue Exp}
   {Or {IsNumber Exp}{IsBool Exp}}
end

fun{IsVariable Exp}
   {IsAtom Exp}
end

fun{IsDefvar Exp}
   Exp.1 == 'defvar'
end

fun{IsDefun Exp}
  Exp.1 == 'defun'
end

fun{IsUnification Exp}
   Exp.1 == 'unify'
end

fun{IsConditional Exp}
   Exp.1 == 'conditional'
end

fun{IsApplication Exp}
   {IsList Exp}
end





{Browse {Interpret x nil}}

