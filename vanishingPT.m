function [ vec ] = vanishingPT(lines)
% Compute the vanishing point from more than two lines
n = size(lines,1);
M = zeros(3,3);
for i=1:n
    line = cross(lines(n,1:3),lines(n,4:6));
    M(1,1) = M(1,1)+line(1)*line(1);
    M(1,2) = M(1,2)+line(1)*line(2);
    M(1,3) = M(1,3)+line(1)*line(3);
    M(2,2) = M(2,2)+line(2)*line(2);
    M(2,3) = M(2,3)+line(2)*line(3);
    M(3,3) = M(3,3)+line(3)*line(3);
end
M(2,1) = M(1,2);
M(3,1) = M(1,3);
M(3,2) = M(2,3);

M
[V,D] = eigs(M,1,'SM')
vec = V(:,1);
val = D(1,1);

for i = 2:size(D,1)
    if((D(i,i)<val))
        val = D(i,i);
        vec = V(:,i);
    end
end

end

