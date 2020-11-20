package irvine.oeis;

import irvine.math.cr.CR;
import irvine.math.z.Z;

/**
 * The Pierce expansion of a real number.
 * See A006284: (PARI) r=Pi; for(n=1, 100, s=(r/(r-floor(r))); print1(floor(r), ", "); r=s;).
 * @author Sean A. Irvine
 */
public abstract class PierceExpansionSequence implements Sequence {

  private CR mU = null;

  protected abstract CR getN();

  protected int precision() {
    return 10000;
  }

  @Override
  public Z next() {
    mU = mU == null ? getN().inverse() : mU.divide(mU.subtract(CR.valueOf(mU.floor(precision()))));
    return mU.floor(precision());
  }
}
