function graph_matchin_keypoints(Ia_new,Ib_new,matches,fa,fb,Ia)
    figure(2) ; clf ;
    imshow(cat(2, Ia_new, Ib_new)) ;
    y = randsample(size(matches,2),10);
    xa = fa(1,matches(1,y)) ;
    xb = fb(1,matches(2,y)) ;
    xb_new=xb+ size(Ia,2) ;
    ya = fa(2,matches(1,y)) ;
    yb = fb(2,matches(2,y)) ;

    hold on ;
    h = line([xa ; xb_new], [ya ; yb]) ;
    set(h,'linewidth', 3) ;
    fb_new=fb ;
%     vl_plotframe(fa(:,matches(1,y))) ;
    fb_new(1,y) = fb_new(1,y) + size(Ia,2) ;
%     vl_plotframe(fb_new(:,matches(2,y))) ;
    axis image off ;

end