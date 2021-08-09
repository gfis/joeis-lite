package irvine.oeis.a328;
// manually 2021-01-27

import irvine.oeis.HolonomicRecurrence;

/**
 * A328551 a(n) = -8865 + (18057/4)*n + (37881/8)*n^2 - 2529*n^3 - 642*n^4 + (1809/4)*n^5 - 27*n^7 + (27/8)*n^8.
 * @author Georg Fischer
 */
public class A328551 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A328551() {
    super(1
      , "[0,-1,9,-36,84,-126,126,-84,36,-9,1]"
      , "[0,0,0,666,36975,437517,2667375,11225145,37206936,104285790,257991042]"
      , 0);
  }
  
}
