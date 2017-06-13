function y = pxwi( x,cov1,mean1 )

y=exp((-0.5)*(x-mean1)*(inv(cov1))*(x-mean1)')/(2*pi*sqrt(det(cov1)));
end

