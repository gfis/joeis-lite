package irvine.oeis.a302;
// Generated by gen_seq4.pl rectoproc/holos at 2023-06-02 21:44

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A302352 a(n) = Sum_{k=0..n} k^4*binomial(2*n-k,n).
 * @author Georg Fischer
 */
public class A302352 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A302352() {
    super(0, "[[0],[-2950874,18530154,-38161312,25809000],[-191806810,72399267,2583091,-6452250],[-6008460,3462198,932778]]", "0,1,19,155", 0);
  }
}
