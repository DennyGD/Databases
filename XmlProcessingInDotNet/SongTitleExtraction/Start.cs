namespace SongTitleExtraction
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Xml;
    using System.Xml.Linq;

    public class Start
    {
        public static void Main()
        {
            var songTitlesUsingXmlReader = ExtractSongTitlesUsingXmlReader();

            foreach (var title in songTitlesUsingXmlReader)
            {
                Console.WriteLine(title);
            }

            Console.WriteLine();

            var songTitlesUsingXdocument = ExtractSongTitlesUsingXdocumentAndLinq();

            foreach (var title in songTitlesUsingXdocument)
            {
                Console.WriteLine(title);
            }
        }

        private static IEnumerable<string> ExtractSongTitlesUsingXmlReader()
        {
            var songTitles = new List<string>();

            using (XmlReader reader = XmlReader.Create("../../../AdditionalFiles/catalog.xml"))
            {
                while (reader.Read())
                {
                    bool isElement = reader.NodeType == XmlNodeType.Element;
                    if (isElement && reader.Name == "song")
                    {
                        reader.ReadToFollowing("title");
                        songTitles.Add(reader.ReadElementContentAsString());
                    }
                }
            }

            return songTitles;
        }

        private static IEnumerable<string> ExtractSongTitlesUsingXdocumentAndLinq()
        {
            var doc = XDocument.Load("../../../AdditionalFiles/catalog.xml");
            var songTitles = from song in doc.Descendants("song")
                        select song.Element("title").Value;

            return songTitles;
        }
    }
}
