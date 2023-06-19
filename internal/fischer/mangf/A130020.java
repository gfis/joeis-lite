package irvine.oeis.a130;
// Generated by gen_seq4.pl transpose at 2023-06-02 15:26

import irvine.math.z.Z;
import irvine.oeis.PrependSequence;
import irvine.oeis.a059.A059365;
import irvine.oeis.triangle.Transpose;

/**
 * A130020 Triangle T(n,k), 0&lt;=k&lt;=n, read by rows given by [1,0,0,0,0,0,0,...] DELTA [0,1,1,1,1,1,1,...] where DELTA is the operator defined in A084938 .
 * @author Georg Fischer
 */
public class A130020 extends Transpose {

  /** Construct the sequence. */
  public A130020() {
    super(new PrependSequence(1, new A059365(), 1));
  }
}