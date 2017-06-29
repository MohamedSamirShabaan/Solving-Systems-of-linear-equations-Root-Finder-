function [iteration,x,error]=bisectionSim (table,plotter, f , xl , xu , es , imax)
global ii;
global lim;
global tim;
ii=0;
%table,plotter, f , xl , xu , es , imax;
NoRoot = MException( 'Bisection:NoRoot', 'no root in range' );
if((feval(f,xl) * feval(f,xu)) > 0)
    throw ( NoRoot );
end

x(1) = xl;
x(2) = xu;
lim(1) = x(1);
lim(2) = x(2);
iteration = 0 ;

for i = 1 : imax
    iteration = iteration+1;
    pause(tim);
    
    %(paint,f, l,u,r)
    xr = (xl+xu)/2;
    
    
    
    x(i+2) = xr;
    
    draw(plotter,f, xl, xu,xr);
    pause(tim);
    ea = abs((xu-xl)/xl);
    error(i) = ea;
    setTable(table,iteration,x,error);
    test = (feval(f,xl) * feval(f,xr));
    if(test < 0)
        xu = xr;
    else
        xl = xr;
    end
    
    %draw(plotter,f, xl, xu,xu+50);
    
    
    if(test==0)
        ea=0;
    end
    
    if(ea < es)
        break;
    end
    
end
ea = abs((xu-xl)/xl);
error(i+2) = ea;
axis([lim(1) lim(2) -10 10]);
    axis(plotter);
    y=-10:0.1:10;
    hold on
    
    plot(y,f(double(y)));
    
    grid on;
    zoom on;
    drawLines(plotter,xl, xu,xr);


function setTable(table,iter,x,errors)
 for i=1:iter
   ret(i,1) = i;
   ret(i,2) = x(i);
   ret(i,3) = errors(i);
   ret(i,4) = errors(i)*100;
end
ret(1,3) = 0;
ret(1,4) = 0;
    set(table,'Data',ret);




function draw(paint,f, l,u,r)
    cla;
    global ii;
    global lim;
    ii = ii+1;
    if (ii == 5)
        ii = 0;
        op = (abs(u-l))/2;
        lim(1) = l-op;
        lim(2) = u+op;
    end
    axis([lim(1) lim(2) -10 10]);
    axis(paint);
    y=-10:0.1:10;
    hold on
    
    plot(y,f(double(y)));
    
    grid on;
    zoom on;
    drawLines(paint,l,u,r);

    
    
function drawLines(paint, l, u,r) 
    global tim;
    plot([l l],get(paint,'YLim'),'-r')
    plot([u u],get(paint,'YLim'),'-r')
    pause(tim);
    plot([r r],get(paint,'YLim'),'-g')
    
