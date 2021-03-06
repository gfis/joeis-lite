
__DATA__
Maple:
> seq(seq(binomial(n,k), k=-4..4),n=-4..4);                                >
    1,  0,  0,  0,  1, -4, 10,-20, 35
  ,-3,  1,  0,  0,  1, -3,  6,-10, 15
  , 3, -2,  1,  0,  1, -2,  3, -4,  5
  ,-1,  1, -1,  1,  1, -1,  1, -1,  1
  , 0,  0,  0,  0,  1,  0,  0,  0,  0
  , 0,  0,  0,  0,  1,  1,  0,  0,  0
  , 0,  0,  0,  0,  1,  2,  1,  0,  0
  , 0,  0,  0,  0,  1,  3,  3,  1,  0
  , 0,  0,  0,  0,  1,  4,  6,  4,  1

Mathematica
In[1]:= m:= 4; Table[Table[Binomial[n,k], {k,-m,+m}],{n,-m,+m}]
Out[1]= 
{ { 1,  0,  0,  0,  1, -4, 10,-20, 35}
, {-3,  1,  0,  0,  1, -3,  6,-10, 15}
, { 3, -2,  1,  0,  1, -2,  3, -4,  5}
, {-1,  1, -1,  1,  1, -1,  1, -1,  1}
, { 0,  0,  0,  0,  1,  0,  0,  0,  0}
, { 0,  0,  0,  0,  1,  1,  0,  0,  0}
, { 0,  0,  0,  0,  1,  2,  1,  0,  0}
, { 0,  0,  0,  0,  1,  3,  3,  1,  0}
, { 0,  0,  0,  0,  1,  4,  6,  4,  1}

(09:34) gp > m=4; for(n=-m,+m,for(k=-m,+m,print1(", ",binomial(n,k))))
  , 0,  0,  0,  0,  1, -4, 10,-20, 35
  , 0,  0,  0,  0,  1, -3,  6,-10, 15
  , 0,  0,  0,  0,  1, -2,  3, -4,  5
  , 0,  0,  0,  0,  1, -1,  1, -1,  1
  , 0,  0,  0,  0,  1,  0,  0,  0,  0
  , 0,  0,  0,  0,  1,  1,  0,  0,  0
  , 0,  0,  0,  0,  1,  2,  1,  0,  0
  , 0,  0,  0,  0,  1,  3,  3,  1,  0
  , 0,  0,  0,  0,  1,  4,  6,  4,  1
                        
jOEIS Binomial.binomial(n,k)
    1,  1,  1,  1,  1, -4, 10,-20, 35
    1,  1,  1,  1,  1, -3,  6,-10, 15
    1,  1,  1,  1,  1, -2,  3, -4,  5
    1,  1,  1,  1,  1, -1,  1, -1,  1
    0,  0,  0,  0,  1,  0,  0,  0,  0
    0,  0,  0,  0,  1,  1,  0,  0,  0
    0,  0,  0,  0,  1,  2,  1,  0,  0
    0,  0,  0,  0,  1,  3,  3,  1,  0
    0,  0,  0,  0,  1,  4,  6,  4,  1