%all copy right saved to Samir && Heeba
function [itr,x,error]=bisection ( f , xl , xu , es , itrMax)
% if all function is above x-axis ---> no root exception
NoRoot = MException( 'Bisection:NoRoot', 'no root in range' );
if((feval(f,xl) * feval(f,xu)) >= 0)
    throw ( NoRoot );
end

%begain the core of bisection 

%inisial value
l(1) = xl;
u(1) = xu;
error(1) = 0;
itr = 0 ;

%begin itrations
for i = 1 : itrMax
    itr = itr + 1;
    x(i) = ( l(i) + u(i) )/2;
    yl(i) = feval(f,l(i));
    yu(i) = feval(f,u(i));
    yr(i) = feval(f,x(i));
    test = yl(i)*yr(i);
    if(test == 0)
        if(yl(i)==0)
            x(i) = l(i);
        elseif(yu(i)==0)
            x(i) = u(i);
        end
        ea=0;
        error(i) = ea;
        break;
    elseif(test > 0)
        l(i+1) = x(i);
        u(i+1) = u(i);
    else
        u(i+1) = x(i);
        l(i+1) = l(i);
    end
    if(i>1)
        ea = abs( (x(i)-x(i-1) ) /x(i) );
        error(i) = ea;
        if(ea<es)
            return;
        end
    end
    
end

end
