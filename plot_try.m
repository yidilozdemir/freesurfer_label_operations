 figure;
 hold on;
 cellfun(@histogram,Dice);
 
 hist(cell2mat(cellfun(@histogram, Dice)))
 
 #I will get back to this. 
