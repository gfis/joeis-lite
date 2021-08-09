package irvine.oeis.a089;
// manually at 2021-07-21

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A089065 2^13466917-1
 * @author Georg Fischer
 */
public class A089065 extends DecimalExpansionSequence {

  /** Construct the sequence */
  public A089065() {
    super(getCR(10, Z.ONE.shiftLeft(13466917).subtract(Z.ONE)));
  }

  protected static final int NBRDGT = 128; // implementation limit
  protected int mTermNo = 0;

  /**
   * Compute some leading digits of a power tower
   * @param base base of power tower
   * @param expr integer expression for the power tower with one level decreased
   * The formula is taken from the Mathematica in A241295:
   * nbrdgt = 105; 
   * f[base_, exp_] := RealDigits[ 
   *   10^FractionalPart[ 
   *     N[exp*Log10[base], nbrdgt + Floor[Log10[exp]] + 2]
   *   ]
   *   , 10, nbrdgt][[1]]; 
   * f[ 6, 6^6^6]
   * @return or real value
   */
  protected static CR getCR(final int base, final Z expr) {
    return CR.TEN.pow((CR.valueOf(expr).multiply(CR.valueOf(base)).log().divide(CR.TEN.log())
      ).frac(NBRDGT + CR.valueOf(expr).log().divide(CR.TEN.log()).floor().intValue() + 2)
      );
  }

  @Override
  public Z next() {
    ++mTermNo;
    if (mTermNo < NBRDGT) {
      return super.next();
    } else {
      throw new UnsupportedOperationException("implementation limited to " + NBRDGT + " terms");
    }
  }
}
