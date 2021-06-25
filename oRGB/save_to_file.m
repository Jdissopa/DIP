
function save_to_file(image, dest_path, file_name, format)
    %% save to file
    im = split(file_name,".");
    im = strcat(dest_path,"\",im(1), ".", format);
    imwrite(image,im);