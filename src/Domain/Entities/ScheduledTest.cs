namespace AIKER2.Domain.Entities;

public class ScheduledTest
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public int NumberOfQuestions { get; set; }
    public int CourseId { get; set; }
    public double MaxScore { get; set; }
    public string ScoreUnit { get; set; } = string.Empty;
    public bool TakeOnline { get; set; }
    public string HeaderText { get; set; } = string.Empty;

    public Course Course { get; set; } = null!;
}
