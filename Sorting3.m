function Sorting3()
clc;
% Use ctrl+enter to run
% Generates a matrix of numbered students with their house aptitudes
% House poistioning is officialy [G S R H]

n = 20; % n is the number of incoming students

S = zeros(n,6);

% House Matrices
% Row size to accomodate irregular data; ideally n/4
GR = [];
SL = [];
RA = [];
HU = [];

% House Counts to expand house matrices for any number of fitting students
g_c = 1;
s_c = 1;
r_c = 1;
h_c = 1;

for i = 1:1:n
    % Generates a 4 column row vector filled with a random number 
    % between 1-10 for house aptitude
    R = rand(1,4).*10;
    
    % Stores the newest generated student aptitude vector in a "student list"
    S(i,1) = i;
    for run = 1:4
        S(i,run+1) = R(run);
    end
end

% Matches a student's aptitude scores with their student number
Student_List = S;
% Student_List = [...
%     1.0000    9    10    8    7   71.0000;...
%     2.0000    10    8    7    9   83.0000;...
%     3.0000    1    2    3    4   82.0000;...
%     4.0000    4    3    1    7   82.0000;...
%     5.0000    1    5    6    2   83.0000;...
%     6.0000    3    5    7    8   71.0000;...
%     7.0000    5    4    9    1   82.0000;...
%     8.0000    4    5    7    1   82.0000;...
%     9.0000    8    1    4    2   71.0000;...
%    10.0000    3    6    1    2   83.0000;...
%    11.0000    1    2    3    6   72.0000;...
%    12.0000    8    2    1    7   72.0000;...
%    13.0000    9    8    6    3   83.0000;...
%    14.0000    8    7    4    10   71.0000;...
%    15.0000    8    4    3    5   71.0000;...
%    16.0000    9    7    3    1   71.0000;...
%    17.0000    9    5    2    3   71.0000;...
%    18.0000    10    1    9    4   72.0000;...
%    19.0000    10    9    6    5   83.0000;...
%    20.0000    10    2    4    1   82.0000]; %For Testing


[GR,SL,RA,HU,Student_List] = file(Student_List);

% Initial Sort
function [GR,SL,RA,HU,MAT] = file(MAT)
    % Takes the maximun house value for each student
    for m = 1:1:n
        [smax(m),pos(m)] = max(MAT(m,2:5));
    end
    for h = 1:n
        if pos(h) == 1
            MAT(h,6) = 'G';
            GR(g_c,:) = MAT(h,:);
            g_c = g_c + 1;
        elseif pos(h) == 2
            MAT(h,6) = 'S';
            SL(s_c,:) = MAT(h,:);
            s_c = s_c + 1;
        elseif pos(h) == 3
            MAT(h,6) = 'R';
            RA(r_c,:) = MAT(h,:);
            r_c = r_c + 1;
        elseif pos(h) == 4
            MAT(h,6) = 'H';
            HU(h_c,:) = MAT(h,:);
            h_c = h_c + 1;
        end
    end
end

% Function for removing extras
function [GR,SL,RA,HU,rejects] = remove(GR,SL,RA,HU)
    rejects = [];
    limit = (n/4)+1;
    reject_pos = 1;
    for q = 1:n
        % Recalculating because otherwise this thing will error
        [rg,cg] = size(GR);
        [rs,cs] = size(SL);
        [rr,cr] = size(RA);
        [rh,ch] = size(HU);
        GR = sortrows(GR,2);
        SL = sortrows(SL,3);
        RA = sortrows(RA,4);
        HU = sortrows(HU,5);
        if rg >= limit
            rejects(reject_pos,:) = GR(1,:);
            rejects(reject_pos,2) = 0; % To eliminate the highest value
            GR(1,:) = [];
            reject_pos = reject_pos +1;
        elseif rs >= limit
            rejects(reject_pos,:) = SL(1,:);
            rejects(reject_pos,3) = 0; % To eliminate the highest value
            SL(1,:) = [];
            reject_pos = reject_pos +1;
        elseif rr >= limit
            rejects(reject_pos,:) = RA(1,:);
            rejects(reject_pos,4) = 0; % To eliminate the highest value
            RA(1,:) = [];
            reject_pos = reject_pos +1;
        elseif rh >= limit
            rejects(reject_pos,:) = HU(1,:);
            rejects(reject_pos,5) = 0; % To eliminate the highest value
            HU(1,:) = [];
            reject_pos = reject_pos +1;
        else
            continue
        end
    end
end

% REcursive Sorting?
function [GR,SL,RA,HU] = REsort(GR,SL,RA,HU,REmat)
    [row,col] = size(REmat); % Gets size of reject matrix
    for m = 1:1:row
        [smax(m),pos(m)] = max(REmat(m,2:5));
    end
    % +1 because we don't want to overwrite the last value
    [Gr,Gc] = size(GR); 
    [Sr,Sc] = size(SL); 
    [Rr,Rc] = size(RA); 
    [Hr,Hc] = size(HU); 
    Gr = Gr+1;
    Sr = Sr+1;
    Rr = Rr+1;
    Hr = Hr+1;
    for h = 1:length(pos)
        if pos(h) == 1
            GR(Gr,:) = REmat(h,:);
            Gr = Gr + 1;
        elseif pos(h) == 2
            SL(Sr,:) = REmat(h,:);
            Sr = Sr + 1;
        elseif pos(h) == 3
            RA(Rr,:) = REmat(h,:);
            Rr = Rr + 1;
        elseif pos(h) == 4
            HU(Hr,:) = REmat(h,:);
            Hr = Hr + 1;
        end
    end
end

%% Now To Size Check...
x=6; % stupid variable to keep the while loop
% Student_List
while x==6
    [rG,cG] = size(GR);
    [rS,cS] = size(SL);
    [rR,cS] = size(RA);
    [rH,cH] = size(HU);
  
    if rH==(n/4) && rG==(n/4) && rS==(n/4) && rR==(n/4) 
        % Final Answer: House Happiness
        [GR;0,0,0,0,0,0;SL;0,0,0,0,0,0;RA;0,0,0,0,0,0;HU]
        GR_happy = sum(GR(:,2))/rG
        SL_happy = sum(SL(:,3))/rS
        RA_happy = sum(RA(:,4))/rR
        HU_happy = sum(HU(:,5))/rH
        break
    else
        [GRmid,SLmid,RAmid,HUmid,rejects] = remove(GR,SL,RA,HU);
        [GR,SL,RA,HU] = REsort(GRmid,SLmid,RAmid,HUmid,rejects);
    end
end

end