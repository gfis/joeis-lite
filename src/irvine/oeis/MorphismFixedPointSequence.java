package irvine.oeis;

import irvine.math.z.Z;

/**
 * Second, alternate attempt, first version was MorphismSequence.
 * Scan a word from left to right, replace the possible patterns, repeat and
 * assume that the beginning of the word becomes steady.
 * An example is:
 * <pre>
 * A171588 The Pell word: Fixed point of the morphism 0-&gt;001, 1-&gt;0.
 * S(0) = 0
 * S(1) = 001
 * S(2) = 001 001 0
 * S(3) = 0010010 0010010 001
 * S(4) = 00100100010010001 00100100010010001 0010010.
 * </pre>
 * @author Georg Fischer
 */
public class MorphismFixedPointSequence implements Sequence {

  private static final int POS_FRACTION = 4; // 1 / (how much of mCurWord is reliable)
  protected String mStart; // the starting word
  protected String mAnchor; // start of the desired limiting word, or triangle of words if empty
  protected boolean mIsAnchored; // whether mAnchor is empty
  protected int mFactor; // each iterate increases the length roughly by this factor

  protected String mCurWord; // current word expanded so far
  protected String[] mMap; // pairs of String->String, flattened
  protected int mPos; // current position in mCurWord
  protected int mMaxPos; // assume that digits are safe up to this position
  protected int mDebug = 0; // 0 = none, 1 = some, 2 = more debugging output

  /**
   * Empty constructor, 
   * used for variations where {@link #initialize} is not appropriate.
   */
  protected MorphismFixedPointSequence() {
  } // Constructor

  /**
   * Construct an instance which generates the fixed point of this morphism.
   * @param anchor start of the desired limiting word, or triangle of words if empty
   * @param start start with this word
   * @param mappings pairs of digit string mappings, for example "0-&gt;001,1-&gt;0"
   */
  protected MorphismFixedPointSequence(final String start, final String anchor, final String mappings) {
    configure(start, anchor, mappings);
    initialize();
  } // Constructor

  /**
   * Construct an instance which generates the fixed point of this morphism.
   * @param anchor start of the desired limiting word, or triangle of words if empty
   * @param start start with this word
   * @param mappings pairs of digit string mappings, for example "0-&gt;001,1-&gt;0"
   */
  protected void configure(final String start, final String anchor, final String mappings) {
    mFactor = 2;
    final String[] pairs = mappings.replaceAll(" ", "").split("\\,"); // remove spaces inserted by gen_seq4.pl
    mMap = new String[pairs.length * 2];
    int imap = 0;
    for (final String pair1 : pairs) {
      String[] pair = pair1.split("\\-\\>");
      if (pair.length == 1) {
        pair = new String[]{pair[0], ""};
      } else if (pair1.startsWith("->")) {
        pair = new String[]{"", pair[0]};
      }
      mMap[imap++] = pair[0];
      mMap[imap++] = pair[1];
    } // for pair1
    mStart = start;
    mCurWord = mStart;
    mAnchor = anchor;
    mIsAnchored = mAnchor.length() == 0;
    mPos = 0;
  } // configure
  
  /**
   * Expand a few times to have a safe start for the sequence
   */
  protected void initialize() {
    expandWord();
    expandWord();
    // final String[] iterates = new String[512];
    int iexp = 4;
    while (mCurWord.length() < 8192 || !mCurWord.startsWith(mAnchor)) { // expand a few times
      expandWord();
      ++iexp;
    } // while iexp
/*
    iterates[iexp] = mCurWord;
    final String oldWord = iterates[iexp - 1];
    mAnchor = mCurWord.substring(0, 2);
    if (!mAnchor.equals(oldWord.substring(0, 2))) {
      mAnchor = anchor.length() == 0 ? mStart : anchor;
      //oldWord = mStart; // = iterates[0];
    }
*/
    mMaxPos = mCurWord.length() / POS_FRACTION;
  } // initialize

  /**
   * Expand the current word by applying the mapping rules from left to right.
   */
  public void expandWord() {
    final StringBuilder newWord = new StringBuilder(mPos * mFactor);
    int ipos = 0;
    while (ipos < mCurWord.length()) {
      int imap = 0;
      boolean busy = true;
      while (busy && imap < mMap.length) {
        final String search = mMap[imap++];
        final String replace = mMap[imap++];
        if (mCurWord.startsWith(search, ipos)) {
          newWord.append(replace);
          ipos += search.length();
          busy = false;
        }
      } // while imap
      if (busy) { // no mapping could be applied
        newWord.append(mCurWord.charAt(ipos++)); // copy character unchanged
      }
    } // while ipos
    mCurWord = newWord.toString();
    mMaxPos = mCurWord.length() / POS_FRACTION;
/*
    if (mDebug > 0) {
      final int len = mCurWord.length();
      System.out.println("# anchor=" + mAnchor
        + " pos=" + String.format("%4d", mPos)
        + " max=" + String.format("%4d", mMaxPos)
        + " " + (len < 96 ? mCurWord : mCurWord.substring(0, 96) + " ..."));
    }
*/
    if (mCurWord.length() > 10000000) {
      throw new IllegalArgumentException("mCurWord longer than 10^7 characters");
    }
  } // expandWord

  /**
   * Get the next term of the sequence.
   * @return the next term
   */
  @Override
  public Z next() {
    if (mPos >= mMaxPos) {
      int iexp = 4;
      while (iexp > 0) { // expand to next possible
        expandWord();
        if (mCurWord.startsWith(mAnchor)) {
          iexp = 0;
        }
        iexp--;
      } // while expanding
      // iexp = -1 if some next was possible
      if (iexp == 0 && mDebug > 0) { // not possible
        System.err.println("assertion iexp in MorphismFixedPointSequence.next, pos = " + mPos
          + ", word = \"" + mCurWord + "\"");
      }
      if (mPos >= mMaxPos && mDebug > 0) {
        System.err.println("assertion maxPos in MorphismFixedPointSequence.next, maxPos = " + mMaxPos
          + ", word = \"" + mCurWord + "\"");
      }
    }
    // take next from current word
    final char ch = mCurWord.charAt(mPos++);
    return ch == 'M' ? Z.NEG_ONE : Z.valueOf(ch - '0');
  } // next

  //=====================================

  /**
   * Test method
   * @param args command line arguments: 
   * <ul>
   * <li>-d debugging mode: 0=none (default), 1=some, 2=more</li>
   * <li>-n number of terms, default 32</li>
   * <li>-s start, default "0"</li>
   * <li>-l anchor, default "0010"</li>
   * <li>-m mappings, default "0->001,1->0"</li>
   * </ul>
   */
  public static void main(final String[] args) {
    int noTerms = 32;
    int debug = 0;
    String start = "0";
    String anchor = "0010";
    String mappings = "0->001,1->0"; // A171588
    int iarg = 0;
    while (iarg < args.length) {
      final String opt = args[iarg++];
      try {
        if (false) {
        } else if (opt.equals("-d")) {
          debug = Integer.parseInt(args[iarg++]);
        } else if (opt.equals("-l")) {
          anchor = args[iarg++];
        } else if (opt.equals("-m")) {
          mappings = args[iarg++];
        } else if (opt.equals("-n")) {
          noTerms = Integer.parseInt(args[iarg++]);
        } else if (opt.equals("-s")) {
          start = args[iarg++];
        } else {
          System.err.println("invalid option " + opt);
        }
      } catch (final NumberFormatException exc) {
        // ignored
      }
    }
    final MorphismFixedPointSequence seq = new MorphismFixedPointSequence(start, anchor, mappings);
    seq.mDebug = debug; /// last 2 bits
    int index = 1;
    while (index < noTerms) {
      System.out.println(index + " " + seq.next());
      ++index;
    } // while index
  } // main
} // MorphismFixedPointSequence
