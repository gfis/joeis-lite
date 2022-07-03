package irvine.oeis.producer;

import java.io.BufferedReader;
import java.io.Closeable;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * Produce a sequence from a LODA program.
 * Cf. https://loda-lang.org/spec/
 * @author Georg Fischer
 */
public class LodaSequence implements Sequence, Closeable {

  private final boolean mVerbose = "true".equals(System.getProperty("oeis.verbose", "false"));
  private final String mTimeout = System.getProperty("oeis.timeout", "3600000"); // 1000 hours = almost never
  private final PrintWriter mOut = null;
  private final BufferedReader mIn = null;
  
  private final static int MAX_NEST = 32;
  private int[] mSeqNo; // stack for sequence numbers of callers of nested sequences
  private int[] mSeqPos; // stack for positions in callers of nested sequences
  /**
   * Construct a sequence from a LODA program.
   * @param program LODA program
   */
  public LodaSequence(final String program) {
    mSeqNo = new int[MAX_NEST];
    mSeqPos = new int[MAX_NEST];
  }

  /**
   * Execute a sequence <code>Aseqno(n)</code> with an argument <code>n</code>
   * @param seqNo OEIS number of sequence to be executed
   * @param n argument
   * @return <code>a(n)</code
   */
  private Z exec(final int seqNo, final int n) {
    int[] loopPos = new int[MAX_NEST]; // stack for indexes of operations <code>lpb</code>     
    int[] loopVal = new int[MAX_NEST]; // stack for last value of operations </code>lpb</code> 
    int loopLevel = 0; // level of nested loops, 0 = outside of all loops 
    String program = LodaProducer.getProgram("a" + String.valueOf(seqNo));
    String[] ops = program.split("\\r?\\n"); // operations, assembly code lines  mMems = new ArrayList<Z>(MAX_NEST);
    final int opLen = ops.length;
    ArrayList<Z> mems = new ArrayList<Z>(MAX_NEST); // unbounded array of memory cells
    mems.add(Z.valueOf(n));
    int pc = 0; // program counter
    while (pc < opLen) { // main instruction loop
      String line = ops[pc];
      final int semiPos = line.indexOf(';');
      if (semiPos >= 0) {
        line = line.substring(0, semiPos);
      }
      line = line.trim();
      if (line.length() > 0) {
        int spacePos = line.indexOf(' ');
        if (spacePos < 0) {
          spacePos = line.length();
        }
        String opcode = line.substring(0, spacePos);
        String operands = line.substring(spacePos).trim();
        switch(opcode) {
          default: // do nothing
            break; 
          case "mov": // Assignment
            break;
          case "add": // Addition
            break;
          case "sub": // Subtraction
            break;
          case "trn": // Truncation
            break;
          case "mul": // Multiplication
            break;
          case "div": // Division
            break;
          case "dif": // Conditional Division
            break;
          case "mod": // Modulus
            break;
          case "pow": // Power
            break;
          case "gcd": // Greatest Common Divisor
            break;
          case "bin": // Binomial Coefficient
            break;
          case "cmp": // Comparison
            break;
          case "min": // Minimum
            break;
          case "max": // Maximum
            break;
          case "lpb": // Loop begin
            break;
          case "lpe": // Loop end
            break;
          case "clr": // Clear
            break;
          case "seq": // Call Sequence
            break;
        }
      }
      ++pc;
    } 
    return mems.get(0);
  }

  @Override
  public Z next() {
    return Z.ZERO;
  }

  @Override
  public void close() throws IOException {
    try {
    } finally {
    }
  }
}
