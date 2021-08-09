package irvine.oeis.a046;

import irvine.math.z.Z;
import irvine.oeis.Sequence;
import irvine.oeis.a046.A046966;

/**
 * A046972 Primes arising in A046966.
 * @author Sean A. Irvine
 */
public class A046972 implements Sequence {

  protected Sequence mSeq ;
  
  /** Construct the sequence */
  public A046972 () {
    this(1);
  }
  
  /** 
   * Generic constructor with parameter
   * @param start initial value of the product
   */
  public A046972(final int start) {
    mSeq = new A046966(start);
  }
  
  @Override
  public Z next() {
    super.next();
    return mSeq.mProd.add(1);
  }
}
