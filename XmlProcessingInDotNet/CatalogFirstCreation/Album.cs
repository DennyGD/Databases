namespace CatalogFirstCreation
{
    using System;
    using System.Collections.Generic;

    public class Album
    {
        private IList<Song> songs;

        public Album(string name, string artist, int year, string producer, decimal price)
        {
            this.Name = name;
            this.Artist = artist;
            this.Year = year;
            this.Producer = producer;
            this.Price = price;

            this.songs = new List<Song>();
        }

        public string Name { get; private set; }

        public string Artist { get; private set; }

        public int Year { get; private set; }

        public string Producer { get; private set; }

        public decimal Price { get; private set; }

        public List<Song> Songs
        {
            get
            {
                return new List<Song>(this.songs);
            }
        }

        public void AddSong(Song song)
        {
            this.songs.Add(song);
        }
    }
}
