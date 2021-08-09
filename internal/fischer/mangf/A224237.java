package irvine.oeis.a224;

import irvine.math.cr.CR;
import irvine.math.q.Q;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A224237 Decimal expansion of speed of light in miles per second.
 * The exact answer (by definition) is 299792458/(5280*0.3048)
 * @author Georg Fischer
 */
public class A224237 extends DecimalExpansionSequence {

  private static final CR N = CR.valueOf(new Q(299792458L*10000L, 5280L*3048L));

  @Override
  protected CR getCR() {
    return N;
  }
}
