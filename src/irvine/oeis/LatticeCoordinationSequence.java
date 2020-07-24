package irvine.oeis;
// 2020-07-24, Georg Fischer: added type "D^+"

import irvine.math.z.Binomial;
import irvine.math.z.Z;

/**
 * Coordination sequence for a lattice of some type (A, B, C and so on) and dimension <code>d</code>,
 * which is realized by a recurrence. The signature are the
 * coefficients of <code>(1-x)^d</code>, and the initial terms are computed by a sum
 * of expressions of <code>binomial(d,k)</code>, depending on the type.
 * @author Georg Fischer
 */
public class LatticeCoordinationSequence extends GeneratingFunctionSequence {

  /**
   * Construct the sequence by reducing it to a ordinary generating function.
   * The constructor computation is close to the sequence definition
   * and not optimized for speed.
   * @param latticeType A, B, C, D* and so on.
   * @param d dimension of the lattice
   */
  public LatticeCoordinationSequence(final String latticeType, final int d) {
    super();
    configure(latticeType, d);
  }

  /**
   * Compute the numerator and denominator coefficient lists.
   * @param latticeType A, B, C, Ds and so on.
   * @param d dimension
   */
  protected void configure(final String latticeType, final int d) {
    char typeCode = latticeType.charAt(0);
    if (latticeType.equals("D^+")) { // special treatment for diamond structures
      // This can be tested with the following Mathematica:
      // a[d_,n_]:=2^(d-1)*Binomial[(d+2*n)/2-1,d-1]+(1-Mod[n,2])*Sum[2^k*Binomial[d,k]*Binomial[n-1,k-1],{k,0,d}];
      // a[0,_]=1; Table[a[4,n],{n,0,24}];
      // gfden[d_,k_]:=CoefficientList[(1-x^2)^d,x][[k+1]];
      // d:=4; Table[gfden[d,k],{k,0,2*d}];
      // gfnum[d_,k_]:=Sum[gfden[d,j]*a[d,k-j],{j,0,k}];
      // d=8; Table[gfnum[d,k],{k,0,2*d}]
      mDen = new Z[2 * d + 1];
      mNum = new Z[2 * d + 1];
      Z[] initTerms = new Z[2 * d + 1];
      for (int k = 0; k <= 2 * d; ++k) { // denominator
        switch (k % 4) {
          case 0:
            mDen[k] = binomial(d, k / 2);
            break;
          case 2:
            mDen[k] = binomial(d, k / 2).negate();
            break;
          case 1:
          case 3:
            mDen[k] = Z.ZERO;
            break;
        } // switch
      } // for denominator
      
      for (int n = 0; n <= 2 * d; ++n) { // initial terms
        Z coeff = Z.TWO.pow(d - 1).multiply(binomial((d + 2L * n) / 2L - 1L, d - 1L));
        if ((n & 1) == 0) { // even
          for (int k = 0; k <= d; ++k) {
            coeff = coeff.add(Z.TWO.pow(k).multiply(binomial(d, k)).multiply(binomial(n - 1L, k - 1L)));
          } // for k
        }
        initTerms[n] = coeff;
      } // for initial terms
      initTerms[0] = Z.ONE;
      
      for (int k = 0; k <= 2 * d; ++k) { // numerator
        Z sum = Z.ZERO;
        for (int j = 0; j <= k; ++j) {
           sum = sum.add(mDen[j].multiply(initTerms[k - j]));
        } // for j
        mNum[k] = sum;
      } // for numerator
  //  if (false) {
  //    System.out.println();
  //    System.out.print("denominator");
  //    for (int k = 0; k < mDen.length; ++k) {
  //      System.out.print("," + mDen[k]);
  //    }
  //    System.out.println();
  //    System.out.print("initial terms");
  //    for (int k = 0; k < initTerms.length; ++k) {
  //      System.out.print("," + initTerms[k]);
  //    }
  //    System.out.println();
  //    System.out.print("numerator");
  //    for (int k = 0; k < mNum.length; ++k) {
  //      System.out.print("," + mNum[k]);
  //    }
  //  }

    } else { // normal lattice
      if (latticeType.length() > 1) { // Dual: "A*" or "Ds" ...
        typeCode = Character.toLowerCase(typeCode);
      }
      mDen = new Z[d + 1];
      mNum = new Z[d + 1];
      for (int k = 0; k <= d; ++k) { // denominator
        switch (k % 2) {
          case 0:
            mDen[k] = binomial(d, k);
            break;
          case 1:
            mDen[k] = binomial(d, k).negate();
            break;
        } // switch
      } // for denominator
      for (int k = 0; k <= d; ++k) { // numerator
        Z coeff = null;
        switch (typeCode) {
          case 'A':
            //  A, A103881
            //  d:= 4; CoefficientList[Series[Sum[(Binomial[d,k])^2*x^k, {k, 0, d}]/(1 - x)^d, {x,0,11}],x]
            //  {1, 20, 110, 340, 780, 1500, 2570, 4060, 6040, 8580, 11750, 15620}
            coeff = binomial(d, k).pow(2);
            break;
          case 'a':
            //  A*, A008535 (A204621 = coordinator triangle)
            //  d:=7; CoefficientList[Series[((Sum[Sum[Binomial[d+1, j] , {j, 0, Min[k, d-k]}]*x^k, {k, 0, d}])/(1-x)^d),{x,0,10}],x]
            //  {1, 16, 128, 688, 2746, 8752, 23536, 55568, 118498, 232976, 428752}
            Z sumj = Z.ZERO;
            final int mink = Math.min(k, d - k);
            for (int j = 0; j <= mink; ++j) {
              sumj = sumj.add(binomial(d + 1, j));
            } // for j
            coeff = sumj;
            break;
          case 'B':
            //  B, A103883
            //  d:= 4; CoefficientList[Series[(Sum[(Binomial[2n + 1, 2k] - 2*k*Binomial[d, k])*x^k, {k, 0, d}])/(1 - x)^d, {x,0,11}],x]
            //  {1, 32, 224, 768, 1856, 3680, 6432, 10304, 15488, 22176, 30560, 40832}
            coeff = binomial(2L * d + 1, 2L * k).subtract(Z.valueOf(2L * k).multiply(binomial(d, k)));
            break;
          case 'C':
            //  C, A103884
            //  d:= 4; CoefficientList[Series[(Sum[Binomial[2n,2k]*x^k, {k, 0, d}])/(1-x)^d, {x,0,11}],x]
            //  {1, 32, 192, 608, 1408, 2720, 4672, 7392, 11008, 15648, 21440, 28512}
            coeff = binomial(2L * d, 2L * k);
            break;
          case 'D':
            //  D, A103903
            //  d:= 4; CoefficientList[Series[(Sum[(Binomial[2n,2k]-2*d*Binomial[d-2,k-1])*x^k, {k, 0, d}])/(1-x)^d, {x,0,11}],x]
            //  {1, 24, 144, 456, 1056, 2040, 3504, 5544, 8256, 11736, 16080, 21384}
            coeff = binomial(2L * d, 2L * k).subtract(Z.valueOf(2L * d).multiply(binomial(d - 2, k - 1)));
            break;
          case 'd':
            //  D*, A035706
            //  d:= 12; CoefficientList[Series[(Sum[Binomial[d,k]*x^k, {k, 0, d}] + 2^d*x^(d/2))/(1 - x)^d, {x,0,11}],x]
            //  {1, 24, 288, 2312, 14016, 68664, 288096, 1071912, 3600768, 11036504, 31125408, 81412680}
            coeff = binomial(d, k);
            if (k == d / 2) {
              coeff = coeff.add(Z.TWO.pow(d));
            }
            break;
          case 'Q':
            //  Q, A035706
            //  d:= 11; CoefficientList[Series[Sum[Binomial[d,k]*x^k, {k, 0, d}]/(1 - x)^d, {x,0,11}],x]
            //  {1, 22, 242, 1782, 9922, 44726, 170610, 568150, 1690370, 4573910, 11414898, 26572086}
            coeff = binomial(d, k);
            break;
          default:
            throw new RuntimeException("Unexpected typeCode " + typeCode);
        } // switch typeCode
        mNum[k] = coeff;
      } // for numerator
   } // not D^+
  }

  /**
   * Binomial coefficients: variant which agrees with Maple and Mathematica for k &lt;= n.
   * Cf. M.J. Kronenburg: "<a href="https://arxiv.org/pdf/1105.3689.pdf">The Binomial Coefficient for Negative Arguments</a>", Mar 30 2015
   * and Wolfram, <a href="https://mathworld.wolfram.com/BinomialCoefficient.html">Binomial Coefficient</a>
   * @param n upper index
   * @param k lower index
   * @return coefficient
   */
  public static Z binomial(final long n, final long k) {
    Z result = Binomial.binomial(n, k);
    if (k < 0 && n < 0) {
      result = Binomial.binomial(-k - 1, n - k);
      if (-k % 2 != -n % 2) {
        result = result.negate();
      }
    }
    return result;
  }
}
