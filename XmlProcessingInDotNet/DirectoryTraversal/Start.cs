namespace DirectoryTraversal
{
    using System.IO;
    using System.Text;
    using System.Xml;
    using System.Xml.Linq;

    public class Start
    {
        public static void Main()
        {
            string targetPath = "../../../CatalogFirstCreation";

            // XmlWriter
            using (var writer = new XmlTextWriter("../../../AdditionalFiles/directories1.xml", Encoding.UTF8))
            {
                writer.WriteStartDocument();

                writer.WriteStartElement("dir");
                writer.WriteAttributeString("name", new DirectoryInfo(targetPath).Name);

                TraverseAndGenerateXmlUsingXmlWriter(targetPath, writer);

                writer.WriteEndElement();

                writer.WriteEndDocument();
            }

            // XDocument
            var dir = new XElement("dir");
            dir.SetAttributeValue("name", new DirectoryInfo(targetPath).Name);
            TraverseAndGenerateXmlUsingXdocument(targetPath, dir);
            dir.Save("../../../AdditionalFiles/directories2.xml");
        }

        // so not cool...
        private static void TraverseAndGenerateXmlUsingXmlWriter(string targetPath, XmlTextWriter writer)
        {
            var files = Directory.GetFiles(targetPath);
            if (files.Length > 0)
            {
                foreach (var f in files)
                {
                    writer.WriteStartElement("file");
                    writer.WriteAttributeString("name", Path.GetFileNameWithoutExtension(f));
                    writer.WriteEndElement();
                }
            }

            var directories = Directory.GetDirectories(targetPath);
            if (directories.Length != 0)
            {
                foreach (var dir in directories)
                {
                    writer.WriteStartElement("dir");
                    writer.WriteAttributeString("name", new DirectoryInfo(dir).Name);
                    
                    TraverseAndGenerateXmlUsingXmlWriter(dir, writer);
                    writer.WriteEndElement();
                }
            }
        }

        private static void TraverseAndGenerateXmlUsingXdocument(string targetPath, XElement directory)
        {
            var files = Directory.GetFiles(targetPath);
            if (files.Length > 0)
            {
                foreach (var f in files)
                {
                    var fileTag = new XElement("file");
                    fileTag.SetAttributeValue("name", Path.GetFileNameWithoutExtension(f));
                    directory.Add(fileTag);
                }
            }

            var directories = Directory.GetDirectories(targetPath);
            if (directories.Length != 0)
            {
                foreach (var dir in directories)
                {
                    var dirTag = new XElement("dir");
                    dirTag.SetAttributeValue("name", new DirectoryInfo(targetPath).Name);

                    TraverseAndGenerateXmlUsingXdocument(dir, dirTag);

                    directory.Add(dirTag);
                }
            }
        }
    }
}
