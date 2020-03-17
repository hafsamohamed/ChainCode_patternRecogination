load images.mat imageArray;
%-----------------------------FUNCTIONS-----------------------------------------
function [x y] = CenterOfMath(img)
  [r c]=size(img);
  SumOfFX = sum(sum(img));
  SumOfX = sum(sum([1:r]*img));
  SumOfY = sum(sum(img*[1:c]'));
  x = SumOfX / SumOfFX;
  y = SumOfY / SumOfFX;
end
%-----------------------------------------------

function [bound position] = division(im ,S,T)
  [xc yc] = CenterOfMath(im);
  boundary = bwboundaries(im);
  bound = cell2mat(boundary);
  AllRadius = sqrt((bound(:,1)-xc).^2 + (bound(:,2)-yc).^2 );
  Radius = floor(max(AllRadius)+1);
  position(:,1) = (floor((AllRadius/Radius)*T));
  angle = atan2d((xc-bound(:,1)),(yc-bound(:,2)));  
  for i=1:length(angle)
    if angle(i)<0
      angle(i) = angle(i,1) + 360;
    end
  end
  position(:,2) = floor((angle/360)*S);
end
%-----------------------------------------------

function f = FeatureVector(im,s,t)
  FeatVec = ([1:s*t*8]'*0);
  [b p] = division(im,s,t);
  for i=1:(length(b)-1)
     d = 0;
     tan = atan2d(b(i+1,1) - b(i,1),b(i+1,2) - b(i,2));
     if tan < 0
       tan = tan+360;
     end
     dir = round(tan/45);
     if dir==8
       dir = 0;
     end
     d = p(i,2)*8*s + p(i,1)*8 + dir + 1;
     FeatVec(d) = FeatVec(d) + 1;
  end
  
  %----------------------normalization
  x=1;
  for i=1:(length(FeatVec)/8)
    summ = sum(FeatVec(x:x+7));
    if summ != 0
      FeatVec(x:x+7) = FeatVec(x:x+7)/summ;
    end
    x = x+8;
  end
  
  %-----------------------------------
  f=FeatVec;
  %hold on;
  %plot(b(:,2),b(:,1),'g','LineWidth',3);
end
%----------------------------------------------
function vecs = FeatureVectors(imgs,s,t)
  FeatVecs = cell(1,100);
  for j=1:length(imgs)
    FeatVecs{j} = FeatureVector(imgs{j},s,t);
  end
  vecs = FeatVecs;
end
%----------------------------------------------
function dis = distance(vecs,testvec)
  dist = ([1:length(vecs)]'*0);
  dists = ([1:length(vecs)\10]'*0);
  for j=1:length(vecs)
    dist(j) = sum(abs(testvec-vecs{j}));
  end
 %{
 x=1;
  for i=1:(length(dist)/10)
    dist(x:x+9)
    summ = sum(dist(x:x+9));
    dists(i) = summ;
    x = x+10;
  end
  dist
  dists
  min(dist)
  %}
  dis = find(dist == min(dist));
end
%----------------------------------------------  
function t = test(vecs, im, s, t)
  testVec = FeatureVector(im, s, t);
  x = distance(vecs,testVec);
  t = floor((x-1)/10); 
end

%------------------------------------MAIN---------------------------------------

im1 = imread('C:\Users\ahmedelsayed\Desktop\year3\term2\ASS2_PR\MyPic\9_10.bmp');
im = imageArray{98};
figure;
imshow(im);
%f = FeatureVectors(imageArray,1,1);
%Number_Is = test(f,im,1,1)
f = FeatureVector(im1,4,4)
#{
[x1 x2] = CenterOfMath(im)
boundary = bwboundaries(im);
imshow(im);
hold on;
plot(b(:,2),b(:,1),'g','LineWidth',3);
#}
%--------------------------------------END--------------------------------------