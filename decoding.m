function result = decoding(str, map, h, w)
   len = length(str);
   result = zeros(len, 1);
   key = map{1, 2};
   value = map{1, 1};
   temp = length(value);
   left = (1:len);
   mark = zeros(len, 1);
   for i = 1:temp
       count = 1;
       for j = 1:length(left)
           if(isequal(key{temp - i + 1},str{left(j)}))
               result(left(j)) = value(temp - i + 1);
               mark(count) = j;
               count =count+1;
           end
       end
       %clear
       left(mark(1:count-1)) = [];
   end
   result = reshape(result, h, w);
end