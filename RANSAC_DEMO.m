run('VLROOT/toolbox/vl_setup');
clear all;
clf;
[matches, scores,Ia_new,Ib_new,fa,fb,Ia]=keypoint_matching('boat2.pgm','boat1.pgm')  ;
graph_matchin_keypoints(Ia_new,Ib_new,matches,fa,fb,Ia)
[best_transform,xa,ya,y]=RANSAC(matches,fa,fb);
best_transform_M = [best_transform(1),best_transform(2);best_transform(3),best_transform(4)];
best_transform_t = [best_transform(5);best_transform(6)];
transform_a=best_transform_M*[xa;ya]+best_transform_t;
tx = transform_a(1,:) ;
ty = transform_a(2,:) ;
figure(3) ; clf ;
imshow(cat(2, Ia_new, Ib_new)) ;
tx_new =tx + size(Ia,2) ;
hold on ;
%plot transformed features from image a to point on image b
for k = 1:size(xa,2)
    h(k) = line([xa(k)  tx_new(k)], [ya(k)  ty(k)]) ;
    set(h(k),'linewidth', 3,'color',rand(1,3)) ;
end


axis image off ;
clf;
[rotated_image]=rotate(Ia_new,best_transform);
imshow(rotated_image)
[output]=matlab_imwarp(Ia_new,best_transform_M);
imshow(output)




