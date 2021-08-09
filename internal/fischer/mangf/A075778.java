package irvine.oeis.a075;
// manually (decexro) at 2021-07-27

import irvine.math.cr.CR;
import irvine.math.cr.UnaryCRFunction;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A075778 Decimal expansion of the real root of x^3 + x^2 - 1.
 * Polynomial: x^3+x^2-1
 * @author Georg Fischer
 */
public class A075778 extends DecimalExpansionSequence {

  /** Construct the sequence. */
  public A075778() {
    super(0, new UnaryCRFunction () { @Override public CR execute(final CR x) {
        CR fx = x.pow(3).add(x.pow(2)).subtract(CR.ONE);
        // optional: fx = some_function(fx);
        return fx;
        }}.inverseMonotone(CR.valueOf(0.3), CR.ONE).execute(CR.ZERO));
  }
}
