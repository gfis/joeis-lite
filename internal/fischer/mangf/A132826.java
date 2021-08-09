package irvine.oeis.a132;
// manually at 2021-07-21

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A132826 Decimal expansion of the integer Googol!.
 * Usual DecimalExpansion, but throws <code>UnsupportedOperationException</code> 
 * when the limit of number of terms {@link #NBRDGT} is reached.
 * @author Georg Fischer
 */
public class A132826 extends DecimalExpansionSequence {

  /** Construct the sequence */
  public A132826() {
    super(getCR(10, CR.valueOf(10000).pow(25)));
  }

  protected static final int NBRDGT = 128; // implementation limit
  protected int mTermNo = 0;

  /**
   * Compute some leading digits of a power tower
   * @param base base of power tower
   * @param expr integer expression for the power tower with one level decreased
   * The formula is taken from the Mathematica in A241295:
   * f[n_] := 10^FractionalPart[ N[(n*Log[n] - n + (1/2) Log[2 Pi*n + 1/3])/Log[10], 203]];
   * RealDigits[ f[10^100], 10, 101][[1]]
   * @return or real value
   */
  protected static CR getCR(final int base, final CR expr) {
    return CR.TEN.pow(
        (expr.multiply(expr.log()).subtract(expr).add
          (CR.HALF.multiply(CR.TWO.multiply(CR.PI).multiply(expr).add(CR.ONE_THIRD)).log()
          .divide(CR.TEN.log())))
        .frac(2*NBRDGT + 1));
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
