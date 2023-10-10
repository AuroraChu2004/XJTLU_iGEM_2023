function loc=cell_search(i,j,M,N)
%输入矩阵规模与元素索引，搜索其邻居
loc=[];
for temp_i= i-1:i+1
    for temp_j = j-1:j+1
        if temp_i>0 && temp_i<=M 
            if temp_j>0 && temp_j<=N
                if ~(temp_i==i && temp_j==j)
                    loc=[loc;[temp_i,temp_j]];
                end
            end
        end
    end
end