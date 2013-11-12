function hw2(mat)
img = ones(600,600,3);
image(img);

hc = [-1 0 300; 0 1 300; 0 0 1]
mat = [mat, ones(length(mat),1)]
hc_mat_trans = hc * mat';
hc_mat = hc_mat_trans'

x_axis_x = zeros(1,599);
y_axis_x = [-299:299];
x_axis_y = [-299:299];
y_axis_y = zeros(1,599);
axis_h = ones(1,599);

pre_x_axis = [x_axis_x;x_axis_y;axis_h];
pre_y_axis = [y_axis_x;y_axis_y;axis_h];

x_axis = (hc * pre_x_axis)'
y_axis = (hc * pre_y_axis)';

r = 0;
g = 0;
b = 0;

for i=1:599
     j = x_axis(i,1);
     k = x_axis(i,2);
     img(j,k,1) = 0;
     img(j,k,2) = 0;
     img(j,k,3) = 0;
end

for i=1:599
     j = y_axis(i,1);
     k = y_axis(i,2);
     img(j,k,1) = 0;
     img(j,k,2) = 0;
     img(j,k,3) = 0;
end

blk = [block() ones(441,1)];
blk = (hc * blk')';

for i=1:length(blk)
    j = blk(i,1);
    k = blk(i,2);
    img(j,k,1) = 0;
    img(j,k,2) = 0;
    img(j,k,3) = 0;
end

image(img);
pause();

hc_mat = int16(hc_mat);
blk = block();
length(blk)
blk = int16(blk);



r = 0;
g = 0;
b = 1;

img = draw_image(img,hc_mat,blk,r,g,b);

pause();

blk = block();
blk = [blk,ones(length(blk),1)];

trans = [0.6 0 0; 0 1.25 0; 0 0 1];

blk = (trans * blk')';

r = 0;
g = 1;
b = 0;

img = draw_image(img,hc_mat,blk,r,g,b);

image(img)

pause()

r = 0;
g = 1;
b = 1;

blk = block();
blk = [blk,ones(length(blk),1)];
rot = [.5 .5 0; -.5 .5 0; 0 0 1];
trans_rot = trans * rot;
blk = (trans_rot * blk')';

img = draw_image(img,hc_mat,blk,r,g,b);

pause();

blk = block();
blk = [blk,ones(length(blk),1)];
move = [1 0 100; 0 1 200; 0 0 1];
mtr = trans_rot * move;
blk = (mtr*blk')';

r = 1;
g = 1;
b = 0;

img = draw_image(img,hc_mat,blk,r,g,b);


end

function bl = block()
b = [];
for b_l = 1:length(-10:10)
    for b_w = 1:length(-10:10)
        b = [b; [b_l-11, b_w-11]];
    end
end
bl = b;
end

function img = draw_image(img,hc_mat, blk, r,g,b)
for i=1:length(hc_mat)
    for k=1:length(block)
        if  blk(k,1) + hc_mat(i,1) < 0;
            0;
        elseif blk(k,1) + hc_mat(i,1) > 600;
            0;
        elseif blk(k,2) + hc_mat(i,2) < 0;
            0;
        elseif blk(k,2) + hc_mat(i,2)  > 600;
            0;
        else
            img(blk(k,1)+hc_mat(i,1),blk(k,2)+hc_mat(i,2),1) = r;
            img(blk(k,1)+hc_mat(i,1),blk(k,2)+hc_mat(i,2),2) = g;
            img(blk(k,1)+hc_mat(i,1),blk(k,2)+hc_mat(i,2),3) = b;
        end
    end
end

image(img)
end
