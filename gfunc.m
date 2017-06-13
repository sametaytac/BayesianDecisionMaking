function y = gfunc(x,mean1,cov1,mlike)


y= -(0.5)*(x-mean1)*(inv(cov1))*(x-mean1)'-((0.5)*log(det(cov1))+log(mlike));
end

