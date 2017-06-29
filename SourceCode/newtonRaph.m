function [itr,x,error] = newtonRaph(f , xi , es , itrMax)

d = diff(f);
x(1) = double(xi);
error(1) = 0;
flag = 1;
for i = 1:itrMax
    if(abs(d(x(i))) < 1e-50)
        flag = 0;
        break;
    end
    x(i+1) = double(x(i) - ( f(x(i))  / d(x(i)) ));
    error(i + 1) = abs ( ( x(i+1) - x(i) ) / x(i+1) );
    if( error(i + 1) < es )
        break;
    end
end
if((abs((x(i+1) - x(i)) / x(i+1)) > es))
    flag =0;
end
itr = i;

end

