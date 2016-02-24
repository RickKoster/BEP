fid = fopen(filename);
C = textscan(fid,'%s%f','headerlines',8);
fclose(fid);