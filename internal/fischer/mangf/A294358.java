package irvine.oeis.a294;
// manually deris2/recordval at 2021-11-04

import irvine.oeis.RecordSubsequence;
import irvine.oeis.a007.A007963;
/**
 * A294358 Records in A007963.
 * @author Georg Fischer
 */
public class A294358 extends RecordSubsequence {

  /** Construct the sequence. */
  public A294358() {
    super(new A007963());
    next();
  }
}
