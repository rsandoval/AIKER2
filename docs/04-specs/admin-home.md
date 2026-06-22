# Spec: Admin Home Page

**URL:** `/Admin/Home`  
**Status:** Approved — ready for implementation  
**Relates to:** `architecture.md` (Application Layer, Infrastructure), `domain.md` (ScheduledTest), `conventions.md` (CQRS, Razor Pages naming)

---

## Intent

First landing page for an authenticated admin user. Provides immediate visibility into the most recent tests and a way to locate older ones by title.

---

## URL & Routing

- Path: `/Admin/Home`
- Razor Page: `src/Pages/Admin/Home.cshtml` + `Home.cshtml.cs`
- Layout: `src/Pages/Shared/_Layout_Admin.cshtml` 

---

## Layout

`_Layout_Admin.cshtml` is created using an ASPX layout page as reference "Admin.master"
`Home.cshtml` layout uses an ASPX page as reference "AdminTests.aspx"

---

## Data Source

**Table:** `dbo.ScheduledTest`

Relevant columns for this view:

| Column | Type | Used for |
|---|---|---|
| `ID` | int | Row key, future navigation |
| `Title` | varchar(50) | Display + search |
| `StartDate` | datetime | Display, sort descending |
| `EndDate` | datetime | Display |
| `CourseID` | int | Join to `Course.Name` |
| `NumberOfQuestions` | int | Display |
| `MaxScore` | float | Display |
| `ScoreUnit` | varchar | Display |
| `TakeOnline` | bit | Display (badge) |

Join: `INNER JOIN Course ON Course.ID = ScheduledTest.CourseID` to show the course name.

**Connection string key:** `"DBServer"` from `appsettings.json`.

---

## Behavior

### Default state (page load)

- Queries the **8 most recent** `ScheduledTest` rows where `EndDate >= today`, ordered by `StartDate DESC`.
- Displays results in a table (see layout below).
- Search box is empty.

### Search

- User types in the search box and submits (button or Enter).
- Query filters `ScheduledTest` where `Title LIKE '%{term}%'` OR `Course.Name LIKE '%{term}%'`, still ordered by `StartDate DESC`.
- Search is **not** limited to active tests — it searches the full historical dataset.
- No result limit when searching (show all matches).
- If no matches: display a "No se encontraron pruebas" message in place of the table.
- Search term is preserved in the input box after submission.

### No data state

- If the database returns 0 rows on load (edge case): display "No hay pruebas registradas."

---

## UI Elements

### Search box

```
[ Search input — placeholder: "Buscar prueba por nombre..." ] [ Buscar ]
```

- On load: empty, not submitted.
- Submits via GET to the same page with `?search={term}`.
- Clear/reset: user clears the input and submits empty → reverts to default 8-row view.

### Results table

Columns:

| # | Column header | Source |
|---|---|---|
| 1 | Fecha inicio | `StartDate` — formatted `dd/MM/yyyy` |
| 2 | Fecha término | `EndDate` — formatted `dd/MM/yyyy` |
| 3 | Prueba | `Title` |
| 4 | Curso | `Course.Name` |
| 5 | Preguntas | `NumberOfQuestions` |
| 6 | Puntaje máx | `MaxScore` + `ScoreUnit` (e.g. "10 pts") |
| 7 | Online | `TakeOnline` → "Sí" / "No" |

No pagination in this spec. Sorting is fixed (StartDate DESC).

---

## CQRS Implementation

### Query

```
GetRecentTestsQuery
  SearchTerm: string?   // null = no filter, 8-row default
```

### Handler

```
GetRecentTestsQueryHandler
  → Returns: List<ScheduledTestSummary>
```

### DTO

```csharp
ScheduledTestSummary
{
    int Id
    string Title
    DateTime StartDate
    DateTime EndDate
    string CourseName
    int NumberOfQuestions
    double MaxScore
    string ScoreUnit
    bool TakeOnline
}
```

### Data access

- **EF Core** with SQL Server provider, configured in `Infrastructure`.
- `AikerDbContext` registered in `Program.cs`, reading connection string key `"DBServer"`.
- Entities mapped via Fluent API only (no Data Annotations), per conventions.
- `ScheduledTest` and `Course` entities modeled to cover the columns needed by this and future specs.
- Handler receives `AikerDbContext` via constructor injection and queries using LINQ.

---

## Files to Create

| File | Purpose |
|---|---|
| `src/Pages/Admin/Home.cshtml` | Razor Page view |
| `src/Pages/Admin/Home.cshtml.cs` | Page model |
| `src/Pages/Shared/_Layout_Admin.cshtml` | Stub admin layout |
| `src/Application/Queries/GetRecentTestsQuery.cs` | Query definition + DTO |
| `src/Application/Queries/GetRecentTestsQueryHandler.cs` | Handler with LINQ via EF Core |
| `src/Infrastructure/Persistence/AikerDbContext.cs` | EF Core DbContext |
| `src/Infrastructure/Persistence/Configurations/ScheduledTestConfiguration.cs` | Fluent API mapping for ScheduledTest |
| `src/Infrastructure/Persistence/Configurations/CourseConfiguration.cs` | Fluent API mapping for Course |
| `src/Domain/Entities/ScheduledTest.cs` | Domain entity |
| `src/Domain/Entities/Course.cs` | Domain entity |

---

## Out of Scope for This Spec

- Authentication / authorization enforcement (no login flow yet — page is accessible directly)
- Pagination of search results
- Clicking a row (navigation to test detail)
- Creating or editing tests
- Admin layout styling and navigation

---

## Decisions Recorded

| # | Decision |
|---|---|
| 1 | Default 8-row view shows only tests where `EndDate >= today` (active/recent only) |
| 2 | Search filters on both `Title` and `Course.Name`; searches full historical dataset (no date filter) |
| 3 | EF Core with SQL Server provider, Fluent API configuration, set up now for all future specs |
