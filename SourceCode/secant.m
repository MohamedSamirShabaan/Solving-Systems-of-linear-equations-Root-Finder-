function [itr,x,error] = secant ( f , xi , xj , es , itrMax)

t(1) = xi;
t(2) = xj;
itr = 0 ;

for i = 1 : itrMax
    itr = itr + 1;
    t(i + 2) = t(i + 1) - ((f(t(i + 1)) * (t(i) - t(i + 1))) / (f(t(i)) - f(t(i + 1))));
    x(i) = t(i+2);
    ea = abs((t(i+2)-t(i+1)) / t(i+2));
    error(i) = ea;
    if(ea < es)
        break;
    end    
end

end

