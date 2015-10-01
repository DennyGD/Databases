namespace HtmlTransformation
{
    using System.Xml.Xsl;

    public class Start
    {
        public static void Main()
        {
            TransformXmlToHtml();
        }

        private static void TransformXmlToHtml()
        {
            var xsl = new XslCompiledTransform();
            xsl.Load("../../../AdditionalFiles/catalog.xslt");
            xsl.Transform("../../../AdditionalFiles/catalog.xml", "../../../AdditionalFiles/catalog.html");
        }
    }
}
