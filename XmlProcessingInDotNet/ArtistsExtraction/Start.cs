namespace ArtistsExtraction
{
    using System;
    using System.Collections;
    using System.Xml;

    public class Start
    {
        public static void Main()
        {
            var artistsUsingDomParser = GetArtistsUsingDomParser();
            foreach (var artist in artistsUsingDomParser.Keys)
            {
                Console.WriteLine("{0}: {1} album(s)", artist, artistsUsingDomParser[artist]);
            }

            Console.WriteLine();

            var artistsUsingXpath = GetArtistsUsingXpath();
            foreach (var artist in artistsUsingXpath.Keys)
            {
                Console.WriteLine("{0}: {1} album(s)", artist, artistsUsingXpath[artist]);
            }
        }

        // Using Hashtable because of homework requirements.
        private static Hashtable GetArtistsUsingDomParser()
        {
            var artists = new Hashtable();

            var doc = new XmlDocument();
            doc.Load("../../../AdditionalFiles/catalog.xml");
            var root = doc.DocumentElement;

            foreach (XmlNode album in root.ChildNodes)
            {
                var currentArtistName = album["artist"].InnerText;
                if (!artists.ContainsKey(currentArtistName))
                {
                    artists[currentArtistName] = 1;
                }
                else
                {
                    int albumsCountSoFar = (int)artists[currentArtistName];
                    int albumsCountUpdated = albumsCountSoFar + 1;
                    artists[currentArtistName] = albumsCountUpdated;
                }
            }

            return artists;
        }

        private static Hashtable GetArtistsUsingXpath()
        {
            var artists = new Hashtable();

            var doc = new XmlDocument();
            doc.Load("../../../AdditionalFiles/catalog.xml");

            string xPathQuery = "albums/album/artist";
            XmlNodeList artistsNodes = doc.SelectNodes(xPathQuery);
            foreach (XmlNode artist in artistsNodes)
            {
                var currentArtistName = artist.InnerText;
                if (!artists.ContainsKey(currentArtistName))
                {
                    artists[currentArtistName] = 1;
                }
                else
                {
                    int albumsCountSoFar = (int)artists[currentArtistName];
                    int albumsCountUpdated = albumsCountSoFar + 1;
                    artists[currentArtistName] = albumsCountUpdated;
                }
            }

            return artists;
        }
    }
}
