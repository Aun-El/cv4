function [rotated_image]=rotate(img,best_transform)
best_transform_M = [best_transform(1), best_transform(2);best_transform(3),best_transform(4)];
rotation = best_transform_M';

if size(img,3) > 1
    [height,width,~]=size(img);
    I_new=zeros(height*4 ,width*4,3, 'uint8');

    %-height and -width as rotation can be negative
    for h =-2*height:2*height
        for w =-2*width:2*width

            orig_hw=round(rotation*[h;w]);
            if orig_hw(1)>0 && orig_hw(1)<= height
                if orig_hw(2)>0 && orig_hw(2)<= width
                    I_new(h+height, w+width,:) = img(orig_hw(1), orig_hw(2),:);
                end
            end

        end

    end
    pad_detector = sum(I_new,3);
    I_new( ~any(pad_detector,2), :, :) = []; 
    I_new( :, ~any(pad_detector,1), :) = [];      
    %imshow(I_new);
    rotated_image=I_new;
    
else
    [height,width]=size(img);
    I_new=zeros(height*4 ,width*4, 'uint8');

    %-height and -width as rotation can be negative
    for h =-2*height:2*height
        for w =-2*width:2*width

            orig_hw=round(rotation*[h;w]);
            if orig_hw(1)>0 && orig_hw(1)<= height
                if orig_hw(2)>0 && orig_hw(2)<= width
                    I_new(h+height, w+width) = img(orig_hw(1), orig_hw(2));
                end
            end

        end

    end

    I_new( ~any(I_new,2), : ) = []; 
    I_new( :, ~any(I_new,1) ) = [];      
    rotated_image=I_new;
end

end
        
