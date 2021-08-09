package irvine.oeis.a224;

import irvine.math.cr.CR;
import irvine.math.q.Q;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A224233 Decimal expansion of number of inches in a meter.
 * The exact value (this is the definition of an inch) is 1/0.0254.
 * @author Georg Fischer
 */
public class A224233 extends DecimalExpansionSequence {

  private static final CR N = CR.valueOf(new Q(10000, 254));

  @Override
  protected CR getCR() {
    return N;
  }
}
