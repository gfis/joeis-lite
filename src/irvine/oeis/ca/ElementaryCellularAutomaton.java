package irvine.oeis.ca;

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
  protected final static int BLOCK_LEN = 8;
  /** Allocate rows in multiples of this number */
  protected final static int CHUNK_SIZE = 64;
  /** Rule number 0..255, cf. ANKOS p. 53 */
  protected int mRule;
  /**
   * Number of the generation; <code>mGen</code> = 0 starts with a single BLACK cell
   * in the lowest bit position of <code>mOldRow[mCenter]</code>
   */
  protected int mGen;
  /** Type of the resulting sequence */
  protected String mCode; 

  /** Debugging mode: 0=none, 1=some, 2=more. */
  protected int mDebug;
  /** Buffer for the bits of generation n */
  protected int[] mOldRow;
  /** Buffer for the bits of generation n+1 */
  protected int[] mNewRow;
  /** Length of the two rows. */
  protected int mRowLen; //
  /** Index of the block that has the center of the triangle in its lowest bit position */
  protected int mCenter; //

  /**
   * Creates a new cellular automaton for the given rule.
   * @param rule rule number for this automaton (0-255).
   */
  public ElementaryCellularAutomaton(final int rule) {
    this(rule, "ca1triangle");
  }

  /**
   * Creates a sequence derived from the cellular automaton with the given rule.
   * @param rule rule number for this automaton (0-255).
   * @param code a String specifying the type of the sequence
   */
  public ElementaryCellularAutomaton(final int rule, final String code) {
    mGen = 0;
    mRule = rule;
    mCode = code;
    mDebug = 0;
    mRowLen = CHUNK_SIZE;
    mOldRow = new int[mRowLen]; // preset to zeroes
    mNewRow = new int[mRowLen];
    mCenter = mRowLen / 2 - 1; // this is the contract; left half in 0..31, right half in 32..63
  }

  /**
   * Expands both rows by <code>CHUNK_SIZE</code>,
   * shifts the contents of the old row up, and re-adjusts the center.
   * This method is called only when the odl row is completely filled.
   */
  public void expandRows() {
    final int newLen = mRowLen + CHUNK_SIZE;
    mNewRow = new int[newLen];
    System.arraycopy(mOldRow, 0, mNewRow, CHUNK_SIZE / 2, mRowLen); // first from [0..63] to [32..95]
    mRowLen = newLen;
    mOldRow = mNewRow; // exchange both rows
    mNewRow = new int[newLen];
    mCenter = mRowLen / 2 - 1; // contract
  }

   /**
   * Displays the old row by using "1" and "." for 0 bits, and " " outside the triangle.
   * @param gen generation number starting with 0 for one black cell.
   * @param width total width of the generated line; must be a multiple of <code>BLOCK_LEN</code> (and of 2).
   */
  public void displayRow(final int gen, final int width) {
    final int wb2 = width / BLOCK_LEN / 2;
    final StringBuilder sb = new StringBuilder(width);
    sb.append(' '); // anchor for replacements below
    for (int irow = mCenter - wb2; irow <= mCenter + wb2; ++irow) {
      sb.append(String.format("%" + BLOCK_LEN + "s", Integer.toBinaryString(mOldRow[irow])));
    }
    final String result = sb.toString()
        .replaceAll("[ 0]",".") 
        .replaceAll(" .", "  ") // replace leading dots by spaces
        .replaceAll(".+\\Z", ""); // replace trailing dots by spaces
    System.out.println(result.toString());
  }

  /**
   * Compute the next generation for a block (an array of cells).
   * @param oldBlock some number of cells, highest bit is leftmost cell.
   * @param higherBit the bit to the left of the old block
   * @param lowerBit the bit to the right of the old block
   * @result the new block
   */
  protected int computeNextBlock(final int oldBlock, final int higherBit, final int lowerBit) {
    int block = (oldBlock << 1) | lowerBit | (higherBit << (BLOCK_LEN + 2)); // attach boundary bits at both ends
/*
    if (mDebug > 0) {
      System.out.println("block=0b" + Integer.toBinaryString(block));
    }
*/
    int newBlock = 0;
    int itar = 0; // fill to BLOCK_LEN
    for (int isrc = 0; isrc < BLOCK_LEN; ++isrc) { // from left to right
      final int src3 = block & 7; // 3 bits, 0..7
      block >>= 1;
      final int tarBit = ((mRule & (1 << src3)) != 0) ? 1 : 0;
      newBlock |= tarBit << itar;
/*
      if (mDebug > 0) {
        System.out.println("isrc=" + isrc
            + ", itar="      + itar
            + ", block=0b"    + Integer.toBinaryString(block)
            + ", tarBit=0b"  + Integer.toBinaryString(tarBit)
            + ", newBlock=0b" + Integer.toBinaryString(newBlock)
            );
      }
*/
      ++itar;
    }
    return newBlock;
  }

  /**
   * Set the debugging level.
   * @param level code for the debugging level: 0 = none, 1 = some, 2 = more.
   */
  public void setDebug(final int level) {
    mDebug = level;
  }

  @Override
  public Z next() {
    return Z.ZERO;
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
    int numTerms = 16;
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
    ElementaryCellularAutomaton ca = new ElementaryCellularAutomaton(ruleNo, callCode);
    ca.setDebug(debug);
    if (false) {
    } else if (callCode.equals("block")){
      int block = 0x010;
      for (int gen = 0; gen < 16; ++gen) {
        System.out.println(Integer.toBinaryString(block));
        block = ca.computeNextBlock(block, 0, 0);
      }
    } else if (callCode.equals("row")){
      int block = 0x010;
      ca.mOldRow[ca.mCenter] = block;
      for (int gen = 0; gen < 16; ++gen) {
        ca.displayRow(gen, ca.CHUNK_SIZE);
        ca.mOldRow[ca.mCenter] = ca.computeNextBlock(ca.mOldRow[ca.mCenter], 0, 0);
      }
    } else {
      System.err.println("??? invalid callCode: \"" + callCode + "\"");
    }
  } // main

}
