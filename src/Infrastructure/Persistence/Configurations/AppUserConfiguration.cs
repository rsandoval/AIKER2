using AIKER2.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AIKER2.Infrastructure.Persistence.Configurations;

public class AppUserConfiguration : IEntityTypeConfiguration<AppUser>
{
    public void Configure(EntityTypeBuilder<AppUser> builder)
    {
        builder.ToTable("AppUser");
        builder.HasKey(u => u.Id);
        builder.Property(u => u.OrganizationId).HasColumnName("OrganizationID");
        builder.Property(u => u.CourseId).HasColumnName("CourseID");
        builder.Property(u => u.Fullname).HasColumnType("varchar(200)").IsRequired();
        builder.Property(u => u.Email).HasColumnType("varchar(200)").IsRequired();
        builder.Property(u => u.Password).HasColumnType("varchar(100)").IsRequired();
    }
}
