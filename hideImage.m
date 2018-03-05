function [I, len, h, w, d] = hideImage(I, hidePath)
    [message, h, w, d] = decompose(hidePath);
    I = hide(I, message);
    len = length(message);