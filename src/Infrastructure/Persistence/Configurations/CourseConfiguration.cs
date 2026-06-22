using AIKER2.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AIKER2.Infrastructure.Persistence.Configurations;

public class CourseConfiguration : IEntityTypeConfiguration<Course>
{
    public void Configure(EntityTypeBuilder<Course> builder)
    {
        builder.ToTable("Course");
        builder.HasKey(c => c.Id);
        builder.Property(c => c.Name).HasColumnType("varchar(50)").IsRequired();
        builder.Property(c => c.OrganizationId).HasColumnName("OrganizationID");
    }
}
