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
   * @param opt optional parameter for cyclotomic lattices
   */
  public LatticeCoordinationSequence(final int offset, final String latticeType, final int n, final int opt) {
    super(offset, computeRecurrence(latticeType, n, opt), computeInitTerms (latticeType, n, opt), 0);
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
   * Convenience constructor without opt parameter
   * @param offset index of first term
   * @param latticeType A, B, C, D* and so on.
   * @param n order of the lattice
   */
  public LatticeCoordinationSequence(final int offset, final String latticeType, final int n) {
    this(offset, latticeType, n, 0);
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
  
 /**
   * Compute the coefficient list of polynomials in n for the holonomic recurrence.
   * @param latticeType A, B, C, D* and so on.
   * @param n order
   * @param opt optional parameter for cyclotomic lattices
   * @return the array of arrays of coefficients
   */
  protected static ArrayList<Z[]> computeRecurrence(final String latticeType, final int n, final int opt) {
    ArrayList<Z[]> result = new ArrayList<Z[]>(n);
    result.add(new Z[] { Z.ZERO }); // no constant - all recurrences are homogenous
    switch (latticeType.charAt(0)) {
      default:
      case 'A':
        for (int k = 0; k <= n; ++k) {
          Z coeff = binomial(n, k);
          if ((k & 1) == 0) { // even
            coeff = coeff.negate();
          }
          result.add(new Z[] { coeff });
        }
        break;
        
      case 'C': // C_12 lattice, A035749 - MATRIX="[[0],[6,-7,2],[-292,8,-4],[0,-1,2]]"
        result.add(new Z[] { Z.SIX, Z.SEVEN.negate(), Z.TWO });
        result.add(new Z[] { Z.valueOf(- 2 * (n * n + 2)) , Z.EIGHT, Z.FOUR.negate() });
        result.add(new Z[] { Z.ZERO, Z.NEG_ONE, Z.TWO });
        break;
        
      case 'D':
        for (int k = 0; k <= n; ++k) {
          Z coeff = binomial(n, k);
          if ((k & 1) == 0) { // odd
            coeff = coeff.negate();
          }
          result.add(new Z[] { coeff });
        }
        break;
        
      case 'Q': // n-dimensional cubic lattices: n*a(n) = 22*a(n-1) + (n-2)*a(n-2)
        result.add(new Z[] { Z.TWO.negate(), Z.ONE });
        result.add(new Z[] { Z.valueOf(2 * n) });
        result.add(new Z[] { Z.ZERO, Z.NEG_ONE });
        break;
        
    } // switch
    return result;
  }
  
  /**
   * Compute the initial terms for some lattice type.
   * The formulas are:
   * <pre>
   * A_n, A035842  n:=16; Table[Sum[Binomial[n+1, k]*Binomial[m-1, k-1]*Binomial[n-k+m, m], {k, 0, n}], {m, 0, n+2}]
   * D*_n: n:=22; Table[Sum[2^k*Binomial[n, k]*Binomial[m-1, k-1], {k, 0, n}] + 2^n*Binomial[(n+2*m)/2-1, n-1], {m, 0, n+2}]
   * 
   * </pre>
   * @param latticeType A, B, C, D* and so on.
   * @param n order
   * @param opt optional parameter for cyclotomic lattices
   * @return an array of the initial terms of the recurrence.
   */
  protected static Z[] computeInitTerms(final String latticeType, final int n, final int opt) {
    Z[] result = null;
    // System.out.println("initial terms: ");
    switch (latticeType.charAt(0)) {
      default:
      case 'A':
        result = new Z[n + 2];
        for (int m = 0; m < n + 2; m++) {
          Z sum = Z.ZERO;
          if (latticeType.length() == 1) { // A
            for (int k = 0; k <= n; k++) {
              sum = sum.add(binomial(n + 1, k).multiply(binomial(m - 1, k - 1)).multiply(binomial(n - k + m, m)));
            } // for k
            result[m] = sum;
          } else { // A*, dual
          }
        } // for m
        break;

      case 'C':
        result = new Z[] { Z.ONE };
        break;
        
      case 'D':
        result = new Z[n + 2];
        for (int m = 0; m < n + 2; ++m) {
          Z sum = Z.ZERO;
          if (latticeType.length() == 1) { // D
            for (int k = 0; k <= n; ++k) {
              sum = sum.add(binomial(2 * n, 2 * k).subtract(Z.valueOf(2 * k).multiply(n - k)
                 .multiply(binomial(n, k).divide(Z.valueOf(n - 1)))));
            } // for k
            result[m] = sum;
          } else { // D*, dual
            for (int k = 0; k <= n; ++k) {
              sum = sum.add(Z.TWO.pow(k).multiply(binomial(n, k)).multiply(binomial(m - 1, k - 1)));
            } // for k
            result[m] = sum.add(Z.TWO.pow(n).multiply(binomial((n + 2 * m) / 2 - 1, n - 1)));
          } // for m
        } 
        break;

      case 'Q': // n-dimensional cubic lattices: a(0) = 1, a(1) = 2*n
        result = new Z[2];
        result[0] = Z.ONE;
        result[1] = Z.valueOf(2 * n);
        break;
        
    } // switch
    result[0] = Z.ONE; // bad patch, A computed 3 for odd n
    return result;
  }
  
  /**
   * Gets a String representation
   * of the coefficient polynomials.
   * @return a list of polynomials of the form "[[0,1],[1,2],[1]]".
   */
  private String getPolyString() {
    StringBuffer result = new StringBuffer(256);
    ArrayList<Z[]> polyList = getPolyList();
    for (int i = 0; i < polyList.size(); i ++) { // polynomials
      Z[] poly = polyList.get(i);
      result.append(i == 0 ? '[' : ',');
      for (int j = 0; j < poly.length; j ++) {
        result.append(j == 0 ? '[' : ',');
        result.append(poly[j].toString());
      } // for j
      result.append(']');
    } // for i
    result.append(']');
    return result.toString();
  } // getPolyString

  /**
   * Gets a String representation
   * of the initial terms.
   * @return a list of terms of the form "[0,1,1,2,1]".
   */
  private String getInitString() {
    StringBuffer result = new StringBuffer(256);
    Z[] initTerms = getInitTerms();
    int j = 0;
    while (j < initTerms.length) {
      result.append(j == 0 ? '[' : ',');
      result.append(initTerms[j].toString());
      j ++;
    } // while j
    result.append(']');
    return result.toString();
  } // getInitString()

 }