namespace AlbumCreation
{
    using System;
    using System.Text;
    using System.Xml;

    public class Start
    {
        public static void Main()
        {
            GenerateAlbum();
        }

        private static void GenerateAlbum()
        {
            using (var writer = new XmlTextWriter("../../../AdditionalFiles/album.xml", Encoding.UTF8))
            {
                writer.Formatting = Formatting.Indented;
                writer.IndentChar = '\t';
                writer.Indentation = 1;

                writer.WriteStartDocument();
                writer.WriteStartElement("albums");

                using (XmlReader reader = XmlReader.Create("../../../AdditionalFiles/catalog.xml"))
                {
                    while (reader.Read())
                    {
                        bool isElement = reader.NodeType == XmlNodeType.Element;
                        if (isElement && reader.Name == "name")
                        {
                            writer.WriteStartElement("album");

                            string albumName = reader.ReadElementContentAsString();
                            writer.WriteElementString("name", albumName);

                            reader.ReadToFollowing("artist");
                            string albumAuthor = reader.ReadElementContentAsString();
                            writer.WriteElementString("author", albumAuthor);

                            writer.WriteEndElement();
                        }
                    }
                }

                writer.WriteEndElement();
            }
        }
    }
}
