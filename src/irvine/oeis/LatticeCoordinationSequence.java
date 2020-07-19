package irvine.oeis;

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.LinearRecurrence;

/**
 * Coordination sequence for a lattice of some type (A, B, C and so on) and order n,
 * which is realized by a linear recurrence. The signature are the
 * coefficients of (1-x)^n, and the initial terms are computed by a sum 
 * of expressions of binomial(n,k), depending on the type.
 * @author Georg Fischer
 */
public class LatticeCoordinationSequence extends LinearRecurrence {

  /**
   * Construct the sequence by reducing it to a linear recurrence.
   * The constructor computation is close to the sequence definition 
   * and not optimized for speed.
   * @param latticeType A, B, C, D* and so on.
   * @param n order of the lattice
   */
  public LatticeCoordinationSequence(final String latticeType, final int n) {
    super(computeRecurrence(n), computeTerms(latticeType, n), new Z[] { Z.ONE });
  }

  /**
   * Compute the reversed signature of the recurrence,
   * @param n order
   * @return the array of coefficients of 1-(1-x)^n,
   * for example [4,-6,4,-1] for n = 4.
   */
  protected static Z[] computeRecurrence(final int n) {
    Z[] result = new Z[n];
    Z sign = Z.NEG_ONE;
    for (int k = 1; k <= n; ++k) {
      sign = sign.negate();
      result[n - k] = sign.multiply(Binomial.binomial(n, k));
    }
  /*
    System.out.print("recurrence: ");
    for (int m = 0; m < n; ++m) { System.out.print(result[m].toString() + ","); };
    System.out.println();
  */
    return result;
  }
  
  /**
   * Compute the initial terms for some lattice type.
   * The formulas are:
   * <pre>
   * D*_n: n:=22; Table[Sum[2^k*Binomial[n, k]*Binomial[m-1, k-1], {k, 0, n}] + 2^n*Binomial[(n+2*m)/2-1, n-1], {m, 0, n+2}]
   * </pre>
   * @param latticeType A, B, C, D* and so on.
   * @param n order
   * @return an array of the initial terms of the recurrence.
   */
  protected static Z[] computeTerms(final String latticeType, final int n) {
    Z[] result = new Z[n];
    Z sum = Z.ZERO;
    // System.out.println("initial terms: ");
    switch (latticeType.charAt(0)) {
      default:
      case 'D':
        for (int m = 1; m <= n; ++m) {
          sum = Z.TWO.pow(n).multiply(Binomial.binomial((n + 2 * m) / 2 - 1, n - 1));
          // System.out.println("m=" + m + ", sum="    + sum.toString());
          Z kp2 = Z.ONE;
          for (int k = 0; k <= n; ++k) {
            sum = sum.add(kp2.multiply(Binomial.binomial(n, k)).multiply(Binomial.binomial(m - 1, k - 1)));
            kp2 = kp2.multiply(Z.TWO);
          } // for k
          result[m - 1] = sum;
          // System.out.println("m=" + m + ", result=" + sum.toString());
        } // for m
        break;
        
    } // switch
    return result;
  }
  
}