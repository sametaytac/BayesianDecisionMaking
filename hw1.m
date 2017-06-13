fileID = fopen('hwdata3d.mlm','r');
sizeA = [1 3];
formatSpec = '%d %d %d';
A = fscanf(fileID,formatSpec,sizeA);
b=A(1,1);
c=A(1,3);

sizeBig = [b+1 c];

formatSpec = '%f';

Big=fscanf(fileID,formatSpec,sizeBig);
Big=Big';
fclose(fileID);

for i=1:A(1,2),
Class{i}=Big(find(Big(:,4)==i),:);

end


for i=1:A(1,2),
Means{i}=mean(Class{i}(:,[1:3]));
Convs{i}=cov(Class{i}(:,[1:3]));
end


for j=1:A(1,2),
for i=1:length(Big),
    
     gvals{j}(i,:)=gfunc(Big(i,[1:3]), Means{j} , Convs{j}, length(Class{j})/length(Big) );
     

end
end

trueval=0;

for i=1:length(Big),
        temp=-1000;
        ind=1;
    for j=1:length(gvals),
        if(temp<gvals{j}(i,1))
           ind=j;
           temp=gvals{j}(i,1);
        end
    end
    if(Big(i,4)==ind)
        trueval=trueval+1;
    else
        wrongmat(i-trueval,:)=Big(i,:);
    end
    
    Truemat(i,:)=[Big(i,[1:3]),ind];

end
accurrencypartA=trueval/length(Big)
incorrectguesspartA = length(Big)-trueval

for i=1:A(1,2),
Classtrue{i}=Truemat(find(Truemat(:,4)==i),:);
end





figure
scatter3(Classtrue{1}(:,1),Classtrue{1}(:,2),Classtrue{1}(:,3),'g');
hold on;
scatter3(Classtrue{2}(:,1),Classtrue{2}(:,2),Classtrue{2}(:,3),'b');
hold on;
scatter3(Classtrue{3}(:,1),Classtrue{3}(:,2),Classtrue{3}(:,3),'y');
hold on;
scatter3(Classtrue{4}(:,1),Classtrue{4}(:,2),Classtrue{4}(:,3),'c');
hold on;
scatter3(Classtrue{5}(:,1),Classtrue{5}(:,2),Classtrue{5}(:,3),'m');
hold on;
scatter3(wrongmat(:,1),wrongmat(:,2),wrongmat(:,3),'.');
hold on;
xlabel('feature1');
ylabel('feature2');
zlabel('feature3');
axis auto


%2.part basliyor


R=[ 0 1 100 1 2;
    2 0 100 3 5;
    1 2 0 2 4;
    1 1 100 0 3;
    2 4 100 1 0];




for j=1:A(1,2),

for i=1:length(Big),
h2vals{j}(i,:)=0;

for k=1:A(1,2),
        same=pwix(Big(i,[1:3]),k, Convs,Means,Class,length(Big) );
     h2vals{j}(i,:)=h2vals{j}(i,:)+same*R(j,k);
    
end
h2vals{j}(i,:)=-h2vals{j}(i,:);
end
end




truevalue=0;

for i=1:length(Big),
        temp2=-1000;
        ind2=1;
    for j=1:length(h2vals),
        if(temp2<h2vals{j}(i,1))
           ind2=j;
           temp2=h2vals{j}(i,1);
        end
    end
    
    if(Big(i,4)==ind2)
        truevalue=truevalue+1;
    else
        wrongmat2(i-truevalue,:)=Big(i,:);
    end
    Truemat2(i,:)=[Big(i,[1:3]),ind2];

end
accurrencypartB=truevalue/length(Big)
incorrectguesspartB = length(Big)-truevalue



for i=1:A(1,2),
Classtrue2{i}=Truemat2(find(Truemat2(:,4)==i),:);
end














figure
scatter3(Classtrue2{1}(:,1),Classtrue2{1}(:,2),Classtrue2{1}(:,3),'g');
hold on;
scatter3(Classtrue2{2}(:,1),Classtrue2{2}(:,2),Classtrue2{2}(:,3),'b');
hold on;
scatter3(Classtrue2{3}(:,1),Classtrue2{3}(:,2),Classtrue2{3}(:,3),'y');
hold on;
scatter3(Classtrue2{4}(:,1),Classtrue2{4}(:,2),Classtrue2{4}(:,3),'c');
hold on;
scatter3(Classtrue2{5}(:,1),Classtrue2{5}(:,2),Classtrue2{5}(:,3),'m');
hold on;
scatter3(wrongmat2(:,1),wrongmat2(:,2),wrongmat2(:,3),'.');
hold on;
xlabel('feature1');
ylabel('feature2');
zlabel('feature3');

axis auto























