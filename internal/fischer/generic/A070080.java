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
  
  private final static boolean USE_DOUBLE = true;

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
        return Z.valueOf(mPeri);
      case GCD:
        advance();
        return Z.valueOf(LongUtils.gcd(mA, mB, mC));
      case SHAPE:
        advance();
        return Z.valueOf(mA*mA + mB*mB - mC*mC);
      case AREA:
        advance();
        if (USE_DOUBLE) {
          return Z.valueOf(Math.round(getArea(new Long[] { mA, mB, mC })));
        } else {
          final CR s = CR.valueOf(mPeri).divide(2);
          return s.subtract(mA).multiply(s.subtract(mB)).multiply(s.subtract(mC)).multiply(s).sqrt().round();
          // return new Q(sqArea16(new Long[] { mA, mB, mC }).sqrt(), Z.FOUR).round();
        }
      case INRAD:
        advance();
        if (USE_DOUBLE) {
          return Z.valueOf(Math.round(getInRadius(new Long[] { mA, mB, mC })));
        } else {
          final CR s = CR.valueOf(mPeri).divide(2);
          return s.subtract(mA).multiply(s.subtract(mB)).multiply(s.subtract(mC)).divide(s).sqrt().round();
          // return CR.valueOf(sqArea16(new Long[] { mA, mB, mC })).multiply(Z.FOUR).divide(CR.valueOf(mPeri*mPeri)).sqrt().round();
        }
      case COND:
        ++mN;
        if(mN < 3) { // 1,1,1 with mPeri=3 is the minimal triangle
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
   * Compute the area as a double.
   * @return <code>p*(p - 2*a)*(p - 2*b)*(p - 2*c)</code>
   */
  protected static double getArea(final Long[] s) {
    final double p2 = (s[0] + s[1] + s[2]) / 2.0;
    return Math.sqrt((p2 - s[0])*(p2 - s[1])*(p2 - s[2])*p2);
  }

  /**
   * Compute the inradius as a double.
   * @return <code>p*(p - 2*a)*(p - 2*b)*(p - 2*c)</code>
   */
  protected static double getInRadius(final Long[] s) {
    final double p2 = (s[0] + s[1] + s[2]) / 2.0;
    return Math.sqrt((p2 - s[0])*(p2 - s[1])*(p2 - s[2])/p2);
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
    return getArea(s) % 1 == 0;
  }

  protected static boolean hasIntInRadius(final Long[] s) {
    return getInRadius(s) % 1 == 0;
  }

  protected static boolean hasTrigonalArea(final Long[] s) {
    final double area = getArea(s);
    if (area % 1 == 0) {
       return ZUtils.isTriangular(Z.valueOf((long) area));
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

  /**
   * Test method: print Zumkeller&apos; list for a range of perimeters
   * @param args command line arguments:
   * <ul>
   * <li>-d debugging mode: 0=none (default), 1=some, 2=more</li>
   * <li>-s first perimeter</li>
   * <li>-e last perimeter</li>
   * </ul>
   */
  public static void main(final String[] args) {
    int debug = 0;
    int periStart = 1;
    int periEnd = 50;
    int iarg = 0;
    while (iarg < args.length) {
      final String opt = args[iarg++];
      try {
        if (false) {
        } else if ("-d".equals(opt)) {
          debug = Integer.parseInt(args[iarg++]);
        } else if ("-s".equals(opt)) {
          periStart = Integer.parseInt(args[iarg++]);
        } else if ("-e".equals(opt)) {
          periEnd   = Integer.parseInt(args[iarg++]);
        } else {
          System.err.println("invalid option " + opt);
        }
      } catch (final NumberFormatException exc) {
        // ignored
      }
    }
    new A070080().printList(periStart, periEnd);
  }

  private void printSeparator() {
    System.out.println("+-------+-------+-------------+-------+-------+-----------+");
  }

/*
        print sprintf("| %5d | %5d |%4d%4d%4d |", n, mPeri, mA, mB, mC);
        print sprintf("%6d |%6d |", &gcd(mA, &gcd(mB, mC)), mA*mA + mB*mB - mC*mC);
        my $s = mPeri/2;
        my $H = sprintf("%12.6f", sqrt($s*($s - mA)*($s - mB)*($s - mC)));
        my $I = sprintf("%10.6f", sqrt(   ($s - mA)*($s - mB)*($s - mC)/$s));
        print " s" if mA <  mB && mB <  mC;
        print " i" if mA == mB || mB == mC;
        if (0) {
        } elsif (&isPrime(mA) && &isPrime(mB) && &isPrime(mC)) {
            print " p";
        } elsif (&gcd(mA, &gcd(mB, mC)) == 1) {
            print " r";
        } else {
            print "  ";
        }
        print " A" if mA*mA + mB*mB >  mC*mC;
        print " R" if mA*mA + mB*mB == mC*mC;
        print " O" if mA*mA + mB*mB <  mC*mC;
        print "" . (($H =~ m{\.000000}) ? " H" : "  ");
        print "" . (($I =~ m{\.000000}) ? " I" : "  ");
        print " | $H $I";
        print "\n";
*/
  private void printList(final long periStart, final long periEnd) {
    mPeri = periStart;
    long oldPeri = mPeri; 
    mA = 1;
    mB = 0;
    int n = 0;
    while (mPeri <= periEnd) {
      ++n;
      advance();
      if (mPeri != oldPeri) {
        printSeparator();
        oldPeri = mPeri;
      }
      if (mPeri <= periEnd) {
        System.out.print(String.format("| %5d | %5d |%4d%4d%4d |", n, mPeri, mA, mB, mC));
        System.out.print(String.format("%6d |%6d |", LongUtils.gcd(mA, mB, mC), mA*mA + mB*mB - mC*mC));
        final Long[] s = new Long[] { mA, mB, mC};
        String H = String.format("%12.6f", getArea    (s)).replace(',', '.');
        String I = String.format( "%8.6f", getInRadius(s)).replace(',', '.');
        if (isScalene(s)) {
          System.out.print(" s");
        }
        if (isIsosceles(s)) {
          System.out.print(" i");
        }
        if (hasPrimeSides(s)) {
          System.out.print(" p");
        }  else if (hasCoPrimeSides(s)) {
          System.out.print(" r");
        } else {
          System.out.print("  ");
        }
        
        if (isAcute(s)) {
          System.out.print(" A");
        }  else if (isRight(s)) {
          System.out.print(" R");
        }  else if (isObtuse(s)) {
          System.out.print(" O");
        } else {
          System.out.print("  ");
        }
        System.out.print(hasIntArea(s) ? " H" : "  ");
        System.out.print(hasIntInRadius(s) ? " I" : "  ");
        System.out.print(" | " + H + " " + I);
        System.out.println();
      }
    }
  }
}
