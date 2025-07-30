function [t] = solvet(para)

syms t
eqn = log(t+1)+1/(t+1) == 2*para.epsilon^2 + 1;
solx = solve(eqn,t);

for i=1:length(solx)

    if double(solx(i)) >= 0
        t = double(solx(i));
    end
end

end