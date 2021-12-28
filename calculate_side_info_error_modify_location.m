function [side_info_error_modify_location,side_info_error_modify_location_length,modify_method_xy_or_map,length_xy,length_map] = calculate_side_info_error_modify_location(error_modify_location_map)
%CALCULATE_SIDE_INFO_ERROR_MODIFY_LOCATION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[m,n] = size(error_modify_location_map);
%���ú��������¼Ԥ������޸�λ��
length_xy = sum(sum(error_modify_location_map==1))*18;
side_info_error_modify_location_xy = uint8(zeros(1,length_xy));
side_info_error_modify_location_xy = reshape(side_info_error_modify_location_xy.',18,length_xy/18).';
count = 0;
for i = 1:m
    for j = 1:n
        if error_modify_location_map(i,j) == 1
            x = bitget(i-1,9:-1:1);
            y = bitget(j-1,9:-1:1);
            temp = [x,y];
            count = count+1;
            for k = 1:18
                side_info_error_modify_location_xy(count,k) = temp(k);
            end
        end
    end
end
side_info_error_modify_location_xy = reshape(side_info_error_modify_location_xy.',length_xy,1).';
%�����޸�λ�ö�ֵͼ����������ѹ�������¼Ԥ������޸�λ��
LocationMap=double(reshape(error_modify_location_map,m*n,1));
xC = cell(1,1);
xC{1,1} = LocationMap;
y = Arith07(xC);
[a,~] = size(y);
length_map = a*8;
side_info_error_modify_location_map = uint8(zeros(1,length_map));
side_info_error_modify_location_map = reshape(side_info_error_modify_location_map.',8,length_map/8).';
for i=1:a
    temp = uint8(bitget(y(i,1),8:-1:1));
    for j=1:8
        side_info_error_modify_location_map(i,j) = temp(j);
    end
end
side_info_error_modify_location_map = reshape(side_info_error_modify_location_map.',length_map,1).';
%�Ƚ�2�ַ������ø���Ϣ�ĳ��ȣ�ѡ��̵���һ�֣����һ������ѡ�����귨����Ϊ��ʱ����
if length_map < length_xy
    modify_method_xy_or_map = 1;
    side_info_error_modify_location = side_info_error_modify_location_map;
    side_info_error_modify_location_length = uint8(bitget(length_map,10:-1:1));
else
    modify_method_xy_or_map = 0;
    side_info_error_modify_location = side_info_error_modify_location_xy;
    side_info_error_modify_location_length = uint8(bitget(length_xy,10:-1:1));
end

end

