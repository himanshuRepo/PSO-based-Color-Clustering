function z=clusteringCost(x,data)

dim=size(data,2);
k=size(x,2)/dim;
clusterCenter=reshape(x,[],k)';

d = pdist2(data, clusterCenter);
[dmin, ind] = min(d, [], 2);
z = sum(dmin);

end
