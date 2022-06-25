package seqbox;

import java.io.Serializable;

/**
 * Language specific message texts and formatting for the Seqbox user interface.
 * All internationalization of the Java source code is assembled in this class.
 * Currently implemented natural languages (denoted by 2-letter ISO <em>country</em> codes) are:
 * <ul>
 * <li>en - English</li>
 * <li>de - German</li>
 * <li>fr - French</li>
 * </ul>
 * All methods in this class are not stateful, and therefore are <em>static</em> for easier activation.
 * @author Georg Fischer
 */
public class Messages implements Serializable {

    public final static long serialVersionUID = 19470629;

    /** 
     * Empty constructor
     */
    public Messages() {
    } // Constructor
    
    /** Sets the application-specific error message texts
     *  @param basePage reference to the hash for message texts
     */
    public static void addMessageTexts(final BasePage basePage) {
        String appLink = "<a href=\"servlet?view=index\">" + basePage.getAppName() + "</a>";
        //--------
        basePage.add("en", "001", appLink);
        basePage.add("en", "002"
                , " <a href=\"mailto:dr.georg.fischer@gmail.com"
                + "?&subject=" + basePage.getAppName()
                + "\">Dr. Georg Fischer</a>"
                );
        //--------
        String laux = basePage.LANG_AUX;  // pseudo language code for links to auxiliary information
        int imess   = basePage.START_AUX; // start of messages    for links to auxiliary information
        //--------
        imess = basePage.addStandardLinks(imess);
    }
}
