package seqbox;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 
 * Seqbox - Web interface for jOEIS programs.
 * This class is configured in WEB-INF/web.xml and to be used with a Tomcat web container.
 * @author Georg Fischer
 */
public class SeqboxServlet extends HttpServlet {
    public final static long serialVersionUID = 19470629;

    /** URL path to this application */
    private String mApplPath;
    /** Common code and messages for auxiliary web pages */
    private BasePage mBasePage;
    /** Name of this application */
    private static final String APP_NAME = "Seqbox";

    /** 
     * Called by the servlet container to indicate to a servlet
     * that the servlet is being placed into service.
     * @param config object containing the servlet's configuration and initialization parameters
     * @throws ServletException for servlet errors
     */
    public void init(final ServletConfig config) throws ServletException {
        super.init(config); // ???
        mBasePage = new BasePage(APP_NAME);
        Messages.addMessageTexts(mBasePage);
    } // init

    /** 
     * Process an http GET request
     * @param request request with header fields
     * @param response response with writer
     * @throws IOException for IO errors
     */
    public void doGet (final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        generateResponse(request, response);
    }

    /** 
     * Process an http POST request
     * @param request request with header fields
     * @param response response with writer
     * @throws IOException for IO errors
     */
    public void doPost(final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        generateResponse(request, response);
    }

    /** 
     * Generate the response (HTML page) for an http request
     * @param request request with header fields
     * @param response response with writer
     * @throws IOException for IO errors
     */
    public void generateResponse(final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        String view     = BasePage.getInputField(request, "view"  , "index");
        String language = BasePage.getInputField(request, "lnag"  , "en");
        try {
            if (false) {
            } else if (view.equals("joeis") || view.equals("index")) {
                (new IndexPage    ()).dialog(request, response, mBasePage, language);

            } else if (view.equals("license")
                    || view.equals("manifest")
                    || view.equals("notice")
                    ) {
                (new MetaInfPage    ()).showMetaInf (request, response, mBasePage, language, view, this);

            } else {
                mBasePage.writeMessage(request, response, language, new String[] { "401", "view", view });
            }
        } catch (IOException exc) {
            System.err.println(exc.getMessage());
            throw exc;
        }
    }
}
