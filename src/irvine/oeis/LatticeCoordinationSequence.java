package irvine.oeis;

import java.util.ArrayList;

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.HolonomicRecurrence;

/**
 * Coordination sequence for a lattice of some type (A, B, C and so on) and order n,
 * which is realized by a recurrence. The signature are the
 * coefficients of (1-x)^n, and the initial terms are computed by a sum 
 * of expressions of binomial(n,k), depending on the type.
 * @author Georg Fischer
 */
public class LatticeCoordinationSequence extends HolonomicRecurrence {

  /**
   * Construct the sequence by reducing it to a holonomic recurrence.
   * The constructor computation is close to the sequence definition 
   * and not optimized for speed.
   * @param offset index of first term
   * @param latticeType A, B, C, D* and so on.
   * @param n order of the lattice
   */
  public LatticeCoordinationSequence(final int offset, final String latticeType, final int n) {
    super();
    mOffset = offset;
    configure(latticeType, n);
    mNDist = 0;
    super.initialize();
    if (true) {
      System.out.println("make runholo MATRIX=\"" + getPolyString() + "\" INIT=\"" + getInitString() + "\""); 
    /*
      int m = 4;
      for (int nn = -m; nn <= m; nn ++) {
        for (int k = -m; k <= m; k ++) {
          System.out.print(String.format(",%3s", binomial(nn, k).toString()));
        } // for k
        System.out.println();
      } // for n
    */
    } 
  }

 /**
   * Compute the coefficient list of polynomials in n and the initial terms
   * for the holonomic recurrence.
   * @param latticeType A, B, C, D* and so on.
   * @param n order
   * @return the array of arrays of coefficients
   */
  protected void configure(final String latticeType, final int n) {
    ArrayList<Z[]> polyList = new ArrayList<Z[]>(n);
    polyList.add(new Z[] { Z.ZERO }); // no constant - all recurrences are homogenous
    Z[] initTerms = null;
    switch (latticeType.charAt(0)) {
      default:
      case 'A':
        for (int k = 0; k <= n; ++k) {
          Z coeff = binomial(n, k);
          if ((k & 1) == 0) { // even
            coeff = coeff.negate();
          }
          polyList.add(new Z[] { coeff });
        }
        initTerms = new Z[n + 2];
        for (int m = 0; m < n + 2; m++) {
          Z sum = Z.ZERO;
          if (latticeType.length() == 1) { // A
            for (int k = 0; k <= n; k++) {
              sum = sum.add(binomial(n + 1, k).multiply(binomial(m - 1, k - 1)).multiply(binomial(n - k + m, m)));
            } // for k
            initTerms[m] = sum;
          } else { // A*, dual
          }
        } // for m
        break;
        
      case 'C': // C_12 lattice, A035749 - MATRIX="[[0],[6,-7,2],[-292,8,-4],[0,-1,2]]"
        polyList.add(new Z[] { Z.SIX, Z.SEVEN.negate(), Z.TWO });
        polyList.add(new Z[] { Z.valueOf(- 2 * (n * n + 2)) , Z.EIGHT, Z.FOUR.negate() });
        polyList.add(new Z[] { Z.ZERO, Z.NEG_ONE, Z.TWO });
        initTerms = new Z[] { Z.ONE };
        break;
        
      case 'D':
        for (int k = 0; k <= n; ++k) {
          Z coeff = binomial(n, k);
          if ((k & 1) == 0) { // odd
            coeff = coeff.negate();
          }
          polyList.add(new Z[] { coeff });
        }
        initTerms = new Z[n + 2];
        for (int m = 0; m < n + 2; ++m) {
          Z sum = Z.ZERO;
          if (latticeType.length() == 1) { // D
            for (int k = 0; k <= n; ++k) {
              sum = sum.add(binomial(2 * n, 2 * k).subtract(Z.valueOf(2 * k).multiply(n - k)
                 .multiply(binomial(n, k).divide(Z.valueOf(n - 1)))));
            } // for k
            initTerms[m] = sum;
          } else { // D*, dual
            for (int k = 0; k <= n; ++k) {
              sum = sum.add(Z.TWO.pow(k).multiply(binomial(n, k)).multiply(binomial(m - 1, k - 1)));
            } // for k
            initTerms[m] = sum.add(Z.TWO.pow(n).multiply(binomial((n + 2 * m) / 2 - 1, n - 1)));
          } // for m
        } 
         break;
        
      case 'Q': // n-dimensional cubic lattices: n*a(n) = 22*a(n-1) + (n-2)*a(n-2), a(0) = 1, a(1) = 2*n
        polyList.add(new Z[] { Z.TWO.negate(), Z.ONE });
        polyList.add(new Z[] { Z.valueOf(2 * n) });
        polyList.add(new Z[] { Z.ZERO, Z.NEG_ONE });
        initTerms = new Z[2];
        initTerms[0] = Z.ONE;
        initTerms[1] = Z.valueOf(2 * n);
        break;
        
    } // switch
    initTerms[0] = Z.ONE; // bad patch, A computed 3 for odd n
    mInitTerms = initTerms;
    mPolyList = polyList;
  }
  
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
  
 }