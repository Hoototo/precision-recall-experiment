clc;
clear all;

%DBoW2 SURF
%载入groundtruth
load NewCollegeGroundTruth.mat;
DBoW2truematrix=truth(2:2:2146,2:2:2146) + eye(1073); 
%载入通过DBoW2计算得到的matrix
load newcollegesurf_matrix.txt;
DBoW2matrix = newcollegesurf_matrix(2:2:2146,2:2:2146);

thresh2 = 1;
for k2 = 0:1:10000 %改变阈值，画出精确召回曲线。
thresh2 = thresh2 - k2/10000; %随着阈值减小，召回率在增大。

%某一个thresh会得到不同的DBoW2matrix
for i = 1:1:1073
    for j = 1:1:1073
        if DBoW2matrix(i,j) >= thresh2 
            DBoW2matrix(i,j) = 1;
        else
            continue;
        end
    end
end

%计算准确率与召回率
A2=0;
B2=0;
C2=0;

for i = 1:1:1073
    for j = 1:1:1073
        if ( DBoW2matrix(i,j) == 1 && DBoW2truematrix(i,j) == 1 )
            A2 = A2 + 1;
        elseif ( DBoW2matrix(i,j) == 1 && DBoW2truematrix(i,j) ~= 1 )
            B2 = B2 + 1;
        elseif ( DBoW2matrix(i,j) ~= 1 && DBoW2truematrix(i,j) == 1 )
            C2 = C2 + 1;
        else
            continue;
        end
    end
end

P2( k2/1 + 1 )=(A2)/(A2+B2);
if A2+B2==0
    P2( k2/1 + 1 )=1;
end
R2( k2/1 + 1 )=(A2)/(A2+C2);

end

plot(R2,P2,'b','LineWidth',2);
hold on;


%LIFT
%载入通过lift计算得到的matrix
load newcollegelift_matrix.txt;
LIFTDBoW2matrix = newcollegelift_matrix(2:2:2146,2:2:2146);

thresh3 = 1;
for k3 = 0:1:10000 %改变阈值，画出精确召回曲线。
thresh3 = thresh3 - k3/10000; %随着阈值减小，召回率在增大。

%某一个thresh1会得到不同的LIFTDBoW2matrix
for i = 1:1:1073
    for j = 1:1:1073
        if LIFTDBoW2matrix(i,j) >= thresh3
            LIFTDBoW2matrix(i,j) = 1;
        else
            continue;
        end
    end
end

%计算准确率与召回率
A3=0;
B3=0;
C3=0;

for i = 1:1:1073
    for j = 1:1:1073
        if ( LIFTDBoW2matrix(i,j) == 1 && DBoW2truematrix(i,j) == 1 )
            A3 = A3 + 1;
        elseif ( LIFTDBoW2matrix(i,j) == 1 && DBoW2truematrix(i,j) ~= 1 )
            B3 = B3 + 1;
        elseif ( LIFTDBoW2matrix(i,j) ~= 1 && DBoW2truematrix(i,j) == 1 )
            C3 = C3 + 1;
        else
            continue;
        end
    end
end

P3( k3/1 + 1 )=(A3)/(A3+B3);
if A3+B3==0
     P3( k3/1 + 1 )=1;
end
R3( k3/1 + 1 )=(A3)/(A3+C3);

end

plot(R3,P3,'--*r','LineWidth',2);
hold on;

legend('BoW','LIFT')

grid on;
xlabel('Recall');
ylabel('Precision');
