c = 2.99792458e8;   % speed of light (m/s)
function p = calcdistance( A, B, b)
   C=A-B;
   C=C^2;
   p = sqrt(sum(C)) + c * b;
end