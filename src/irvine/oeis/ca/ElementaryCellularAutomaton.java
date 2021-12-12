package irvine.oeis.ca;

import java.util.Iterator;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * Data structure and methods for the evaluation of an elementary, one-dimensional cellular automaton
 * with a fixed rule number between 0 and 255,
 * as described by Stephen Wolfram in the book "A New Kind Of Science" (ANKOS).
 * The computation of new generations proceeds in so-called <em>blocks</e>, that are bit arrays of size <code>BLOCK_LEN</code>,
 * stored in integer arrays.
 * For each new generation, the automaton scans over the row with the old blocks, and computes
 * the new row of new blocks. Thereafter, both rows are exchanged,
 * The rows grow by one bit on each side. If the arrays become too small, they are expanded.
 * @author Georg Fischer
 */
public class ElementaryCellularAutomaton implements Sequence {

  /** The length of the blocks that are computed respectively retrieved from the table. */
  protected final static int BLOCK_LEN = 24;
  /** The mask for the highest bit in a block. */
  protected int mHighMask;
  /** The mask for the lowest bit in a block. */
  protected int mLowMask;
  /** Allocate rows in multiples of this number */
  protected final static int CHUNK_SIZE = 256;
  /** Rule number 0..255, cf. ANKOS p. 53 */
  protected int mRule;
  /**
   * Number of the generation; <code>mGen</code> = 0 starts with a single BLACK cell
   * in the lowest bit position of <code>mOldRow[mCenter]</code>
   */
  protected int mGen;
  /** Type of the resulting sequence */
  protected String mCode;
  /** Output mode: 1=decimal, 2=binary, 3=other */
  protected int mMode;

  /** Debugging mode: 0=none, 1=some, 2=more. */
  protected static int sDebug;
  /** Buffer for the bits of generation n */
  protected int[] mOldRow;
  /** Buffer for the bits of generation n+1 */
  protected int[] mNewRow;
  /** Old block to be processed */
  protected int mOldBlock;
  /** Length of the two rows. */
  protected int mRowLen; //
  /** Index of the block that has the center of the triangle in its lowest bit position */
  protected int mCenter; //

  /** Current cell number in the triangle, see {@link #next}. */
  protected int mN; //
  /** Iterator for current row */
  protected RowIterator mIter;
  /** Summation term for several subtypes of sequences */
  protected Z mSum;
  /** Count of BLACK/ON cells in current row */
  protected int mBlackCount;

  /**
   * Creates a new cellular automaton for the given rule.
   * @param rule rule number for this automaton (0-255).
   */
  public ElementaryCellularAutomaton(final int rule) {
    this(rule, "ca1triangle", 2);
  }

  /**
   * Creates a sequence derived from the cellular automaton with the given rule.
   * @param rule rule number for this automaton (0-255).
   * @param code a String specifying the type of the sequence
   * @param mode output mode: 1 = decimal, 2=binary, 3=other
   */
  public ElementaryCellularAutomaton(final int rule, final String code, final int mode) {
    mLowMask = 1;
    mHighMask = mLowMask << (BLOCK_LEN - 1);
    mGen = 0;
    mRule = rule;
    mCode = code;
    mMode = mode;
    sDebug = 0;
    mRowLen = CHUNK_SIZE;
    mOldRow = new int[mRowLen]; // preset to zeroes
    mNewRow = new int[mRowLen];
    mCenter = mRowLen / 2 - 1; // this is the contract; left half in 0..31, right half in 32..63
    mOldRow[mCenter] = 1; // start with a single BLACK/ON cell
    mN = -1;
    mSum = Z.ZERO;
    mBlackCount = 1;
  }

  /**
   * Iterator over all cells in a row of the triangle.
   * The iterator scans over {@link #mOldRow} and returns bit positions,
   * while it maintains the current block {@link #mOldBlock}.
   * The iterator also extends the rows if necessary
   */
  protected class RowIterator implements Iterator<Integer> {
    protected int index;
    protected int bitPos;
    protected int count;
    protected int endCount;

    /**
     * Construct the iterator with no rewrite.
     * Initialize <code>mOldBlock</code>, and the starting and ending indices and bit positions.
     */
    protected RowIterator() {
      count = 0;
      endCount = 2 * mGen + 1;
      index = mCenter - (mGen / BLOCK_LEN);
      if (index <= 2) {
        expandRows();
        index = mCenter - (mGen / BLOCK_LEN);
      }
      final int bpos = mGen % BLOCK_LEN;
      mOldBlock = mOldRow[index];
      bitPos = bpos;
      if (sDebug > 0) {
        System.out.println("# new RowIterator()"
            + ", mGen="      + mGen
            + ", index="     + index
            + ", mOldBlock=" + Integer.toBinaryString(mOldBlock)
            + ", bitPos="    + bitPos
            + ", count="     + count
            + ", endCount="  + endCount
            );
      }
    }

    /**
     * Test whether there is a next cell in the row.
     * @return true (false) if there is (no) next cell.
     */
    public boolean hasNext() {
      return count < endCount;
    }

    /**
     * Gets the bit position of the next cell in <code>mOldBlock</code>.
     * @return a position between 0 and BLOCK_LEN - 1.
     */
    public Integer next() {
      if (bitPos < 0) {
        ++index;
        mOldBlock = mOldRow[index];
        bitPos = BLOCK_LEN - 1;
      }
      final int result = bitPos;
      --bitPos;
      ++count;
      return result;
    }

    /**
     * Expands both rows by <code>CHUNK_SIZE</code>,
     * shifts the contents of the old row up, and re-adjusts the center.
     * This method is called only when the odl row is completely filled.
     */
    private void expandRows() {
      final int newLen = mRowLen + CHUNK_SIZE;
      mNewRow = new int[newLen];
      System.arraycopy(mOldRow, 0, mNewRow, CHUNK_SIZE / 2, mRowLen); // first from [0..63] to [32..95]
      mRowLen = newLen;
      mOldRow = mNewRow; // exchange both rows
      mNewRow = new int[newLen];
      mCenter = mRowLen / 2 - 1; // contract
    }

    /**
     * Gets the current index
     * @return <code>mOldRow[index]</code>}.
     */
    protected int getIndex() {
      return index;
    }

    /**
     * Gets the number of cells in the row, + 1
     * @return <code>endCount</code>}.
     */
    protected int getEndCount() {
      return endCount;
    }

    /**
     * Gets the current bit position
     * @return <code>bitPos</code>}.
     */
    protected int getBitPosition() {
      return bitPos;
    }

  }

  /**
   * Displays the old row by using "1" and "." for 0 bits, and " " outside the triangle.
   * @param gen generation number starting with 0 for one black cell.
   * @param width total width of the generated line; must be a multiple of <code>BLOCK_LEN</code> (and of 2).
   */
  public void displayRow(final int gen, final int width) {
    final StringBuilder sb = new StringBuilder(width);
    final RowIterator riter = new RowIterator();
    while (riter.hasNext()) {
      final int bitPos = riter.next();
      if (mMode != 2) {
        sb.append(((mOldBlock & (1 << bitPos)) == 0) ? '\u2588' : '\u2591');
      } else {
        sb.append(((mOldBlock & (1 << bitPos)) == 0) ? '0' : '1');
      }
    }
    System.out.println(String.format("%3d: %" + String.valueOf(width / 2 - gen) + "s", gen, " ") + sb.toString());
  }

  /**
   * Returns the current row as a String of binary digits.
   * @return "11001" for example.
   */
  public String toBinaryString() {
    final StringBuilder sb = new StringBuilder(1024);
    final RowIterator riter = new RowIterator();
    while (riter.hasNext()) {
      final int bitPos = riter.next();
      sb.append(((mOldBlock & (1 << bitPos)) == 0) ? '0' : '1');
    }
    return sb.toString();
  }

  /**
   * Compute the next generation for a block (an array of cells).
   * @param oldBlock some number of cells, highest bit is leftmost cell.
   * @param leftBit the bit to the left of the old block
   * @param rightBit the bit to the right of the old block
   * @result the new block
   */
  protected int transformBlock(final int oldBlock, final int leftBit, final int rightBit) {
    int wrappedBlock = ((oldBlock | (leftBit << BLOCK_LEN)) << 1) | rightBit; // attach boundary bits at both ends
    int newBlock = 0;
    int itar = 0; // fill to BLOCK_LEN - 1
    for (int isrc = 0; isrc < BLOCK_LEN; ++isrc) { // from left to right
      final int key3 = wrappedBlock & 7; // lowest 3 bits, values 0..7
      final int tarBit = ((mRule & (1 << key3)) != 0) ? 1 : 0;
      mBlackCount += tarBit;
      newBlock |= (tarBit << itar);
/*
      if (sDebug >= 2) {
        System.out.println("#     transformBlock("
            + Integer.toBinaryString(oldBlock)
            + ", " + Integer.toBinaryString(leftBit)
            + ", " + Integer.toBinaryString(rightBit) + ")"
            + ", isrc="         + isrc
            + ", itar="         + itar
            + ", wrappedBlock=" + Integer.toBinaryString(wrappedBlock)
            + ", tarBit="       + Integer.toBinaryString(tarBit)
            + ", newBlock="     + Integer.toBinaryString(newBlock)
            );
      }
*/
      wrappedBlock >>= 1;
      ++itar;
    }
/*
    if (sDebug >= 1) {
        System.out.println("#   transformBlock("
            + Integer.toBinaryString(oldBlock)
            + ", " + Integer.toBinaryString(leftBit)
            + ", " + Integer.toBinaryString(rightBit) + ")"
            + ", newBlock=" + Integer.toBinaryString(newBlock)
            );
    }
*/
    return newBlock;
  }

  /**
   * Computes the new row of the next generation from the old row.
   */
  public void computeNextRow() {
    ++mGen;
    mBlackCount = 0;
    final RowIterator riter = new RowIterator(); // just to determine the indices at both ends
    final int start = riter.getIndex();
    final int bpos = riter.getBitPosition();
    final int last = mCenter + (mGen - 1) / BLOCK_LEN + 1;
    if (sDebug >= 1) {
        System.out.println("# computeNextRow.start"
            + ", start="     + start
            + ", bpos="      + bpos
            + ", last="      + last
            + ", mLowMask="  + Integer.toBinaryString(mLowMask)
            + ", mHighMask=" + Integer.toBinaryString(mHighMask)
            );
    }
    for (int icol = start; icol <= last; ++icol) {
      final int leftBit =   mOldRow[icol - 1] & mLowMask;
      final int rightBit = (mOldRow[icol + 1] & mHighMask) >> (BLOCK_LEN - 1);
      int mNewBlock = transformBlock(mOldRow[icol], leftBit, rightBit);
      if (sDebug >= 1) {
          System.out.println("# computeNextRow.loop"
              + ", icol="      + icol
              + ", oldBlock="  + Integer.toBinaryString(mOldRow[icol])
              + ", leftBit="   + Integer.toBinaryString(leftBit)
              + ", rightBit="  + Integer.toBinaryString(rightBit)
              + "# -> mNewBlock=" + Integer.toBinaryString(mNewBlock)
              );
      }
/*
*/
      mNewRow[icol] = mNewBlock;
    }
    mOldRow = mNewRow;
    final int maskLeft  = (1 << (bpos + 1)) - 1;
    final int maskRight = bpos == 0
        ? (1 << BLOCK_LEN) - 1
        : ((1 << bpos) - 1) << (BLOCK_LEN - bpos);
    mOldRow[start] &= maskLeft; // clear left garbage
    mOldRow[last] &= maskRight; // clear right garbage
    mOldRow[last + 1] = 0; // for safety

    if (sDebug >= 2) {
        System.out.println("# computeNextRow.end"
            + ", maskLeft="                + Integer.toBinaryString(maskLeft)
            + ", maskRight="               + Integer.toBinaryString(maskRight)
            + ", mOldRow[" + start + "]="  + Integer.toBinaryString(mOldRow[start])
            + ", mOldRow[" + last  + "]="  + Integer.toBinaryString(mOldRow[last])
            );
    }
    mNewRow = new int[mRowLen];
  }

  /**
   * Set the debugging level.
   * @param level code for the debugging level: 0 = none, 1 = some, 2 = more.
   */
  public static void setDebug(final int level) {
    sDebug = level;
  }

  /**
   * Gets the next term of the sequence.
   * The default implementation here yields the single cell values of the triangle row by row.
   * Cf. interface {@link Segment}.
   * @return 0 or 1
   */
  @Override
  public Z next() {
    ++mN;
    if (mN == 0) {
      mIter = new RowIterator();
    }
    if (! mIter.hasNext()) {
      computeNextRow();
      mIter = new RowIterator();
    }
    final int bpos = mIter.next();
    return ((mOldBlock & (1 << bpos)) == 0) ? Z.ZERO : Z.ONE;
  }

  /**
   * Gets the next row as a binary number represented by decimal digits.
   * @return 11001 for generation 2 of rule 30.
   */
  public Z nextStageB() {
    ++mN;
    mSum = new Z(toBinaryString(), 10); // read it as decimal
    computeNextRow();
    return mSum;
  }

  /**
   * Gets the next row as a decimal number.
   * @return 25 for generation 2 of rule 30.
   */
  public Z nextStageD() {
    ++mN;
    mSum = new Z(toBinaryString(), 2); // read it as binary
    computeNextRow();
    return mSum;
  }

  /**
   * Gets the cell in the middle of the next row.
   * @return 0 for generation 2 of rule 30.
   */
  public Z nextMiddle() {
    ++mN;
    mSum = Z.valueOf(mOldRow[mCenter] & 1);
    computeNextRow();
    return mSum;
  }

  /**
   * Gets the center column of the triangle up to generation n as a binary number represented by decimal digits.
   * @return 110 for generation 2 of rule 30.
   */
  public Z nextMiddleB() {
    ++mN;
    mSum = mSum.multiply(10).add(mOldRow[mCenter] & 1);
    computeNextRow();
    return mSum;
  }

  /**
   * Gets the center column of the triangle up to generation n as a decimal number.
   * @return 6 for generation 2 of rule 30.
   */
  public Z nextMiddleD() {
    ++mN;
    mSum = mSum.shiftLeft(1).add(mOldRow[mCenter] & 1);
    computeNextRow();
    return mSum;
  }

  /**
   * Gets the number of ON/BLACK cells in the current row.
   * @return 3 for generation 2 of rule 30 (11001).
   */
  public int getBlackCount() {
    final RowIterator riter = new RowIterator(); // just to determine the indices at both ends
    final int last = mCenter + (mGen - 1) / BLOCK_LEN + 1;
    int count = 0;
    for (int irow = riter.getIndex(); irow <= last; ++irow) {
      count += Integer.bitCount(mOldRow[irow]);
    }
    return count;
  }

  /**
   * Gets the number of ON/BLACK cells in the row.
   * @return 3 for generation 2 of rule 30 (11001).
   */
  public Z nextBlackCount() {
    ++mN;
    mSum = Z.valueOf(getBlackCount());
    computeNextRow();
    return mSum;
  }

  /**
   * Gets the partial sum of ON/BLACK cells up to row n.
   * @return 7 for generation 2 of rule 30 (1, 111, 11001).
   */
  public Z nextBlackSum() {
    ++mN;
    mSum = mSum.add(getBlackCount());
    computeNextRow();
    return mSum;
  }

  /**
   * Gets the number of OFF/WHITE cells in the current row.
   * @return 2 for generation 2 of rule 30 (11001).
   */
  public Z nextWhiteCount() {
    ++mN;
    mSum = Z.valueOf(2 * mGen + 1).subtract(getBlackCount());
    computeNextRow();
    return mSum;
  }

  /**
   * Gets the partial sum of OFF/WHITE cells up to row n.
   * @return 2 for generation 2 of rule 30 (1, 111, 11001).
   */
  public Z nextWhiteSum() {
    ++mN;
    mSum = mSum.add(Z.valueOf(2 * mGen + 1).subtract(getBlackCount()));
    computeNextRow();
    return mSum;
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
    String callCode = "ca1triangle";
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

    ElementaryCellularAutomaton.setDebug(debug);
    ElementaryCellularAutomaton ca = new ElementaryCellularAutomaton(ruleNo, callCode, mode);
    ca.setDebug(debug);
    if (false) {
    } else if (callCode.equals("bfile")){
      for (int gen = 0; gen < numTerms; ++gen) {
        ca.mGen = gen;
        System.out.println(gen + " " + ca.toBinaryString());
        ca.computeNextRow();
      }
    } else if (callCode.equals("block")){
      int block = 0x010;
      for (int gen = 0; gen < numTerms; ++gen) {
        System.out.println(Integer.toBinaryString(block));
        block = ca.transformBlock(block, 0, 0);
      }
    } else if (callCode.equals("rows")){
      for (int gen = 0; gen < numTerms; ++gen) {
        ca.mGen = gen;
        ca.displayRow(ca.mGen, 2 * numTerms + 2);
        ca.computeNextRow();
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
