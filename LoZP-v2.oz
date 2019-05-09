%usamos el interpreter de Scheme del libro Structure and Interpretation of Computer Programs como inspiracion
%Mariana Rodriguez
%Pedro Salazar
declare

%Main
fun{Main LoZP}
   fun{Main2 LoZP Env}
      case LoZP of nil then 'se acabu' end
   [] H|T then
      local Res in
    Res = {MyEval H nil}
    if {IsEnvironment Res}
    then {Main2 T Res}
    else Res
    end
      end
   end
   end
   {Main2 LoZP nil}
end



%Interpret
fun{Interpret L Ctx}
   {MyEval L Ctx}
end

%Eval
fun{MyEval Exp Env}

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
   then {MyApply Exp.1 {Map Exp.2 fun{$ X} {MyEval X Env} end} Env}

   else raise chispasBatman end
   end
end

%Apply
fun{MyApply Proc Args Env}
   if Proc == 'eq'
   then
      if {List.length Args} == 2 then  Args.1 == Args.2.1
      else raise wrongNumberOfParams end
      end
   elseif Proc == 'leq'
   then
      if {List.length Args} == 2 then Args.1 =< Args.2.1
      else raise wrongNumberOfParams end
      end
   elseif Proc == 'geq'
   then
      if ({List.length Args} == 2) then  Args.1 >= Args.2.1
      else raise wrongNumberOfParams end
      end
   elseif Proc == 'sum'
   then
      if {List.length Args} == 2 then  Args.1 + Args.2.1
      else raise wrongNumberOfParams end
      end
   elseif Proc == 'subtract'
   then
      if {List.length Args} == 2 then  Args.1 - Args.2.1
      else raise wrongNumberOfParams end
      end
   elseif Proc == 'multiply'
   then
      if {List.length Args} == 2 then  Args.1 * Args.2.1
      else raise wrongNumberOfParams end
      end
   elseif Proc == 'divide'
   then
      if {List.length Args} == 2 then  Args.1 / Args.2.1
      else raise wrongNumberOfParams end
      end
   else      
      local X in
	 X = {LookupVariable Proc Env}
	 if X.1 == 'closure'
	 then {EvalSequence X.2.2.2.1 {ExtendEnv X.2.2.1 Args X.2.1}}
	 else raise notAFunction end
	 end
      end
   end
end

fun {ExtendEnv Params Args Env}
   case Env of nil then nil | [{MakeRecord env [Exp]}]
   [] H|T then nil |{ExtendLocalEnv Params Args H} | T
   end
end

fun {ExtendLocalEnv Params Args LocalEnv}
   case LocalEnv of nil then {MakeRecord env [Exp]}
   else
      {Record.adjoinList LocalEnv {List.zip Params Args fun {$ I A} I#A end} }
   end
end

fun{EvalSequence Proc Env}
   case Proc of nil then raise funcionSinRetorno end
   [] H|T then
      local Res in
	 Res = {MyEval H Env}
	 if {IsEnvironment Res}
	 then {EvalSequence T Res}
	 else Res
	 end
      end
   end
end

fun {LookupVariable Exp Env}
   case Env of nil then raise noExisteVariable end
   [] H|T then
      try
	 {LookupVarEnv Exp H}
      catch noExisteVariable then
	 {LookupVariable Exp T}
      end
   end
end

fun{LookupVarEnv Exp LocalEnv}
   if {Value.hasFeature LocalEnv Exp}
   then
      local Y in {Value.condSelect LocalEnv Exp 0 Y}
	 if {IsDet Y} then Y
	 else raise noValorAsignado end
	 end
      end      
   else raise noExisteVariable end
   end
end

   
fun {EvalDefvar Exp Env}
   case Env of nil then [{MakeRecord env [Exp.2.1]}]
   [] H|T then {Extendvar Exp H} | T
   end
end

fun {Extendvar Exp LocalEnv}
   case LocalEnv of nil then {MakeRecord env [Exp]}
   else
      if {Value.hasFeature LocalEnv Exp} then raise yaExisteLaVariable end
      else {AdjoinAt LocalEnv  Exp _}
      end
   end
end

fun {EvalDefun Exp Env}
   case Env of nil then [{AdjoinAt {MakeRecord env [Exp.2.1]} Exp.2.1 'closure'|Env|Exp.2.2}]
   [] H|T then {Extendfun Exp H Env} | T
   end
end

fun {Extendfun Exp LocalEnv Env}
   case LocalEnv of nil then {AdjoinAt {MakeRecord env [Exp.2.1]} Exp.2.1 'closure'|Env|Exp.2.2}
   else
      if {Value.hasFeature LocalEnv Exp.2.1} then raise yaExisteLaVariable end
      else  {AdjoinAt LocalEnv  Exp.2.1 'closure'|Env|Exp.2.2}
      end
   end
end

fun{EvalUnification Exp Env}
   case Env of nil then raise unboundVariable end
   [] H|T then 
      try if {MyEval Exp.2.1 Env} == {MyEval Exp.2.2.1 Env} then Env
	  else raise esoNoUnifiK end 
	  end
      catch noValorAsignado then 
	 try
	    {AdjoinAt H Exp.2.1 {MyEval Exp.2.2.1 Env}}|T
	 catch noValorAsignado then {AdjoinAt H Exp.2.2.1 {MyEval Exp.2.1 Env}}|T 
	 end
      [] noExisteVariable then raise unboundVariable end
      end
   end
end

fun {EvalConditional Exp Env}
   if {MyEval Exp.2.1 Env}
   then {MyEval Exp.2.2.1 Env}
   else {MyEval Exp.2.2.2.1 Env}
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

fun{IsEnvironment Exp}
   {IsList Exp} andthen {IsRecord Exp.1}
end


{Browse {MyEval [defvar n]  nil}}
{Browse {MyEval [conditional [eq 1 0] 1 2]  [nil]}}
{Browse {MyEval [defun  fac [n][[ conditional [eq n 0] 1 [multiply n [fac [subtract n 1]]]]]]   [nil]}}
{Browse {MyEval [unify x n] [env(n:_ )]}}
%{Browse {MyApply eq [0 1] [env(n:1)]}}
