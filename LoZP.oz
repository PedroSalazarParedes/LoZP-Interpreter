%usamos el intérprete de Scheme del libro Structure and Interpretation of Computer Programs como inspiración
%Mariana Rodriguez
%Pedro Salazar
declare

%'main' function
fun{PedroEsLoMax L}
   
   case L 
   of X|Xs {Interpret X 

end

%Eval
fun{Interpret L Ctx}

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

   else raise chispasBatman end
   end
end

%Apply
fun{MyApply Proc Args}

   if {IsInMozart Exp}
   then {ApplyMozartProc Proc Args}

   elseif {IsCompund Proc}
   then {EvalSec {GetBody Proc}
   {ExtendEnv {GetArgs Proc} Args {GetProcEnv Proc}}}

   else raise yucas end
   end
end

fun{IsValue Exp}
   {Or {IsNumber Exp}{IsBool Exp}}
end

fun{IsVariable Exp}
   {IsAtom Exp}
end

fun{IsDefvar Exp}
   {= Exp.1 'defvar'}
end

fun{IsDefun Exp}
   {= Exp.1 'defun'}
end

fun{IsUnification Exp}
   {= Exp.1 'unify'}
end

fun{IsConditional Exp}
   {= Exp.1 'conditional'}
end

fun{IsApplication Exp}
   {IsList Exp}
end

end