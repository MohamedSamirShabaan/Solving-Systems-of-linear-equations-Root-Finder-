function [iteration,x,ea] = fixedPoint(g , guess , es , imax)
DivergeExcep = MException( 'FIXEDPOINT:DIVERGE', 'The equation is diverge.' );
x(1) = guess;

iteration = 0;
for i = 1 : imax
    iteration = iteration+1;
    x(i+1) = feval(g,x(i));
    ea(i) = abs( ( x(i+1) - x(i) ) / x(i + 1) );
    if (ea(i) < es )
        ea(i+1) = abs( ( x(i+1) - x(i) ) / x(i + 1) );
        return;
    end
end
throw ( DivergeExcep );
end
        