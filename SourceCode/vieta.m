function [itr,x,error] = vieta( f , r , es , itrMax)

syms x;
symbol(x) = sym(f);
coff = sym2poly(symbol);
len = length(coff);
itr = 0 ;
error(1) = 0;
x(1) = r;
b(1) = coff(1);
c(1) = coff(1);

for j = 1 : itrMax
    itr = itr + 1 ;
    for i = 1  :len-1
        b(i+1) = coff(i+1) + (x(itr) * b(i));
        c(i+1) = b(i+1)  + (x(itr) * c(i));
    end
    if(b(len) == 0) 
        break;
    else
        
        if(itr > 1)
            ea= abs(x(itr)-x(itr-1))/abs(x(itr)) ;
            error(itr) = ea;
            if(ea < es)
                break;
            end
        end
        x(itr+1) = x(itr) - (b(len)/c(len-1));
    end

end
%error(j) = 0;
end

