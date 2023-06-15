package irvine.oeis;

import java.lang.reflect.InvocationTargetException;

import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.ConstantFactorSequence;
import irvine.oeis.transform.NegationTransformSequence;
import irvine.oeis.Sequence;
import irvine.oeis.SkipSequence;

/**
 * This class builds a sequence from a sum of other sequences possibly multiplied constant rational factors.
 * @author Georg Fischer
 */
public class SequenceSum extends AbstractSequence {

  private final Sequence[] mSeqs;
  private final int mSeqNo;
  private static int sDebug = 0;

  /**
   * Construct the sequence.
   * @param offset first index
   * @param seqs list of sequences
   */
  public SequenceSum(final int offset, final Sequence... seqs) {
    super(offset);
    mSeqNo = seqs.length;
    mSeqs = new Sequence[mSeqNo];
    for (int i = 0; i < mSeqNo; ++i) {
      mSeqs[i] = seqs[i];
    }
  }

  /**
   * Constructor with a string for the summands.
   * @param offset first index
   * @param summands String expression for summands (see toArray, below)
   * @param seqs list of sequences
   */
  public SequenceSum(final int offset, String summands) {
    this(offset, toArray(summands));
  }

  /**
   * Build an array of sequences.
   * @param summands String of summands consisting of:
   * <ul>
   * <li>an optional sign "+" or -", default "+", or "," (= "+")</li>
   * <li>an optional, constant rational factor n/d, default 1</li>
   * <li>an optional A-number (otherwise a constant sequence is created), optionally followed by "(n)"</li>
   * <li>an optional "@" followed by an offset shift, default 0</li>
   * <li>whitespace or other delimiters which are ignored</li>
   * </ul>
   * @return array of sequences
   */
  public static Sequence[] toArray(final String summands) {
    String normSummands = summands.replaceAll("\\s", "").replaceAll("\\([a-z]\\)", "");
    if (normSummands.charAt(0) != '+' && normSummands.charAt(0) != '-') { // no starting delimiter
      normSummands = "+" + normSummands;
    }
    final String[] parts = normSummands.split("((?<=[\\+\\-\\,])|(?=[\\+\\-\\,]))"); // split including delimiters
    if ((parts.length & 1) != 0) { // uneven
      throw new UnsupportedOperationException("syntax error in sum: " + normSummands);
    }
    final int partNo = parts.length;
    final int seqNo = partNo / 2; 
    if (sDebug >= 1) {
      System.out.println("summands=" + normSummands + ", seqNo=" + seqNo);
      for (int ip = 0; ip < partNo; ++ip) {
        System.out.print("\"" + parts[ip] + "\" ");
      }
      System.out.println();
    }
    final Sequence[] result = new Sequence[seqNo];
    int iSeq = 0;
    for (int i = 0; i < parts.length; i += 2) { // there are always pairs ("[+-]", factor*A-number@offset)
      final String delimiter = parts[i];
      String term = parts[i + 1];
      Q factor = Q.ONE;
      if (delimiter.equals("-")) {
        factor = Q.NEG_ONE;
      }
      if (term.indexOf('*') >= 0) { // with "factor *"
        String[] fparts = term.split("\\*");
        final String fs = fparts[0];
        term = fparts[1];
        long num = 0;
        long den = 1;
        factor = factor.multiply(new Q(fs));
      }
      int atShift = 0;
      final int atPos = term.indexOf('@');
      if (atPos >= 0) {
        try {
          atShift = Integer.parseInt(term.substring(atPos + 1));
          term = term.substring(0, atPos);
        } catch (final NumberFormatException exc) {
          // ignore
        }
      }
      if (sDebug >= 2) {
        System.out.println("mSeqs[" + iSeq + "]: " + factor + " * " + term + " @ " + atShift);
      }
      Sequence seq = null;
      if (term.length() >= 2 && term.charAt(0) == 'A') { // is A-number
        if (term.length() < 7) { // pad with leading zeros
          String no = term.substring(1);
          term = "A" + "000000".substring(0, 6 - no.length()) + no;
        }
        try {
          seq = (Sequence) Class.forName("irvine.oeis.a" + term.substring(1, 4) + '.' + term)
              .getDeclaredConstructor().newInstance();
        } catch (final ClassNotFoundException | NoSuchMethodException | InstantiationException | IllegalAccessException | InvocationTargetException exc) {
          throw new UnsupportedOperationException("invalid A-number: " + seqNo);
        }
        Sequence seq2 = seq;
        if (factor.equals(Q.ONE)) { // ignore
        } else if (factor.equals(Q.NEG_ONE)) {
          seq2 = new NegationTransformSequence(seq);
        } else {
          seq2 = new ConstantFactorSequence(seq, factor);
        }
        result[iSeq++] = (atShift == 0) ? seq2 : new SkipSequence(seq2, atShift);
      } else { // constant without A-number
        try {
          factor = factor.multiply(Long.parseLong(term));
        } catch (final NumberFormatException exc) {
          throw new UnsupportedOperationException("invalid integer constant: " + term);
        }
        if (factor.isInteger()) {
          final Z cons = factor.num();
          seq = new AbstractSequence(0) {
                @Override
                public Z next() {
                  return cons;
                }
             };
        } else {
          throw new UnsupportedOperationException("cannot add a fraction: " + factor);
        }
        result[iSeq++] = seq;
      }
    }
    return result;
  }

  @Override
  public Z next() {
    if (sDebug >= 3) {
      System.out.println("seqNo=" + mSeqNo);
      for (int ip = 0; ip < mSeqNo; ++ip) {
        if (mSeqs[ip] == null) {
          System.out.print("null ");
        } else {
          System.out.print(mSeqs[ip].getClass().getName() + " ");
        }
      }
      System.out.println();
    }
    Z result = mSeqs[0].next();
    for (int i = 1; i < mSeqNo; ++i) {
      result = result.add(mSeqs[i].next());
    }
    return result;
  }

  /**
   * Main test method: Compute the sum of several sequences.
   * @param args command line arguments:
   * <ul>
   * <li>-a list of summands (see below)</li>
   * <li>-n number of terms (default 32)</li>
   * <li>-o offset, first index (default 0) </li>
   * </ul>
   * The summands consist of:
   * <ul>
   * <li>an optional sign "+" or -", default "+"</li>
   * <li>an optional, constant rational factor n/d, default 1</li>
   * <li>an optional A-number (otherwise a constant sequence is created)</li>
   * <li>an optional "@" followed by an offset shift, default 0</li>
   * <li>whitespace or other delimiters which are ignored</li>
   * </ul>
   */
  public static void main(final String[] args) {
    String summands = "A007528,A002476"; // A354543 Convolution of {{A007528}} and {{A002476}}
    int offset = 0;
    int noTerms = 32;
    int iarg = 0;
    while (iarg < args.length) { // consume all arguments
      final String opt = args[iarg++];
      try {
        if (opt.equals("-d")) {
          sDebug = Integer.parseInt(args[iarg++]);
        } else if (opt.equals("-s")) {
          summands = args[iarg++];
        } else if (opt.equals("-n")) {
          noTerms = Integer.parseInt(args[iarg++]);
        } else if (opt.equals("-o")) {
          offset = Integer.parseInt(args[iarg++]);
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (final Exception exc) { // take default
        System.err.println("wrong option: " + args[iarg - 1] + ", message: " + exc.getMessage());
      }
    } // while args

    final SequenceSum seq = new SequenceSum(offset, summands);
    for (int iterm = 0; iterm < noTerms; ++iterm) {
      if (iterm > 0) {
        System.out.print(",");
      }
      System.out.print(seq.next());
    } // for iterm
    System.out.println();
  } // main
}
