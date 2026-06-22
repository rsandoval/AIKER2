using AIKER2.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace AIKER2.Application.Queries;

public class GetRecentTestsQueryHandler(AikerDbContext db)
{
    public async Task<List<ScheduledTestSummary>> HandleAsync(GetRecentTestsQuery query)
    {
        var hasSearch = !string.IsNullOrWhiteSpace(query.SearchTerm);
        var term = query.SearchTerm?.Trim() ?? string.Empty;

        var q = db.ScheduledTests
            .Include(t => t.Course)
            .AsQueryable();

        if (hasSearch)
        {
            q = q.Where(t =>
                EF.Functions.Like(t.Title, $"%{term}%") ||
                EF.Functions.Like(t.Course.Name, $"%{term}%"));
        }
        else
        {
            q = q.Take(8);
        }

        return await q
            .OrderByDescending(t => t.StartDate)
            .Select(t => new ScheduledTestSummary(
                t.Id,
                t.Title,
                t.StartDate,
                t.EndDate,
                t.Course.Name,
                t.NumberOfQuestions))
            .ToListAsync();
    }
}
