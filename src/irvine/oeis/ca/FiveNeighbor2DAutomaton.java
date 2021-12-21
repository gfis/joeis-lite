package irvine.oeis.ca;

import java.util.ArrayList;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * Data structure and methods for the evaluation of a 2D 5-Neighbor Outer Totalistic Cellular Automaton
 * as described by Stephen Wolfram in the book "A New Kind Of Science" (ANKOS).
 * @see <a href="https://oeis.org/wiki/Index_to_2D_5-Neighbor_Cellular_Automata">https://oeis.org/wiki/Index_to_2D_5-Neighbor_Cellular_Automata</a>.
 * The square is always symmetrical on the vertical, horizontal and both diagonal axes, therefore
 * only the lower right half triangle of the south-west quadrant is computed,
 * and the other parts of the 4 quadrants can be completed by reflection and rotation of that triangle.
 * "5-Neighbor Outer Totalistic" means that the new value of a specific cell depends on the old value of that cell
 * and the number of black values in the 4 cells to the north, east, south, west of that cell.
 * @author Georg Fischer
 */
public class FiveNeighbor2DAutomaton extends ArrayList<Z> implements Sequence {

  /** Rule number 0..1023, cf. ANKOS pp. 170-179 */
  protected int mRule;
  /**
   * Number of the generation; <code>mGen</code> = 0 starts with a single BLACK cell
   * in the lowest bit position of <code>mOldRow[mCenter]</code>
   */
  protected int mGen;

  /** Index of next term */
  protected int mN;
  /** Debugging mode: 0=none, 1=some, 2=more. */
  protected static int sDebug;
  /** Cell values for the rest of the square outside the current generation. */
  protected int mBackground; //
  /** Summation term for several subtypes of sequences */
  protected Z mSum;
  /** Count of BLACK/ON cells in current square */
  protected int mBlackCount;

  /**
   * Creates a sequence derived from the cellular automaton with the given rule
   * and seed 1 (a single ON/BLACK cell).
   * @param rule rule number for this automaton (0-1023).
   */
  public FiveNeighbor2DAutomaton(final int rule) {
    mGen = 0;
    mRule = rule;
    sDebug = 0;
    mSum = Z.ZERO;
    mBlackCount = 1;
    mN = -1;
    add(Z.ONE); // set origin to black
  }

  /**
   * Set the debugging level.
   * @param level code for the debugging level: 0 = none, 1 = some, 2 = more.
   */
  public static void setDebug(final int level) {
    sDebug = level;
  }

  /**
   * Compute the new sqaure of the next generation from the old square.
   */
  public void computeNext() {
  	// ++mGen;
  }

  /**
   * Reverse the bits in a number.
   * The rightmost bit becomes the leftmost bit in a field of a specified length.
   * Any remaining space is filled with zeros.
   * @param num number
   * @parmm width bit field length
   * @return reversed number
   */
  public static Z reverse2(final Z num, final int width) {
    final int last = width - 1;
    Z result = Z.ZERO;
    for (int bpos = 0; bpos <= last; ++bpos) {
      if (num.testBit(bpos)) {
        result = result.setBit(last - bpos);
      }
    }
    return result;
  }

  /**
   * Get the next term of the sequence.
   * Cf. interface {@link Sequence}.
   * The implementation here is not used.
   * Instead, the <code>next()</code> method of the subclasses calls one of the other <code>next*()</code> methods here.
   * @return the next term.
   */
  @Override
  public Z next() {
    return Z.ZERO;
  }

  /**
   * Get the total number of black cells in the next generation.
   * @return
   */
  public Z nextOn() {
    long org = get(0).testBit(0) ? 1 : 0;
    long lsum = 0L; // left border of the triangle
    long rsum = 0L; // right border
    long tsum = 0L; // whole triangle
    for (int irow = size() - 1; irow >= 0; --irow) {
      final Z row = get(irow);
      if (row.testBit(mGen)) {
        ++lsum;
      }
      if (row.testBit(0)) {
        ++rsum;
      }
      tsum += tsum + row.bitCount();
    }
    tsum = tsum - lsum - rsum + org; // org was counted twice (in lsum and rsum); now we have the count of the inner triangle
    tsum = 8 * tsum + 4 * lsum + 4 * rsum - 7 * org;
    computeNext();
    return Z.valueOf(tsum);
  }

  /**
   * Get the total number of black cells in the next generation with number 2^n - 1
   * @return 0 or 1
   */
  public Z nextOn2n_1() {
    ++mN;
    while (Integer.bitCount(mN + 1) != 1) {
      ++mN;
    }
    return nextOn();
  }

  /**
   * Get the number whose bits represent the row segment from the left border to the origin.
   * The binary number is represented by decimal digits 0 and 1.
   * @return a number with bits set for black cells
   */
  public Z nextLeftOriginB() {
    return mSum;
  }

  /**
   * Get the number whose bits represent the row segment from the origin to the right border.
   * The binary number is represented by decimal digits 0 and 1.
   * @return a number with bits set for black cells
   */
  public Z nextOriginRightB() {
    return mSum;
  }

  /**
   * Get the number whose bits represent the row segment from a corner to the origin.
   * The binary number is represented by decimal digits 0 and 1.
   * @return a number with bits set for black cells
   */
  public Z nextCornerOriginB() {
    return mSum;
  }

  /**
   * Get the number whose bits represent the row segment from the origin to a corner.
   * The binary number is represented by decimal digits 0 and 1.
   * @return a number with bits set for black cells
   */
  public Z nextOriginCornerB() {
    return mSum;
  }

  /**
   * Get the number whose bits represent the row segment from the left border to the origin.
   * @return a number with bits set for black cells
   */
  public Z nextLeftOriginD() {
    return mSum;
  }

  /**
   * Get the number whose bits represent the row segment from the origin to the right border.
   * @return a number with bits set for black cells
   */
  public Z nextOriginRightD() {
    return mSum;
  }

  /**
   * Get the number whose bits represent the row segment from a corner to the origin.
   * @return a number with bits set for black cells
   */
  public Z nextCornerOriginD() {
    return mSum;
  }

  /**
   * Get the number whose bits represent the row segment from the origin to a corner.
   * @return a number with bits set for black cells
   */
  public Z nextOriginCornerD() {
    return mSum;
  }

  /**
   * Displays the old row by using "1" and "." for 0 bits, and " " outside the triangle.
   * @param width total width of the generated line
   * @param mode 2 = binary as decimal, block display otherwise
   */
  public void displaySquare(final int width, final int mode) {
    final StringBuilder sb = new StringBuilder(width);
    System.out.println(String.format("%3d: %" + String.valueOf(width / 2 - mGen) + "s", mGen, " ")
        + (mBackground == 0 ? "-" : "+") + sb.toString() + (mBackground == 0 ? "-" : "+"));
  }

  /**
   * Main method for debugging.
   * @param args command line arguments:
   * <ul>
   * <li>-b  print in b-file format instead of comma separated list</li>
   * <li>-d  level debugging level (default 0=none, 1=some, 2=more)</li>
   * <li>-r  rule number</li>
   * <li>-n  numTerms number of terms to be computed (default: 16)</li>
   * <li>-cc callcode</li>
   * </ul>
   */
  public static void main(String[] args) {
    boolean bfile = false;
    String callCode = "rows";
    int debug    = 0;
    int mode     = 1;
    int numTerms = 32;
    int ruleNo   = 30;
    int iarg = 0;
    while (iarg < args.length) { // consume all arguments
      String opt = args[iarg ++];
      try {
        if (false) {
        } else if (opt.equals    ("-b")     ) {
          bfile    = true;
        } else if (opt.equals    ("-cc")     ) {
          callCode = args[iarg ++];
        } else if (opt.equals    ("-d")     ) {
          debug    = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-m")     ) {
          mode     = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-n")     ) {
          numTerms = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-r")     ) {
          ruleNo   = Integer.parseInt(args[iarg ++]);
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args

    FiveNeighbor2DAutomaton ca = new FiveNeighbor2DAutomaton(ruleNo);
    ca.setDebug(debug);
    if (false) {
    } else if (callCode.equals("bfile")){
      for (int gen = 0; gen < numTerms; ++gen) {
        ca.mGen = gen;
        System.out.println(gen + " " );
        ca.computeNext();
      }
    } else if (callCode.equals("rows")){
      for (int gen = 0; gen < numTerms; ++gen) {
        ca.displaySquare(2 * numTerms + 4, mode);
        ca.computeNext();
      }
     } else if (callCode.equals("next")){
      for (int n = 0; n < numTerms; ++n) {
        if (bfile) {
          System.out.println(n + " " + ca.next());
        } else {
          System.out.print((n == 0 ? "" : ",") + ca.next());
        }
      }
    } else {
      System.err.println("??? invalid callCode: \"" + callCode + "\"");
    }
  } // main

}
