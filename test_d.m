#I am not sure what this is, will get back to it.

fid  = fopen('across_comparison_session.txt','r');
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
