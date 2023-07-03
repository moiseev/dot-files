function rat --wraps='rebar3 as test' --description 'alias rat=rebar3 as test'
  rebar3 as test $argv; 
end
