 figure;
 hold on;
 cellfun(@histogram,Dice);
 
 hist(cell2mat(cellfun(@histogram, Dice)))
 