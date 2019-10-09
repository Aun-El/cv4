
function [best_transform,xa,ya,y]=RANSAC(matches,fa,fb)

best_inliers_count=0;
%%RANSAC ATTEMPt
sample_size = 20;
N=100;
for n=1:N
    y = randperm(size(matches,2),sample_size);
    xa = fa(1,matches(1,y)) ;
    xb = fb(1,matches(2,y)) ;
    ya = fa(2,matches(1,y)) ;
    yb = fb(2,matches(2,y)) ;
    total_xy=[];
    total_xy_b=[];
    for j=1:sample_size
        A =[xa(j) ya(j) 0 0 1 0;0 0 xa(j) ya(j)  0 1 ];
        b =[xb(j);yb(j)];
        total_xy = [total_xy;A];
        total_xy_b = [total_xy_b;b];
    end
    
    M=pinv(total_xy)*total_xy_b;
    
    Big_M=[M(1:2) M(3:4)]';
    t=M(5:6);
    
    transform_a=Big_M*[xa;ya]+t;
    tx = transform_a(1,:) ;
    ty = transform_a(2,:) ;
    diff_x=abs(tx-xb);
    diff_y=abs(ty-yb);
    diff_sq=(diff_x.^2+diff_y.^2).^(0.5);
    number_of_inliers=sum(diff_sq <= 10);
    if number_of_inliers > best_inliers_count
        best_inliers_count = number_of_inliers;
        best_transform_M=Big_M;
        best_transform_t=t;
    end
    disp(number_of_inliers);
end

best_transform = [best_transform_M(1);best_transform_M(2);best_transform_M(3);best_transform_M(4);best_transform_t(1);best_transform_t(2)];

end

