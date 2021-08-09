package irvine.oeis.a048;
// Generated by gen_seq4.pl subsele at 2021-04-29 22:51; manually modified

import irvine.math.z.Z;
import irvine.oeis.a047.A047161;

/**
 * A048060 Number of nonempty subsets of {1,2,...,n} in which exactly 1/2 of the elements are <= (n-4)/2.
 * @author Georg Fischer
 */
public class A048060 extends A047161 {

  /** Construct the sequence. */
  public A048060() {
    super(1, 1, 2, -4, 2);
  }
  
  @Override
  public Z next() {
  	Z result = super.next();
  	return mN < 5 ? Z.ZERO : result;
  }

}