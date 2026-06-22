using AIKER2.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AIKER2.Infrastructure.Persistence.Configurations;

public class ScheduledTestConfiguration : IEntityTypeConfiguration<ScheduledTest>
{
    public void Configure(EntityTypeBuilder<ScheduledTest> builder)
    {
        builder.ToTable("ScheduledTest");
        builder.HasKey(t => t.Id);
        builder.Property(t => t.Title).HasColumnType("varchar(50)").IsRequired();
        builder.Property(t => t.ScoreUnit).HasColumnType("varchar(5)").IsRequired();
        builder.Property(t => t.HeaderText).HasColumnType("varchar(1500)").IsRequired();
        builder.Property(t => t.CourseId).HasColumnName("CourseID");

        builder.HasOne(t => t.Course)
               .WithMany(c => c.ScheduledTests)
               .HasForeignKey(t => t.CourseId);
    }
}
