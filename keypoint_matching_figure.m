
function [best_transform_M, best_transform_t]=RANSAC(matches,fa,fb)  ;

best_inliers_count=0;
%%RANSAC ATTEMPt

N=100
for n=1:N
    y = randsample(size(matches,2),10);
    random_matches=matches(:,y);
    xa = fa(1,matches(1,y)) ;
    xb = fb(1,matches(2,y)) ;
    ya = fa(2,matches(1,y)) ;
    yb = fb(2,matches(2,y)) ;
    Big_M=[]
    t=[]
    total_xy=[]
    total_xy_b=[]
    for j=1:10
    
        xy_a=[xa(j) ;ya(j)];
        new_xy=[xa(j) ya(j) 0 0 1 0;0 0 xa(j) ya(j)  0 1 ]
        xy_b=[xb(j);yb(j)];
        total_xy=[total_xy;new_xy]
        total_xy_b=[total_xy_b;xy_b]
    end
    M=pinv(total_xy)*total_xy_b;
    M=M(:,1)

    Big_M=[M(1:2,1) M(3:4,1)]'
    t=M(5:end,1)
    [M(1:2,1) M(3:4,1)]*[xa(j); ya(j)] + M(5:end,1)
    xa_total = fa(1,matches(1,y)) ;
    xb_total = fb(1,matches(2,y)) ;
    ya_total = fa(2,matches(1,y)) ;
    yb_total = fb(2,matches(2,y)) ;
    
    transform_a=Big_M*[xa_total;ya_total]+t;
    tx = transform_a(1,:) ;
    ty = transform_a(2,:) ;
    diff_x=abs(tx-xb);
    diff_y=abs(ty-yb);
    diff_sq=(diff_x.^2+diff_y.^2).^(0.5);
    number_of_inliers=sum(diff_sq<=10);
    if number_of_inliers>best_inliers_count;
        best_transform_M=Big_M;
        best_transform_t=t;
    end
    disp(number_of_inliers);
    
end

