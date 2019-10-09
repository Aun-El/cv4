function [matches, scores,Ia_old,Ib_old,fa,fb,Ia,Ib]=keypoint_matching(img_a,img_b)

Ia = imread(img_a) ;
Ib = imread(img_b) ;
Ia_old=Ia;
Ib_old=Ib;

    if size(Ia,3) > 1
        Ia = rgb2gray(Ia);
    end
    if size(Ib,3) > 1
        Ib = rgb2gray(Ib);
    end   

Ia = single(Ia) ;
Ib = single(Ib) ;
[fa, da] = vl_sift(single(Ia)) ;
[fb, db] = vl_sift(single(Ib)) ;
[matches, scores] = vl_ubcmatch(da, db) ;

end