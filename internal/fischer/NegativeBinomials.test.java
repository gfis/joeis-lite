  /**
   * Binomial coefficients: variant which agrees with Maple and Mathematica for k &lt;= n.
   * Cf. M.J. Kronenburg: "The Binomial Coefficient for Negative Arguments", Mar 30 2015
   * {@link https://arxiv.org/pdf/1105.3689.pdf} and
   * {@link https://mathworld.wolfram.com/BinomialCoefficient.html}
   * @param n upper index
   * @param k lower index
   * @return coefficient
   */
  public static Z binomial(final long n, final long k) {
    Z result = Binomial.binomial(n, k);
    if (k < 0 && n < 0) {
      result = Binomial.binomial(- k - 1, n - k);
      if (-k % 2 != -n % 2) {
        result = result.negate();
      }
    }
    return result;
  }
  

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