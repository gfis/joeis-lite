package irvine.oeis;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.channels.Channels;

import irvine.util.string.Date;

/**
 * Generate a report of the superclasses, their offsets and additional constructors for all implemented A-number sequences.
 * @author Georg Fischer
 */
public final class SuperclassInspector {

  /** Empty constructor */
  private SuperclassInspector() {
  }

  /**
   * Get the trailing word of a class name.
   * @param cl get the name of this class
   * @return the unqualified name
   */
  private static String bareName(Class cl) {
    return cl.getName().replaceAll("(\\w+\\.)+", "");
  }

  /**
   * Main program.
   * @param args name of file with one A-number per line.
   */
  public static void main(final String[] args) {
    System.err.println("# Starting report at " + Date.now());
    int iarg = 0;
    String fileName = "-"; // default: read from STDIN
    if (args.length > 0) {
      fileName = args[iarg++];
    }
    if (fileName.matches("\\-\\-?h(elp)?")) {
      System.out.print("Usage: java irvine.oeis.SuperclassInspector {- | filename}\n"
          + "    file contains lines with A-numbers\n"
          );
      return;
    }
    final String srcEncoding = "UTF-8"; // Encoding of the input file
    String line; // current line from text file
    int total = 0;
    try {
      try (final BufferedReader lineReader = fileName.length() <= 0 || fileName.equals("-")
        ? new BufferedReader(new InputStreamReader(System.in, srcEncoding))
        : new BufferedReader(Channels.newReader(new FileInputStream(fileName).getChannel(), srcEncoding))) {
        final StringBuilder sb = new StringBuilder(128);
        while ((line = lineReader.readLine()) != null) { // read and process lines
          if (!line.matches("\\s*#.*")) { // is not a comment
            ++total;
            final String aseqno = line.trim();
            if (total % 16384 == 0) {
              System.err.print("# +" + total + "\t" + aseqno + "\n");
            }
            try { 
              // final seq = (Sequence) Class.forName("irvine.oeis.a" + aseqno.substring(1, 4) + '.' + aseqno).getDeclaredConstructor().newInstance();
              // final Sequence seq = SequenceFactory.sequence(aseqno);
              final Class cl = Class.forName("irvine.oeis.a" + aseqno.substring(1, 4) + '.' + aseqno);
              sb.setLength(0);
              sb.append(bareName(cl.getSuperclass()));
              for (Class clif : cl.getInterfaces()) {
                sb.append(' ');
                sb.append(bareName(clif));
              }
              System.out.print(aseqno + "\t" + sb.toString() + "\n");
            } catch (final ClassNotFoundException exc) {
              //System.out.println("# " + aseqno + " nyi");
            } catch (final RuntimeException exc) {
              System.out.println("#?? " + aseqno + ": " + exc.getMessage());
            }
          } // is not a comment
        } // while ! eof
      }
    } catch (final RuntimeException | IOException exc) {
      System.err.println(exc.getMessage());
    }
    System.err.println("# " + String.format("%6d", total) + " sequences in jOEIS");
    System.err.println("# End at " + Date.now());
  }
}
