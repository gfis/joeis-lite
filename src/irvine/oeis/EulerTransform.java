package irvine.oeis;

import java.util.ArrayList;
import irvine.math.Mobius;
import irvine.math.z.Z;
import irvine.math.z.ZUtils;
/**
 * Apply the Euler transform to some other sequence.
 * The program follows closely the code of the OEIS implementations
 * for Maple (N.J.A. Sloane) and Mathematica (Olivier Gerard),
 * see https://oeis.org/wiki/Sequence_transforms
 * @author Georg Fischer
 */
public class EulerTransform implements Sequence {

  private final Sequence mSeq;
  private final ArrayList<Z> mAs = new ArrayList<>(); // underlaying sequence
  private final ArrayList<Z> mBs = new ArrayList<>(); // resulting sequence
  private final ArrayList<Z> mCs = new ArrayList<>(); // auxiliary sequence
  protected int mN;

  /**
   * Create the Euler transform of the given sequence.
   *
   * @param seq underlying sequence
   */
  public EulerTransform(final Sequence seq) {
    mSeq = seq;
    mN = 0;
    mAs.add(Z.ZERO); // [0] not used
    mBs.add(Z.ZERO); // [0] is not returned
    mCs.add(Z.ZERO); // [0] starts the sum
  }

  /**
   * Return a term.
   * @return the next term of the transformed sequence.
   */
  @Override
  public Z next() {
    mN ++; // starts with 1
    mAs.add(mSeq.next()); // get next a(n)
    mCs.add(Z.ZERO); // allocate c[n]
    for (int i = 1; i <= mN; ++i) {
      Z cSum = Z.ZERO; // start with c[n-1]
      for (int d = 1; d <= i; ++d) { // compute c[n] = sum ...
        if (i % d == 0) { // "did(i,d)"
          cSum = cSum.add(Z.valueOf(d).multiply(mAs.get(d)));
        }
      } // for d
      mCs.set(i, cSum); // = c[n]
    } // for i
    int i = mN;
    Z bSum = mCs.get(i); 
    for (int d = 1; d < i; ++d) {
      bSum = bSum.add(mCs.get(d).multiply(mBs.get(i - d)));
    } // for d
    bSum = bSum.divide(Z.valueOf(i));
    mBs.add(bSum);
    return bSum;
  } 

  /**
   * Utility function: "did it divide?".
   * @param m first, nonnegative operand
   * @param n second, positive operand
   */
  public static int did(final int m, final int n) {
    return m % n == 0 ? 1 : 0;
  }
  
  /**
   * Utility function : MobiousMu or 0.
   * @param m first, nonnegative operand
   * @param n second, positive operand
   */
  public static int mob(final int m, final int n) {
    return m % n == 0 ? Mobius.mobius(m / n) : 0;
  }

}
