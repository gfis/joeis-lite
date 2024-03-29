package irvine.oeis.a036;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A036507 Smallest square containing exactly n 0&apos;s.
 * @author Georg Fischer
 */
public class A036507 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A036507() {
    super(1, "[0,100,0,-1]", "0,100,102400", 0);
  }
}
