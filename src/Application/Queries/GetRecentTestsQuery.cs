namespace AIKER2.Application.Queries;

public record GetRecentTestsQuery(string? SearchTerm);

public record ScheduledTestSummary(
    int Id,
    string Title,
    DateTime StartDate,
    DateTime EndDate,
    string CourseName,
    int NumberOfQuestions
);
