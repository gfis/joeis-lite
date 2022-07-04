package irvine.oeis.a283;
// manually A283765/posubse at 2022-06-08 17:10

import irvine.math.z.Z;
import irvine.oeis.PositionSubsequence;
import irvine.oeis.a022.A022843;

/**
 * A283778 a(n+1) - a(n) is in {1,2,3}
 * @author Georg Fischer
 */
public class A283778 extends PositionSubsequence {

  /** Construct the sequence. */
  public A283778() {
    super(new A022843(), 0);
  }
  
  @Override
  public boolean isOk(Z term) {
    return term.isOdd();
  }
}
