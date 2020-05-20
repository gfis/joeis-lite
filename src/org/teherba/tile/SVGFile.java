/* Output to an Scalable Vector Graphics file
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
 * This class opens, writes to and closes an Scalable Vector Graphics file.
 * The format is XML, maybe with an embedded stylesheet or a reference to one.
 * @author Georg Fischer
 */
public class SVGFile {
  public final static String CVSID = "@(#) $Id: SVGFile.java $";

  /** Encoding of the file */
  private static final String sEncoding = "UTF-8";
  
  /** Writer for b-file output */
  private static PrintWriter sSVGWriter;

  /** Whether SVG output is enabled */
  public static boolean sEnabled;
  
  /** Filename for SVG output */
  public static String sFileName;
 
  /**
   * Empty Constructor.
   */
  public SVGFile() {
    sFileName = "Test.svg";
    sEnabled  = false;
  } // Constructor()

  /**
   * Opens the SVG file
   * @param maxDistance length of path to outer shell
   * @param galId name of the tiling
   */
  public static void open(int maxDistance, String galId) {
    try {
      if (sFileName.equals("-")) { // stdout
         sSVGWriter = new PrintWriter(Channels.newWriter(Channels.newChannel(System.out), sEncoding));
      } else { // not stdout
        if (! sFileName.endsWith(".svg")) {
          sFileName += ".svg";
        }
        WritableByteChannel channel = (new FileOutputStream (sFileName, false)).getChannel();
        sSVGWriter = new PrintWriter(Channels.newWriter(channel, sEncoding));
      } // not stdout

      // viewBox="-w1 -w1 w2 w2"
      int w1 = maxDistance;
      int w2 = 2 * w1; 
      String timestamp = (new SimpleDateFormat("yyyy-MM-dd' 'HH:mm")).format(new java.util.Date());
      sSVGWriter.println(""
          + "<?xml version=\"1.0\"?>\n"
          + "<!--\n"
          + "    Written with Tiler2.java at " + timestamp + " - Georg Fischer. Do NOT edit here!\n"
          + "-->\n"
          + "<?xml-stylesheet type=\"text/css\" href=\"tiling.css\" ?>\n"
          + "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n"
          + "<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\"\n"
          + "    width=\"192mm\" height=\"192mm\" viewBox=\"-" + w1 + " -" + w1 + " " + w2 + " " + w2 + "\" >\n" // spaces are important!
          + "<title>Uniform Tiling</title>\n"
          + "<g id=\"tile\">\n"
          + "<rect x=\"-" + w1 +"\" y=\"-" + w1 + "\" width=\"" + w2 +"\" height=\"" + w2 + "\" />\n"
          + "<text class=\"nota\" x=\"-" + (w1 * 0.95) +"\" y=\"-" + (w1 * 0.85) + "\" style=\"font-size: " + (w1 / 20.0)
          + "pt\">" + galId + "</text>"
          );
    } catch (Exception exc) {
      // log.error(exc.getMessage(), exc);
      System.err.println(exc.getMessage());
      exc.printStackTrace();
    } // try
  } // open

  /**
   * Closes the b-file
   */
  public static void close() {
    try {
      sSVGWriter.print("</g>\n</svg>\n");
      sSVGWriter.close();
    } catch (Exception exc) {
      // log.error(exc.getMessage(), exc);
      System.err.println(exc.getMessage());
      exc.printStackTrace();
    } // try
  } // close()

  /**
   * Writes a data line
   * @param param a line of the form <em>index space term</em>
   */
  public static void write(String param) {
    try {
      sSVGWriter.print(param + "\n");
    } catch (Exception exc) {
      // log.error(exc.getMessage(), exc);
      System.err.println(exc.getMessage());
      exc.printStackTrace();
    } // try
  } // write

  /** Color in distances in tilings.css cycle through 0..5 */
  private static final int COLOR_MOD = 3;
  
  /**
   * Writes an edge from the focus to a neighbouring {@link Vertex} to the SVG file.
   * @param focus starting Vertex
   * @param proxy ending   Vertex
   * @param distance distance from baseVertex, for coloring
   * @param mode 0=normal, 1=tentative, 2=test
   */
  public static void writeEdge(Vertex focus, Vertex proxy, int distance, int mode) {
    switch (mode) {
      default:
      case 0: // normal
        write("<line class=\"l" + String.valueOf(distance % COLOR_MOD)
            + "\" x1=\"" + focus.expos.getX()
            + "\" y1=\"" + focus.expos.getY()
            + "\" x2=\"" + proxy.expos.getX()
            + "\" y2=\"" + proxy.expos.getY()
            + "\"><title>" + focus.index + focus.getName()
            + "->"         + proxy.index + proxy .getName()
            + "</title></line>");
        break;
      case 1: // tentative
        write("<line class=\"tent dash"
            + "\" x1=\"" + focus.expos.getX()
            + "\" y1=\"" + focus.expos.getY()
            + "\" x2=\"" + proxy.expos.getX()
            + "\" y2=\"" + proxy.expos.getY()
            + "\"><title>" + focus.index + focus.getName()
            + "->"         + proxy.index + proxy .getName()
            + "</title></line>");
        break;
      case 2: // test
        write("<line class=\"test dash"
            + "\" x1=\"" + focus.expos.getX()
            + "\" y1=\"" + focus.expos.getY()
            + "\" x2=\"" + proxy.expos.getX()
            + "\" y2=\"" + proxy.expos.getY()
            + "\"><title>" + focus.index + focus.getName()
            + "->"         + proxy.index + proxy .getName()
            + "</title></line>");
        break;
    } // switch (mode)
  } // writeEdge

  /**
   * Writes a circle centered at the position of a {@link Vertex} to the SVG file.
   * @param focus Vertex to be drawn
   * @param maxBase number of base vertices (drawn with a bigger circle if index is less this value)
   * @param mode  0=normal, 1=tentative, 2=test
   */
  public static void writeVertex(Vertex focus, int maxBase, int mode) {
    String color = focus.fixedEdges > 0 ? String.valueOf(focus.distance % COLOR_MOD) : "8";
    String name  = focus.getName();
    switch (mode) {
      default:
      case 0:
        write("<g><circle class=\"c" + color
            + "\" cx=\"" + focus.expos.getX()
            + "\" cy=\"" + focus.expos.getY()
            + "\" r=\""  + (focus.index < maxBase ? "0.3" : "0.15") + "\">" // bigger if baseVertex
            + "</circle>"
            + "<text     class=\"t" + color
            + "\" x=\""  + focus.expos.getX()
            + "\" y=\""  + focus.expos.getY()
            + "\" dy=\"0.35em\">" + name + "</text>"
            + "<title>"  + String.valueOf(focus.index) + name + focus.rotate + "</title>"
            + "</g>"
            );
        break;
      case 1:
      case 2:
        write("<g><circle class=\"test"
            + "\" cx=\"" + focus.expos.getX()
            + "\" cy=\"" + focus.expos.getY()
            + "\" r=\""  + (focus.index == 2 ? "0.3" : "0.15") + "\">"
            + "</circle>"
            + "<text class=\"t"  + color
            + "\" x=\""  + focus.expos.getX()
            + "\" y=\""  + focus.expos.getY()
            + "\" dy=\"0.03px\">" + name + "</text>"
            + "<title>"  + String.valueOf(focus.index) + name + focus.rotate + "</title>"
            + "</g>"
            );
        break;
    } // switch (mode)
  } // writeVertex

} // class SVGFile
