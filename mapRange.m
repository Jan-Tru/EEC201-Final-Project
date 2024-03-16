function y = mapRange(x, min1, max1, min2, max2)
    % Map values from range [min1, max1] to range [min2, max2]
    y = (x - min1) * (max2 - min2) / (max1 - min1) + min2;
end