package irvine.oeis.a087;
// manually 2021-09-26

import irvine.math.z.Z;
import irvine.oeis.HolonomicRecurrence;

/**
 * A087547 a(n) = n!*2^(n+1) * (Integral_{x = 0..1} 1/(1+x^2)^(n+1) dx - Pi*(2*n)!/(2^(n+1)*n!).
 * @author Georg Fischer
 */

public class A087547 extends HolonomicRecurrence {
    
  public A087547() {
    super(0, "[[0],[-3,5,-2],[-2,3],[-1]]", "[0,1]", 0);
  }
}
