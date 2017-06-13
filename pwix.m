function y = pwix( x,counter,convs,means,class2,len )

p=0;

for i=1:length(convs),
    
    p=p+(pxwi(x,convs{i},means{i})*(length(class2{i})/len));

   
end

y=(pxwi(x,convs{counter},means{counter})*(length(class2{counter})/len))/p;


end