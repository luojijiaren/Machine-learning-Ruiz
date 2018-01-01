function[r] = replaceNum(adult)
    class2 = unique(adult(:,2));
    class4 = unique(adult(:,4));
    class6 = unique(adult(:,6));
    class7 = unique(adult(:,7));
    class8 = unique(adult(:,8));
    class9 = unique(adult(:,9));
    class10 = unique(adult(:,10));
    class14 = unique(adult(:,14));
    classes = unique(adult(:,15));
    r = adult;
    
    for i = 1:length(adult)
        r(i,2) = num2cell(find(not(cellfun('isempty',strfind(class2,adult(i,2))))));
        r(i,4) = num2cell(find(not(cellfun('isempty',strfind(class4,adult(i,4))))));
        r(i,6) = num2cell(find(not(cellfun('isempty',strfind(class6,adult(i,6))))));
        r(i,7) = num2cell(find(not(cellfun('isempty',strfind(class7,adult(i,7))))));
        r(i,8) = num2cell(find(not(cellfun('isempty',strfind(class8,adult(i,8))))));
        r(i,9) = num2cell(find(not(cellfun('isempty',strfind(class9,adult(i,9))))));
        r(i,10) = num2cell(find(not(cellfun('isempty',strfind(class10,adult(i,10))))));
        r(i,14) = num2cell(find(not(cellfun('isempty',strfind(class14,adult(i,14))))));
        r(i,15) = num2cell(find(not(cellfun('isempty',strfind(classes,adult(i,15))))));
    end
end