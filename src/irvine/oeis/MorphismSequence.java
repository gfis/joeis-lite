package irvine.oeis;

import irvine.math.z.Z;
/**
 * A typical example for these sequences is:
 * <pre>
 * A171588 The Pell word: Fixed point of the morphism 0->001, 1->0.
 * S(0) = 0
 * S(1) = 001
 * S(2) = 001 001 0
 * S(3) = 0010010 0010010 001
 * S(4) = 00100100010010001 00100100010010001 0010010.
 * </pre>
 * @author Georg Fischer
 */
public class MorphismSequence implements Sequence {

  protected int mN; // index of current term to be returned
  protected Z mK; // current number with some property
  protected int mOffset; // OEIS offset1 as of generation time
  protected String mStart; // the starting word
  protected String mLimit; // start of the desired limiting word
  protected String mFixPoint; // start of the fixed point 

  private String mOldWord; // current word expanded so far
  private StringBuffer mNewWord; // assemble the new word here
  private String[] mMap; // pairs of String->String, flattened
  private int mPos; // current position in mOldWord
  public  int mDebug = 0; // 0 = none, 1 = some, 2 = more debugging putput
  /**
   * Construct an instance which generates the fixed point of this morphism.
   * @param offset first valid term has this index
   * @param start start with this word
   * @param limit start of the desired limiting word
   * @param mappings pairs of digit string mappings, for example "0->001,1->0"
   */
  protected MorphismSequence(final int offset, final String start, final String limit, final String mappings) {
    mOffset = offset;
    mLimit  = limit;
    mStart  = start;
    mN = 0;
    mK = Z.ZERO;
    String[] pairs = mappings.replaceAll(" +", "").split("\\,");
    mMap = new String[2 * pairs.length];
    int imap = 0;
    for (int ipair = 0; ipair < pairs.length; ipair ++) {
        String[] pair = pairs[ipair].split("\\-\\>");
        mMap[imap ++] = pair[0];
        mMap[imap ++] = pair[1];
    } // for ipair
    mOldWord = mStart;
    mFixPoint = null;
    int iexp = 0; 
    while (iexp < 4 && mOldWord.length() < 1024) { // expand a few times
        expandWord();
        if (mOldWord.startsWith(mStart)) {
          mFixPoint = mOldWord; // starts properly
        }   
        iexp ++;
    } // while iexp
    if (mFixPoint == null) { // no iterate >#1 started with mStart
      mFixPoint = mOldWord;
    } else if (! mOldWord.startsWith(mStart)){ // maybe mOldWord now does not start properly 
      mOldWord = mFixPoint;
    }
    mPos = 0;
  } // Constructor

  /**
   * Expand the current word by applying the mapping rules from left to right.
   */
  public void expandWord() {
    StringBuffer mNewWord = new StringBuffer(mPos * 2);
    int ipos = 0;
    while (ipos < mOldWord.length()) {
      int imap = 0;
      boolean busy = true;
      while (busy && imap < mMap.length) {
        String search  = mMap[imap ++];
        String replace = mMap[imap ++];
        if (mOldWord.startsWith(search, ipos)) {
          mNewWord.append(replace);
          ipos += search.length();
          busy = false;
        } 
      } // while imap
      if (busy) { // no mapping could be applied
        mNewWord.append(mOldWord.charAt(ipos ++)); // copy character unchanged
      }
    } // while ipos
    mOldWord = mNewWord.toString();
    if (mDebug > 0 && mOldWord.length() < 128) {
        System.out.println("# " + mOldWord);
    }
    if (mOldWord.length() > 1000000) {
      throw new IllegalArgumentException("mOldWord longer than 10^6 characters");
    }
  } // expandWord

  /**
   * Get the next term of the sequence.
   * @return the next term
   */
  @Override
  public Z next() {
  	if (mPos >= mFixPoint.length()) {
      int loopCheck = 6;
      while (loopCheck > 0 && (mPos >= mFixPoint.length() || ! mOldWord.startsWith(mStart))) { // at the end of the word: expand it
        if (mOldWord.startsWith(mStart)) {
          mFixPoint = mOldWord;
        } 
        expandWord();
        loopCheck --;
      } // while expanding
      if (loopCheck <= 0 && mDebug > 0) {
        System.err.println("assertion loopCheck in MorphismSequence.next, pos = " + mPos 
            + ", word = \"" + mOldWord + "\"");
      }
	}
    // take next from current word
    return Z.valueOf(mOldWord.charAt(mPos ++) - '0');
  } // next

  //=====================================
  /*  Test method
   *  @param args command line arguments: [noterms [mappings [start]]]
   *  Computes the fixed point of a mapping.
   */

  public static void main(String[] args) {
    int noTerms = 32;
    String mappings = "0->001,1->0"; // A171588
    int iarg = 0;
    if (iarg < args.length) {
      try {
        noTerms = Integer.parseInt(args[iarg ++]);
      } catch (Exception exc) {
      }
    }
    if (iarg < args.length) {
      mappings = args[iarg ++].replaceAll(" ","");
    }
    String start = mappings.substring(0, mappings.indexOf("-"));
    if (iarg < args.length) {
      start    = args[iarg ++];
    }
    MorphismSequence seq = new MorphismSequence(1, start, String.valueOf(start), mappings);
    seq.mDebug = noTerms & 3; /// last 2 bits
    int index = 1;
    while (index < noTerms) {
      System.out.println(index + " " + seq.next().toString());
      index ++;
    } // while index
  } // main

} // MorphismSequence
