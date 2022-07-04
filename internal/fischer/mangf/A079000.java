package irvine.oeis.a079;

import java.util.TreeSet;
import java.util.function.Function;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A079000 a(n) is taken to be the smallest positive integer greater than a(n-1) which is consistent with the condition &quot;n is a member of the sequence if and only if a(n) is odd&quot;.
 * @author Georg Fischer
 */
public class A079000 implements Sequence {

  private int mN;
  private int mOffset;
  private Function<Z, Boolean> mCondition;
  private int mOptions;
  private Z mC; // candidate
  private TreeSet<Z> mMembers;

  /** Construct the sequence. */
  public A079000() {
    this(1, 1, 1, n -> n.isOdd());
  }

  /**
   * Generic constructor with parameters
   * @param offset index of first term
   * @param start value of first term
   * @param condition lambda expression for condition
   * @param options optional configuration settings: 4 = take start value
   */
  public A079000(final int offset, final int start, final int options, final Function<Z, Boolean> condition) {
    mOffset = offset;
    mN = offset - 1;
    mC = Z.valueOf(start - 1);
    mCondition = condition;
    mOptions = options;
    mMembers = new TreeSet<>();
  }

  @Override
  public Z next() {
    final Z nz = Z.valueOf(++mN);
    if (mN == mOffset && (mOptions & 4) != 0) { // first term
      mC = mC.add(1); // = start
      mMembers.add(mC);
      return mC; 
    }
    final boolean ncond = mCondition.apply(nz);
    final boolean ndef = mMembers.contains(nz);
    while (true) {
      mC = mC.add(1);
      final boolean ccond = mCondition.apply(mC);
      // System.out.println("mN=" + mN + ", ncond=" + (ncond ? 1 : 0) + ", mC=" + mC + ", ccond=" + (ccond ? 1 : 0) + ", ndef(" + mN + ")=" + (ndef ? 1 : 0));
      if (ccond) {
        if (ndef || mC.equals(nz)) {
          mMembers.add(mC);
          return mC;
        } 
      } else {
        if (!ndef && !mC.equals(nz)) {
          mMembers.add(mC);
          return mC;
        }
      }
    }
  }
}
