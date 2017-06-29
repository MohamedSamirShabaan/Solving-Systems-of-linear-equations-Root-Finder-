function [f, final, error] = Newton (x, y, p, n)

final = strcat('', '0');
error = strcat('', '');
if (size(x,1)~=size(y,1))
    error = strcat('', 'ERROR!! X array and Y array must have the same number of elements');
    f=NaN;
    return;
end
if( (p<x(1)) || (p>x(size(x,1))) )
    error = strcat('', 'ERROR!! You want to find extrapolation and this method calculates only Interpolation!!');
    f=NaN;
    return;
end
if(n > size(x,1)-1)
    error = strcat('', 'ERROR!! Order of polynomial must be <= size of array - 1 !!');
    f=NaN;
    return;
end

m = 0;
for(i=1:size(x,1))
    if(x(i)>=p)
        m = i;
        break;
    end
end
while(1)
    if(m-ceil(n/2)>=1)
        if(m+floor(n/2)<=size(x,1))
            m = m-ceil(n/2);
            break;
        else
            m = m-1;
        end
    else
        m = m+1;
    end
end
last = m+n;
n = n + 1;
d(:,1)=y(m:last)';
for j=2:n
    for i=j:n
        d(i,j)= ( d(i-1,j-1)-d(i,j-1)) / (x(i-j+m)-x(i+m-1));
    end
end
a = diag(d)';

Df(1,:) = repmat(1, size(p));
c(1,:) = repmat(a(1), size(p));
for j = 2 : n
   Df(j,:)=(p - x(j+m-2)) .* Df(j-1,:);
   c(j,:) = a(j) .* Df(j,:);
end
final  = strcat('', num2str(a(1)));
str1 = strcat('', '');
k = 1;
str2 = strcat('', '');
for i = 2:length(a)
  for j = 1:k
    if(j ~= k)
      str1 = strcat(str1, '(x - ', '(', num2str(x(j+m-1)), ')', ')', '*');
    else
      str1 = strcat(str1, '(x - ', '(', num2str(x(j+m-1)), ')', ')');  
    end  
  end
  k = k + 1;
  str2 = strcat(str2, '(', num2str(a(i)), ')', ' * ', str1, ' + ');
  str1 = strcat('', '');
end  
f=sum(c);
final = strcat(final, ' + ', str2, ' 0 ');