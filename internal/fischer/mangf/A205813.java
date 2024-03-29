package irvine.oeis.a205;

import irvine.math.z.Z;
import irvine.oeis.a000.A000984;
import irvine.oeis.triangle.PartitionTransformTriangle;

/**
 * A205813 Triangle T(n,k), read by rows, given by (0, 2, 1, 1, 1, 1, 1, 1, 1, ...) DELTA (1, 0, 0, 0, 0, 0, 0, 0, ...) where DELTA is the operator defined in A084938.
 * @author Georg Fischer
 */
public class A205813  extends PartitionTransformTriangle {

  private int mN = -1;
  private int mTri = 0; // next triangular number
  private int mTrix = 0; // index of next triangular number

  /** Construct the sequence. */
  public A205813() {
    super(0, new A000984(), 0);
  }

  @Override
  public Z next() {
    ++mN;
    if (mN == mTri) { // prefix with a column 0 = [1, 0, 0, 0 ...]
      ++mTrix;
      mTri += mTrix;
      return mN == 0 ? Z.ONE : Z.ZERO;
    }
    return super.next();
  }
}