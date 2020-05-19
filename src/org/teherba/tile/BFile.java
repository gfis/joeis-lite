/* Output to an OEIS b-file
 * @(#) $Id$
 * Copyright (c) 2020 Dr. Georg Fischer
 * 2020-05-15, Georg Fischer: extracted from Tiler.java
 */
package org.teherba.tile;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.nio.channels.Channels;
import java.nio.channels.WritableByteChannel;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * This class opens, writes to and closes an OEIS b-file.
 * The data lines in b-files have the form <em>index space term newline</em>.
 * There may be comment lines at the beginning of the file starting with "#".
 * @author Georg Fischer
 */
public class BFile {
  public final static String CVSID = "@(#) $Id: BFile.java $";

  /** Number of terms which were written to the b-file */
  private static int sBFileCount;

  /** Whether b-file output is enabled */
  public static boolean sEnabled;

  /** Encoding of the file */
  private static final String sEncoding = "UTF-8";
  
  /** Prefix ("directory/") for b-file names */
  private static String sBFilePrefix;

  /** Sets the directory prefix.
   * @param prefix usually "directory/" before the filename
   */
  public static void setPrefix(String prefix) {
    sBFilePrefix = prefix;
  } // setPrefix
  
  /** Writer for b-file output */
  private static PrintWriter sBFileWriter;
 
  /**
   * Empty Constructor.
   */
  public BFile() {
    setPrefix("./");
    sBFileCount = 0;
  } // Constructor()

  /**
   * Opens the b-file
   * @param param "-" for STDIN or a filename
   * or a tuple (index space term)
   */
  public static void open(String param) {
    try {
      sBFileCount = 0;
      if (param.equals("-")) { // stdout
         sBFileWriter = new PrintWriter(Channels.newWriter(Channels.newChannel(System.out), sEncoding));
      } else { // not stdout
        String fileName = param.trim();
        if (fileName.startsWith("A")) {
          fileName = "b" + fileName.substring(1);
        }
        if (! fileName.endsWith(".txt")) {
          fileName += ".txt";
        }
        WritableByteChannel channel = (new FileOutputStream (sBFilePrefix + fileName, false)).getChannel();
        sBFileWriter = new PrintWriter(Channels.newWriter(channel, sEncoding));
        String timestamp = (new SimpleDateFormat("yyyy-MM-dd' 'HH:mm")).format(new java.util.Date());
        sBFileWriter.println("# " + fileName + " written with TilingTest at " + timestamp);
      } // not stdout
    } catch (Exception exc) {
      // log.error(exc.getMessage(), exc);
      System.err.println(exc.getMessage());
      exc.printStackTrace();
    } // try
  } // open

  /**
   * Writes a data line
   * @param param a line of the form <em>index space term</em>
   */
  public static void write(String param) {
    try {
      sBFileWriter.print(param + "\n");
      sBFileCount ++;
    } catch (Exception exc) {
      // log.error(exc.getMessage(), exc);
      System.err.println(exc.getMessage());
      exc.printStackTrace();
    } // try
  } // write

  /**
   * Closes the b-file
   */
  public static void close() {
    try {
      sBFileWriter.close();
    } catch (Exception exc) {
      // log.error(exc.getMessage(), exc);
      System.err.println(exc.getMessage());
      exc.printStackTrace();
    } // try
  } // close()

} // class BFile
