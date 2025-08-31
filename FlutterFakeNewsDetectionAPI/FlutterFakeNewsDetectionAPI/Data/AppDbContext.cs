using FlutterFakeNewsDetectionAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace FlutterFakeNewsDetectionAPI.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }

        public DbSet<Prediction> Predictions { get; set; }
    }
}
