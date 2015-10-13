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

    % Creates an identification number for each student
end

% Matches a student's aptitude scores with their student number
% Student_List = [transpose(N),S]
Student_List = S;

for m = 1:1:n
    [smax(m),pos(m)] = max(Student_List(m,2:5));
end

for h = 1:n
    if pos(h) == 1
        GR(g_c,:) = Student_List(h,:);
        Student_List(h,6) = 'G';
        g_c = g_c + 1;
    elseif pos(h) == 2
        SL(s_c,:) = Student_List(h,:);
        s_c = s_c + 1;
        Student_List(h,6) = 'S';
    elseif pos(h) == 3
        RA(r_c,:) = Student_List(h,:);
        Student_List(h,6) = 'R';
        r_c = r_c + 1;
    elseif pos(h) == 4
        HU(h_c,:) = Student_List(h,:);
        Student_List(h,6) = 'H';
        h_c = h_c + 1;
    end
end

% House Matrices
% GR
% SL
% RA
% HU
[rg,cg] = size(GR);
[rs,cs] = size(SL);
[rr,cr] = size(RA);
[rh,ch] = size(HU);

% House Happiness
Student_List
GR_happy = sum(GR(:,2))/rg
SL_happy = sum(SL(:,3))/rs
RA_happy = sum(RA(:,4))/rr
HU_happy = sum(HU(:,5))/rh
        
        
        
        
        
        
        
        
        