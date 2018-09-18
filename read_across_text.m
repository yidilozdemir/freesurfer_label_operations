
fid  = fopen('across_comparison.txt','r');
text = textscan(fid,'%s','Delimiter','','endofline','');
text = text{1}{1};
fid  = fclose(fid);
expression = '(?<=Overall Dice = )\d+\.?\d*';
Dice = regexp(text,expression,'match','dotexceptnewline');
Dice = Dice';
Dice = strrep( Dice(1:length(Dice)), '.' , ',');
expression_annot = '(?<=annot1:       )\w*\-\w*';
annot1 = regexp(text,expression_annot,'match','dotexceptnewline');
annot1 = annot1';
expression_2annot = '(?<=annot2:       )\w*\-\w*';
annot2 = regexp(text,expression_2annot,'match','dotexceptnewline');
annot2 = annot2'
index_of_ros=0;
index_of_manual=0;
% need to find starting indices of ros and manual to break the arrays and
% create columns for each comparison
for i = 1:length(annot1)
   if contains(annot1(i),'ros')
       index_of_ros=i;
       break;
   end
end
for x = index_of_ros:length(annot1)
    if contains(annot1(x), 'manual')
        index_of_manual=x;
        break;
    end
end
% Creating headings
annot2 = erase(annot2(1:length(annot1)),{'benson_','ros_','manual_'});
annot1 = erase(annot1(1:length(annot1)),{'benson_','ros_','manual_'});
main_columns = [{'benson'} {'ros'} {'manual'}];
xlswrite('across_comparison', main_columns(1),1, 'A1');
xlswrite('across_comparison', main_columns(2),1, 'D1');
xlswrite('across_comparison', main_columns(3),1, 'G1');
columns = [{'subject 1'}	{'subject 2'}	{'Dice coefficient'}];
xlswrite('across_comparison', columns,1, 'A2:C2')
xlswrite('across_comparison', columns,1, 'D2:F2')
xlswrite('across_comparison', columns,1, 'G2:I2')
% benson
xlRange = ['A3:A' num2str(index_of_ros+1)];
xlswrite('across_comparison', annot1(1:index_of_ros-1),1, xlRange);
xlRange = ['B3:B' num2str(index_of_ros+1)];
xlswrite('across_comparison',annot2(1:index_of_ros-1),1, xlRange);
xlRange = ['C3:C' num2str(index_of_ros+1)];
xlswrite('across_comparison' ,Dice(1:index_of_ros-1),1, xlRange);
% ros
xlRange = ['D3:D' num2str(index_of_ros+1)];
xlswrite('across_comparison', annot1(index_of_ros:index_of_manual-1),1, xlRange);
xlRange = ['E3:E' num2str(index_of_ros+1)];
xlswrite('across_comparison', annot2(index_of_ros:index_of_manual-1),1, xlRange);
xlRange = ['F3:F' num2str(index_of_ros+1)];
xlswrite('across_comparison', Dice(index_of_ros:index_of_manual-1),1, xlRange);
% manual
xlRange = ['G3:G' num2str(index_of_ros+1)];
xlswrite('across_comparison', annot1(index_of_manual:length(Dice)),1, xlRange);
xlRange = ['H3:H' num2str(index_of_ros+1)];
xlswrite('across_comparison', annot2(index_of_manual:length(Dice)),1, xlRange);
xlRange = ['I3:I' num2str(index_of_ros+1)];
xlswrite('across_comparison', Dice(index_of_manual:length(Dice)),1, xlRange);
% https://regex101.com/r/aA1cP9/1, for plotting, ex. of manual portion
sayi = cellfun(@str2num, Dice); 
plot(sayi(index_of_manual:length(sayi)), '*');
% to get in subj comparison from table
% m_r_table =xlsread('C:\Users\yagmuridil\Desktop\comparison.xlsx',2,
% 'M6:N7')

% bar( horzcat(b_m_table, b_r_table, m_r_table) )
% T.Properties.VariableNames = {'Benson_vs_Manual' 'Benson_vs_Rosenke' 'Manual_vs_Rosenke'}
% T.Properties.RowNames = [{'subject 1'} {'subject 2'} {'subject 3'} {'subject 4'} {'subject 5'} {'subject 6'} {'subject 7'} {'subject 8'}]
% T = table(b_m_table, b_r_table, m_r_table)
% rm = fitrm(T,'y1-y3 ~ 1') I later changes variable names to y1-y3
% multcompare(rm, 'Time', 'Alpha',0.01) --- for tukey's post hoc
% to add the extra points to manual,ros,benson 
% plot([8,16,32,40]', sayi,'r*', 'Markersize', 11);
% Dice = strrep( Dice(1:length(Dice)), ',' , '.');
% sayi = cellfun(@str2num, Dice(1:4))'
% for creating averaged graph with significance
figure
hold on
bar( [mean(b_m_table), mean(b_r_table), mean(m_r_table)])
% errorbar(1:3,[mean(b_m_table), mean(b_r_table), mean(m_r_table)],[(0.6928-0.5209),(0.8093-0.7833),(0.6495-0.5228)],'.')
sigstar({[2,3],[1,2], [1,3]},[0.01,0.01,0.01])

% xlswrite('intra_session.xlsx',table2array(OUTPUT), 1, 'A7' output is ans
% of multcompare and ranova
% https://stackoverflow.com/questions/26593900/unbalanced-anova-in-matlab
% for anova!!!
% 2 SAMPLE K-S:
% xlswrite('across_comparison_session',[h,p,k],1,'A4') 
% sayi = cellfun(@str2num, Dice(9:12))'
% Dice_ros = xlsread('across_comparison.xls',1,'F3:F58')
% [h,p,k] = kstest2(Dice_ros, sayi)
% FOR anova btwn : 
% Dice_ros_hor = Dice_ros'
% Combined_ros = [ sayi Dice_ros_hor]
% C(1:4) = {'G1'}
% C(5:60) = {'G2'}
% [p1] = anova1(Combined_ros, C)




