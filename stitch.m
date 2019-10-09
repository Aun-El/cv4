function [stitched_img] = stitch(img1, img2)

[matches, scores,Ia_old,Ib_old,fa,fb,Ia,Ib]=keypoint_matching(img2, img1);

%graph_matchin_keypoints(Ia_new,Ib_new,matches,fa,fb,Ia)
[best_transform]=RANSAC(matches,fa,fb);
%best_transform = [best_transform_M(1);best_transform_M(2);best_transform_M(3);best_transform_M(4);best_transform_t(1);best_transform_t(2)];
[rotated_image]=rotate(Ia_old,best_transform);

size1 = size(Ib);
size2 = size(rotated_image);
stitched_img = zeros(size1(1) + size2(1), size1(2) + size2(2),3);

for x = 1:size1(1)
    for y = 1:size1(2)
        stitched_img(x,y,:) = Ib_old(x,y,:);
    end
end

offset = round([best_transform(5),best_transform(6)]);

for x = 1:size2(1)
    for y = 1:size2(2)
        if(rotated_image(x,y) > 0)
            stitched_img(x+offset(2)-22,y+offset(1),:) = rotated_image(x,y,:);
        end
    end
end

pad_detector = sum(stitched_img,3);
stitched_img( ~any(pad_detector,2), :, :) = []; 
stitched_img( :, ~any(pad_detector,1), :) = [];
stitched_img = uint8(stitched_img);
end