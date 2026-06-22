using AIKER2.Domain.Entities;
using AIKER2.Infrastructure.Persistence.Configurations;
using Microsoft.EntityFrameworkCore;

namespace AIKER2.Infrastructure.Persistence;

public class AikerDbContext(DbContextOptions<AikerDbContext> options) : DbContext(options)
{
    public DbSet<Course> Courses => Set<Course>();
    public DbSet<ScheduledTest> ScheduledTests => Set<ScheduledTest>();
    public DbSet<AppUser> AppUsers => Set<AppUser>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfiguration(new CourseConfiguration());
        modelBuilder.ApplyConfiguration(new ScheduledTestConfiguration());
        modelBuilder.ApplyConfiguration(new AppUserConfiguration());
    }
}
