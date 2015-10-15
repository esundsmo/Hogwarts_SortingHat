function Sorting2()
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
% Student_List = [1.0000 7.6367 5.5882 1.8384 4.9795 71.0000;...
%     2.0000    5.1785    9.9424    8.5485    9.6240   83.0000;...
%     3.0000    6.7894    4.0350    9.3498    4.7948   82.0000;...
%     4.0000    2.3179    3.9629    7.0508    5.5856   82.0000;...
%     5.0000    7.5663    9.9548    9.6243    5.3507   83.0000;...
%     6.0000    9.6387    1.1563    0.5145    3.0435   71.0000;...
%     7.0000    5.8019    5.3096    9.0121    5.4055   82.0000;...
%     8.0000    4.3198    5.4267    7.1241    0.1667   82.0000;...
%     9.0000    8.0092    1.4251    4.7847    2.5684   71.0000;...
%    10.0000    3.6909    6.6176    1.6961    2.7878   83.0000;...
%    11.0000    1.9822    1.9507    3.2684    8.8034   72.0000;...
%    12.0000    4.7110    4.0397    1.7923    9.6892   72.0000;...
%    13.0000    4.0746    8.4449    6.1533    3.7661   83.0000;...
%    14.0000    8.7718    7.8485    4.6495    8.1398   71.0000;...
%    15.0000    8.9844    4.2924    3.3433    5.9665   71.0000;...
%    16.0000    9.0199    7.0207    3.7746    7.3496   71.0000;...
%    17.0000    9.5410    5.4281    5.4011    3.1111   71.0000;...
%    18.0000    0.7123    1.8198    0.9299    4.6349   72.0000;...
%    19.0000    0.0933    9.1503    6.4274    0.0142   83.0000;...
%    20.0000    0.3039    2.0847    4.5497    1.2727   82.0000]; %For Testing


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
        if rg >= limit
            rejects(reject_pos,:) = GR(limit,:);
            rejects(reject_pos,2) = 0; % To eliminate the highest value
            GR(limit,:) = [];
            reject_pos = reject_pos +1;
        elseif rs >= limit
            rejects(reject_pos,:) = SL(limit,:);
            rejects(reject_pos,3) = 0; % To eliminate the highest value
            SL(limit,:) = [];
            reject_pos = reject_pos +1;
        elseif rr >= limit
            rejects(reject_pos,:) = RA(limit,:);
            rejects(reject_pos,4) = 0; % To eliminate the highest value
            RA(limit,:) = [];
            reject_pos = reject_pos +1;
        elseif rh >= limit
            rejects(reject_pos,:) = HU(limit,:);
            rejects(reject_pos,5) = 0; % To eliminate the highest value
            HU(limit,:) = [];
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
    [Gr,Gc] = size(GR); Gr = Gr+1;
    [Sr,Sc] = size(SL); Sr = Sr+1;
    [Rr,Rc] = size(RA); Rr = Rr+1;
    [Hr,Hc] = size(HU); Hr = Hr+1;
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
            Hr =  + 1;
        end
    end
end


% House Matrices
% GR
% SL
% RA
% HU



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
        [GR,SL,RA,HU,rejects] = remove(GR,SL,RA,HU);
        [GR,SL,RA,HU] = REsort(GR,SL,RA,HU,rejects);
        %%% Ok, fun fact about this break statement. Without it,  matlab
        %%% says that the varible pos is not defined in the REsort
        %%% function, which is total and utter bullshit, because REsort
        %%% works just fine on its own, thank you very much.
        %%%
        %%% Nevermind, we printed everything, and the issue is actually
        %%% that after all the houses have equal numbers of students,
        %%% MATLAB tried to run the REsort code again, and fails because
        %%% it's taking in a rejection matrix of size zero.
        %%%
        %%% Also, this whole thing works fine with the test matrix. It
        %%% throws a hissy fit when I try to use a random one. NVM
        
%         break % This will be removéd
    end
end













end