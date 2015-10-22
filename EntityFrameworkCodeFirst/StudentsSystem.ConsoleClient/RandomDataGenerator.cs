namespace StudentsSystem.ConsoleClient
{
    using System;
    using System.Text;

    public static class RandomDataGenerator
    {
        private const string EnglishAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

        private static Random rnd = new Random();

        public static int GetInteger(int minValue, int maxValue)
        {
            return rnd.Next(minValue, maxValue + 1);
        }

        public static string GetString(int minLength, int maxLength)
        {
            int alphabetLength = EnglishAlphabet.Length;
            int stringLength = GetInteger(minLength, maxLength);

            var result = new StringBuilder();

            for (int i = 0; i < stringLength; i++)
            {
                int letterIndex = GetInteger(0, alphabetLength - 1);
                char letter = EnglishAlphabet[letterIndex];

                result.Append(letter);
            }

            return result.ToString();
        }
    }
}
