namespace CatalogFirstCreation
{
    public class Song
    {
        public Song(string title, double duration)
        {
            this.Title = title;
            this.Duration = duration;
        }

        public string Title { get; private set; }

        public double Duration { get; private set; }
    }
}
