function [IM] = ImageSeries_open16bit(data_dir)

Im=datastore(data_dir, 'FileExtensions', '.tif','Type', 'image');
list = dir([data_dir '\' '*.tif']); % get image file names and assign to variable 'list'
First_image=logical(readimage(Im,1));
sz=size(First_image);
x=sz(2);
y=sz(1);
z=length(list);
Image_size=[y,x,z]; %pixel value

IM = uint16(zeros(y, x, z));  
 
poolobj = gcp('nocreate');
delete(poolobj);
no_of_workers = 12;
parpool ('local',no_of_workers);  
 
parfor d=1:length(list)
 
     T_image=uint16(readimage(Im,d));
     IM(:,:,d)= T_image;
 
end
 
poolobj = gcp('nocreate');
delete(poolobj);