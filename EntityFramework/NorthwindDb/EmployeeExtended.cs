namespace NorthwindDb
{
    using System.Data.Linq;

    public partial class Employee
    {
        public EntitySet<Territory> TerritoriesAsSet
        {
            get
            {
                var territoriesSet = new EntitySet<Territory>();
                territoriesSet.AddRange(this.Territories);

                return territoriesSet;
            }
        }
    }
}
