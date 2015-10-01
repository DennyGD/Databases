namespace SchemaGeneration
{
    using System;
    using System.Xml;
    using System.Xml.Linq;
    using System.Xml.Schema;

    public class Start
    {
        public static void Main()
        {
            string xmlPath = "../../../AdditionalFiles/catalog.xml";
            string xsdPath = "../../../AdditionalFiles/catalog.xsd";

            GenerateXsdFromXml(xmlPath, xsdPath);

            bool xmlIsValid = CheckIfValidXmlAgainstXsd(xmlPath, xsdPath);
            Console.WriteLine("Xml is {0}", xmlIsValid ? "valid" : "not valid");
        }

        // http://stackoverflow.com/questions/22835730/create-xsd-from-xml-in-code
        // https://msdn.microsoft.com/en-us/library/xz2797k1%28v=vs.110%29.aspx
        private static void GenerateXsdFromXml(string xmlPath, string xsdPath)
        {
            var reader = XmlReader.Create(xmlPath);
            var inference = new XmlSchemaInference();
            var schemaSet = new XmlSchemaSet();
            schemaSet = inference.InferSchema(reader);
            reader.Dispose();

            using (var writer = XmlWriter.Create(xsdPath))
            {
                foreach (XmlSchema schema in schemaSet.Schemas())
                {
                    schema.Write(writer);
                }
            }
        }

        // https://msdn.microsoft.com/en-us/library/bb387037.aspx?f=255&MSPPError=-2147217396
        private static bool CheckIfValidXmlAgainstXsd(string xmlPath, string xsdPath)
        {
            var schemaSet = new XmlSchemaSet();
            schemaSet.Add(string.Empty, xsdPath);

            bool isValid = true;

            var doc = XDocument.Load(xmlPath);
            doc.Validate(schemaSet, (sender, ev) => { isValid = false; });

            return isValid;
        }
    }
}
