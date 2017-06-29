function [y, final, error]=lagrange(pointx,pointy,x,n)

final = strcat('', '0');
error = strcat('', '');
if (size(pointx,1)~=size(pointy,1))
    error = strcat('', 'ERROR!! X array and Y array must have the same number of elements');
    y=NaN;
    return;
end
if( (x<pointx(1)) || (x>pointx(size(pointx,1))) )
    error = strcat('', 'ERROR!! You want to find extrapolation and this method calculates only Interpolation!!');
    y=NaN;
    return;
end
if(n > size(pointx,1)-1)
    error = strcat('', 'ERROR!! Order of polynomial must be <= size of array - 1 !!');
    y=NaN;
    return;
end

p = 0;
for(i=1:size(pointx,1))
    if(pointx(i)>=x)
        p = i;
        break;
    end
end
while(1)
    if(p-ceil(n/2)>=1)
        if(p+floor(n/2)<=size(pointx,1))
            p = p-ceil(n/2);
            break;
        else
            p = p-1;
        end
    else
        p = p+1;
    end
end
L=ones(n+1);
y=0;
for i=1:(n+1)
  result = strcat('', int2str(1));
  for j=1:(n+1)
     if (i~=j)
         L(i)=L(i).*(x-pointx(j+p-1))/(pointx(i+p-1)-pointx(j+p-1));
         result = strcat(result, '*(1/', '(', num2str((pointx(i+p-1)-pointx(j+p-1))), ')', ')', '*(x-', '(' , num2str(pointx(j+p-1)), ')', ')');
     end
  end
  y=y+pointy(i+p-1)*L(i);
  final = strcat(final, '+', '(', num2str(pointy(i+p-1)), ')', '*', result);
end