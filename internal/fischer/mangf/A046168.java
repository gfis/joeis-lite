package irvine.oeis.a046;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A046168 Number of minimal covers on n objects with 8 members.
 * @author Georg Fischer
 */
public class A046168 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A046168() {
    super(1, "[0,-3952361592557698320000,141733143953520587280,-2258904690634832676,21000780793566944,-125510975336691,500070185769,-1328260374,2268006,-2259,1]", "[0,0,0,0,0,0,0,1,2259,2835075]", 0);
  }
}
