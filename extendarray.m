 function [outputa]=extendarray(inputa,n)
outputa=ones(length(inputa),n);
for i=1:length(inputa)
   outputa(i,:)= outputa(i,:)*inputa(i);
end
outputa=reshape(outputa',[1,length(inputa)*n]);
end