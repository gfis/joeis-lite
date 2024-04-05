package irvine.oeis.a070;

import java.util.function.Function;

import irvine.math.LongUtils;
import irvine.math.cr.CR;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.AbstractSequence;

/**
 * A070080 Smallest side of integer triangles [a(n) &lt;= A070081(n) &lt;= A070082(n)], sorted by perimeter, lexicographically ordered.
 * This is the superclass for a set of sequences related to integer-sided triangles.
 * The triangles are generated:
 * <ul>
 * <li>with increasing perimeters p</li>
 * <li>with increasing smallest side a (bottom)</li>
 * <li>with increasing middle side b >= a (left)</li>
 * <li>with right side c = p - a - b <= b</li>
 * </ul>
 * <pre>
 *     |\    ->   /|
 *    b| \ c     / |
 *     |  \     /  |
 *     +---+   +---+
 *       a
 * </pre>
 * The top corner is moved from left to right with (++b, --c).
 * @author Georg Fischer
 */
public class A070080 extends AbstractSequence {

  private long mN;
  private int mMode; // mode of operation, type of the target terms, one of the following:
  public final static int SIDE_A = 0;
  public final static int SIDE_B = 1;
  public final static int SIDE_C = 2;
  public final static int PERIMETER = 3; // a + b + c
  public final static int GCD = 4;
  public final static int SHAPE = 5; // a^2 + b^2 - c^2
  public final static int AREA = 6;
  public final static int INRAD = 7;

  public final static int COND = 8; // count occurrences of condition for the triangles with perimeter n
  public final static int FILTER = 9; // select indexes by using a condition 
  public final static int INDEX = 10; // select values by using a condition 

  protected long mA; // length of side a
  protected long mB; // length of side b
  protected long mC; // length of side c
  protected long mPeri; // perimeter = a + b+ c
  protected Function<Long[], Boolean> mCond; // condition for all triangle(s)

  /** Construct the sequence. */
  public A070080() {
    this(1, SIDE_A, null);
  }

  /**
   * Generic constructor with mode.
   * Parameter <code>cond</code> cannot be omitted for the modes <code>COND_N</code> and <code>FILTER</code>.
   * @param offset first index
   * @param mode of operation, type of the target terms
   */
  public A070080(final int offset, final int mode) {
    this(offset, mode, null);
  }

  /**
   * Generic constructor with mode and condition.
   * @param offset first index
   * @param mode of operation, type of the target terms
   * @param cond bitmask for the condition for the selection of triangles
   */
  public A070080(final int offset, final int mode, final Function<Long[], Boolean> cond) {
    super(offset);
    mN = offset - 1;
    mMode = mode;
    mCond = cond;
    mPeri = 1;
    mA = 1;
    mB = 0;
  }

  /**
   * Generate the next triangle.
   */
  protected void advance() {
    boolean busy = true;
    while (busy) {
      ++mB;
      mC = mPeri - mA - mB;
      // print sprintf("%3d: %3d %3d %3d P\n", mPeri, mA, mB, mC);
      if (mA <= mB && mB <= mC && mA + mB > mC) {
        busy = false;
      } else if (mB > mC) {
        ++mA;
        mB = mA;
        mC = mPeri - mA - mB;
        // print sprintf("%3d: %3d %3d %3d Q\n", mPeri, mA, mB, mC);
        if (mA <= mB && mB <= mC && mA + mB > mC) {
          busy = false;
        } else if (mB + mC <= mA) {
          mPeri ++;
          mA = 1;
          mB = mA;
          mC = mPeri - mA - mB;
          // print sprintf("%3d: %3d %3d %3d R\n", mPeri, mA, mB, mC);
          if (mA <= mB && mB <= mC && mA + mB > mC) {
            busy = false;
          }
        }
      }
    } 
  }

  @Override
  public Z next() {
    switch (mMode) {
      default:
      case SIDE_A:
        advance();
        return Z.valueOf(mA);
      case SIDE_B:
        advance();
        return Z.valueOf(mB);
      case SIDE_C:
        advance();
        return Z.valueOf(mC);
      case PERIMETER:
        advance();
        return Z.valueOf(mA + mB + mC);
      case GCD:
        advance();
        return Z.valueOf(mA).gcd(Z.valueOf(mB)).gcd(Z.valueOf(mC));
      case SHAPE:
        advance();
        return Z.valueOf(mA).square().add(Z.valueOf(mB).square()).subtract(Z.valueOf(mC).square());
      case AREA:
        advance();
        return new Q(sqArea16(new Long[] { mA, mB, mC }).sqrt(), Z.FOUR).round();
      case INRAD:
        advance();
        return CR.valueOf(sqArea16(new Long[] { mA, mB, mC })).multiply(Z.FOUR).divide(CR.valueOf(mPeri*mPeri)).sqrt().round();

      case COND:
        ++mN;
        if(mN < 3) { // 1,1,1 with mP=3 is the minimal triangle
          return Z.ZERO;
        }
        mPeri = mN;
        mA = 1;
        mB = 0;
        advance();
        long sum = 0;
        while (mPeri == mN) {
          if (evaluate(new Long[] { mA, mB, mC })) {
            ++sum;
          }
          advance();
        }
        return Z.valueOf(sum);
      case FILTER:
        while (true) {
          ++mN;
          advance();
          if (evaluate(new Long[] { mA, mB, mC })) {
            return Z.valueOf(mN);
          }
        }
      case INDEX:
        while (true) {
          ++mN;
          advance();
          if (evaluate(new Long[] { mA, mB, mC })) {
            return Z.valueOf(mN);
          }
        }
    }
  }

  /**
   * Compute the square of the area, times 16.
   * Heron&apos;s theorem: <code>area = sqrt(p/2*(p/2 - a)*(p/2 - b)*(p/2 - c)) with p = a + b + c;</code> or
   * <code>area = sqrt(sqArea16 / 16)</code> and 
   * radius of incircle = <code>area / (p/2)</code>.
   * @return <code>p*(p - 2*a)*(p - 2*b)*(p - 2*c)</code>
   */
  protected static Z sqArea16(final Long[] s) {
    final Z p = Z.valueOf(s[0] + s[1] + s[2]);
    final Z h16 = p
        .multiply(p.subtract(2 * s[0]))
        .multiply(p.subtract(2 * s[1]))
        .multiply(p.subtract(2 * s[2]));
    return h16.compareTo(Z.ZERO) < 0 ? Z.ZERO : h16;
  }

  /**
   * Evaluate the condition.
   * @param s array for sides a, b, c
   * @return true if the conditions are all fulfilled.
   */
  protected boolean evaluate(final Long[] s) {
    return mCond.apply(s);
  }

  protected static boolean hasCoPrimeSides(final Long[] s) {
    return LongUtils.gcd(s[0], s[1], s[2]) == 1;
  }

  protected static boolean hasIntArea(final Long[] s) {
    final Z h16 = sqArea16(s);
    return h16.mod(16) == 0 && h16.isSquare();
  }

  protected static boolean hasIntInRadius(final Long[] s) {
    // inrad = sqrt((p2-a)*(p2-b)*(p2-c)/p2) where p2=(a+b+c)/2
    final Z h16 = sqArea16(s);
    final long p = s[0] + s[1] + s[2];
    return h16.mod(p*p*4) == 0 && h16.isSquare();
  }

  protected static boolean hasTrigonalArea(final Long[] s) {
    final Z h16 = sqArea16(s);
    if (h16.mod(16) == 0 && h16.isSquare()) {
      final Z h4 = h16.sqrt().divide(4);
      return ZUtils.isTriangular(h4);
    } else {
      return false;
    }
  }

  protected static boolean hasPrimeSides(final Long[] s) {
    return Z.valueOf(s[0]).isProbablePrime()
        && Z.valueOf(s[1]).isProbablePrime()
        && Z.valueOf(s[2]).isProbablePrime();
  }
  protected static boolean isAcute(final Long[] s) {
    return s[0]*s[0] + s[1]*s[1] > s[2]*s[2];
  }

  protected static boolean isHeronian(final Long[] s) {
    final Z h16 = sqArea16(s);
    if (h16.compareTo(Z.ZERO) >= 0) {
      final Z h4 = h16.sqrt();
      return h16.auxiliary() == 1; // perfect square
    } else {
      return false;
    }
  }

  protected static boolean isIsosceles(final Long[] s) {
    return s[0] == s[1] || s[1] == s[2];
  }

  protected static boolean isObtuse(final Long[] s) {
    return s[0]*s[0] + s[1]*s[1] < s[2]*s[2];
  }

  protected static boolean isRight(final Long[] s) {
    return s[0]*s[0] + s[1]*s[1] == s[2]*s[2];
  }

  protected static boolean isScalene(final Long[] s) {
    return s[0] < s[1] && s[1] < s[2];
  }

  protected static boolean isTriangle(final Long[] s) {
    return s[0] <= s[1] && s[1] <= s[2] && s[0] + s[1] > s[2];
  }

}
