package irvine.oeis.prime;

import java.util.Map;
import java.util.TreeMap;

import irvine.math.z.Z;
import irvine.util.Pair;
import irvine.oeis.Sequence;

/**
 * A sequence of nonnegative numbers represented by a binary quadratic form <code>a*x^2 + b*x*y + c*y^2</code>.
 * <code>x</code> and <code>y</code> may be &gt=; 0 or any integer, and the numbers may be primes only.
 * @author Georg Fischer
 */
public class BinaryQuadraticForm extends TreeMap<Z, Pair<Integer, Integer>> implements Sequence {

  protected int mA; // factor of x^2
  protected int mB; // factor of x*y, maybe 0 or negative
  protected int mC; // factor of y^2
  protected boolean mAnyInteger;
  protected boolean mPrimesOnly;
  protected Z mOldTerm; // previous term
  
  protected static int sDebug = 0;

  /**
   * Construct an instance from a list of remainders.
   * @param start number of of initial terms, index of first residue
   * @param modulus divisor
   * @param residues list of initial terms followed by the residues
   */
  public BinaryQuadraticForm(final int a, final int b, final int c, boolean anyInteger, boolean primesOnly) {
    mA = a;
    mB = b;
    mC = c;
    mAnyInteger = anyInteger;
    mPrimesOnly = primesOnly;
    mOldTerm = Z.ZERO;
    int x = 0;
    int y = 0;
    addEntry(0, 0);
    if (anyInteger) {
      addEntry(-1, 0);
      addEntry(0, -1);
    }
  }

  /**
   * Compute the next value of <code>x</code> in the same direction as the previous value.
   * @param x previous value
   * @return new value
   */
  protected int advanceX(final int x) {
    return x >= 0 ? x + 1 : x - 1;
  }

  /**
   * Compute the next value of <code>y</code> in the same direction as the previous value.
   * @param y previous value
   * @return new value
   */
  protected int advanceY(final int y) {
    return y >= 0 ? y + 1 : y - 1;
  }

  /**
   * Compute the value of the form
   * @param x variable x
   * @param y variable y
   * @return <code>a*x^2 + b*x*y + c*y^2</code>
   */
  protected void addEntry(final int x, final int y) {
    put(Z.valueOf(mA).multiply(x * x).add(mB * x * y).add(mC * y * y), new Pair<Integer, Integer>(x, y));
  }

  @Override
  public Z next() {
    while (true) {
      final Map.Entry<Z, Pair<Integer, Integer>> entry = pollFirstEntry();
      final Z result = entry.getKey();
      Pair<Integer, Integer> pair = entry.getValue();
      final int x0 = pair.left();
      final int y0 = pair.right();
      final int x1 = advanceX(x0);
      final int y1 = advanceY(y0);
      addEntry(x0, y1);
      addEntry(x1, y0);
      addEntry(x1, y1);
      if (!result.equals(mOldTerm)) {
        mOldTerm = result;
        if (!mPrimesOnly || result.isProbablePrime()) {
          return result;
        }
      }
    }
  }

  /**
   * Main method for testing
   * @param args command line arguments:
   * <ul>
   * <li>-b   output is b-file format (default: comma separated data line)</li>
   * <li>-d   debugging level (default 0=none; 1=some, 2=more)</li>
   * <li>-m   modulus (default 71)</li>
   * <li>-n   number of terms to be computed (default 64)</li>
   * </ul>
   */
  public static void main(String[] args) {
    boolean bFile = false;
    int noTerms   = 32;
    int a = 2;
    int b = 0;
    int c = 7;
    boolean primesOnly = false;
    boolean anyInteger = false; // x, y nonnegative
    int iarg = 0;
    while (iarg < args.length) { // consume all arguments
      final String opt = args[iarg ++];
      try {
        if (false) {
        } else if (opt.equals    ("-a")     ) {
          a       = Integer.parseInt(args[iarg++]);
        } else if (opt.equals    ("-bf")    ) {
          bf      = true;
        } else if (opt.equals    ("-b")     ) {
          b       = Integer.parseInt(args[iarg++]);
        } else if (opt.equals    ("-c")     ) {
          c       = Integer.parseInt(args[iarg++]);
        } else if (opt.equals    ("-d")     ) {
          sDebug  = Integer.parseInt(args[iarg++]);
        } else if (opt.equals    ("-i")     ) {
          anyInteger = true; // x, y element of Z
        } else if (opt.equals    ("-n")     ) {
          noTerms = Integer.parseInt(args[iarg++]);
        } else if (opt.equals    ("-p")     ) {
          primesOnly = true;
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args

    final BinaryQuadraticForm bf = new BinaryQuadraticForm(a, b, c, anyInteger, primesOnly);
      }
    } else {
      for (int it = 1; it <= noTerms; ++it) {
        if (bfile) {
          System.out.println(it + " " + bf.next());
        } else {
          System.out.print((it == 0 ? "" : ", ") + " " + bf.next());
        }
      }
      System.out.println();
    } 
  } // main
}
