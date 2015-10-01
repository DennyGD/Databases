namespace CatalogFirstCreation
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Text;
    using System.Xml;

    public class Start
    {
        private static Random rnd = new Random();

        public static void Main()
        {
            bool catalogIsAlreadyCreated = File.Exists("../../../AdditionalFiles/catalog.xml");
            if (!catalogIsAlreadyCreated)
            {
                var albums = GenerateAlbumsWithSongs(5, 3);
                GenerateCatalog(albums);
            }
        }

        private static void GenerateCatalog(IEnumerable<Album> albums)
        {
            using (var xmlWriter = new XmlTextWriter("../../../AdditionalFiles/catalog.xml", Encoding.UTF8))
            {
                xmlWriter.Formatting = Formatting.Indented;
                xmlWriter.IndentChar = '\t';
                xmlWriter.Indentation = 1;

                xmlWriter.WriteStartDocument();
                xmlWriter.WriteStartElement("albums");

                foreach (var album in albums)
                {
                    xmlWriter.WriteStartElement("album");

                    xmlWriter.WriteElementString("name", album.Name);
                    xmlWriter.WriteElementString("artist", album.Artist);
                    xmlWriter.WriteElementString("year", album.Year.ToString());
                    xmlWriter.WriteElementString("producer", album.Producer);
                    xmlWriter.WriteElementString("price", album.Price.ToString());

                    xmlWriter.WriteStartElement("songs");

                    foreach (var song in album.Songs)
                    {
                        xmlWriter.WriteStartElement("song");

                        xmlWriter.WriteElementString("title", song.Title);
                        xmlWriter.WriteElementString("duration", song.Duration.ToString());

                        xmlWriter.WriteEndElement();
                    }

                    xmlWriter.WriteEndElement();
                    xmlWriter.WriteEndElement();
                }

                xmlWriter.WriteEndElement();
            }
        }

        private static Album[] GenerateAlbumsWithSongs(int albumsCount, int songsPerAlbum)
        {
            var albums = new Album[albumsCount];

            int year = 1998;
            decimal price = 18M;

            for (int i = 0; i < albumsCount; i++)
            {
                var albumToAdd = new Album("Name" + i, "Artist" + i, year, "Producer" + i, price);

                for (int j = 0; j < songsPerAlbum; j++)
                {
                    albumToAdd.AddSong(GenerateSong());
                }

                albums[i] = albumToAdd;

                year += 1;
                price += 1;
            }

            return albums;
        }

        private static Song GenerateSong()
        {
            int titleNumber = rnd.Next(1, 20);
            double duration = rnd.NextDouble() * (5.5 - 3.3) + 3.3;

            var song = new Song("Title" + titleNumber, Math.Round(duration, 2));
            return song;
        }
    }
}
