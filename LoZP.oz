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
   then {EvalDefvar Exp Env} %Piter

   elseif {IsDefun Exp}
   then {EvalDefun Exp Env}

   elseif {IsUnification Exp}
   then {EvalUnification Exp Env}%Piter

   elseif {IsConditional Exp}
   then {EvalConditional Exp Env}

   elseif {IsApplication Exp}
   then {MyApply Exp.1 {Map fun{$ X} {Interpret X Env} end Exp.2} Env}

   else raise chispasBatman end
   end
end

%Apply
fun{MyApply Proc Args Env}
   local X in
      X = {LookupVariable Proc Env}
      if X.1 == 'closure'
      then {EvalSequence X.2.2.1 {ExtendEnv X.2.1 Args X.2.2.2.1}}
      else raise notAFunction end
      end
   end
end

fun{EvalSequence Proc Env}
   case Proc of H|T then
      if H\=nil andthen T==nil then {Interpret H Env}
      elseif H\=nil andthen T\=nil then {Interpret H Env} {EvalSequence T Env}
      end
   end
end

fun {LookupVariable Exp Env}
   if {Value.hasFeature Env Exp}
   then
      local Y in {Value.condSelect Env Exp 0 Y}
	 if {IsBound Y} then Y
	 else raise noValorAsignado end
	 end
      end    
   else raise noExisteVariable end
   end
end

fun {ExtendEnv Params Args Env}
   {Record.adjoinList Env {List.zip Params Args fun {$ I A} I#A end} }
end
   
fun {EvalDefvar Exp Env} x end

fun {EvalDefun Exp Env}
   if {Value.hasFeature Env Exp.1}
   then raise yaExisteVariable end
   else {Append Exp.2.2.1 Env}
   end
end

fun {EvalUnification Exp Env} x end

fun {EvalConditional Exp Env}
   if {Interpret Exp.1 Env}
   then {Interpret Exp.2.1 Env}
   else {Interpret Exp.2.2.1 Env}
   end
end

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
   {IsList Exp} andthen {IsAtom Exp.1}
end





{Browse {Interpret x nil}}
{Browse {Interpret x env(x:0)}}

