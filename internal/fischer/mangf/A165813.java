package irvine.oeis.a165;
// manually
import irvine.oeis.HolonomicRecurrence;

/**
 * A165813 a(0)=1, a(n)=n*(a(n-1)+3).
 * @author Georg Fischer
 */
public class A165813 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A165813() {
    super(0, "[[0,3],[0,1],[-1]]", "[1]", 0);
  }
}
