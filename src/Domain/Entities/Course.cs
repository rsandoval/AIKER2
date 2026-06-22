namespace AIKER2.Domain.Entities;

public class Course
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public int OrganizationId { get; set; }

    public ICollection<ScheduledTest> ScheduledTests { get; set; } = [];
}
