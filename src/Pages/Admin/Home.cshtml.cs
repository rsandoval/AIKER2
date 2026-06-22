using AIKER2.Application.Queries;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace AIKER2.Pages.Admin;

public class HomeModel(GetRecentTestsQueryHandler handler) : PageModel
{
    [BindProperty(SupportsGet = true)]
    public string? SearchTerm { get; set; }

    public List<ScheduledTestSummary> Tests { get; private set; } = [];

    public async Task OnGetAsync()
    {
        Tests = await handler.HandleAsync(new GetRecentTestsQuery(SearchTerm));
    }
}
