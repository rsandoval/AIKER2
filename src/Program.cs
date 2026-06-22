using AIKER2.Application.Commands;
using AIKER2.Application.Queries;
using AIKER2.Infrastructure.Email;
using AIKER2.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddRazorPages();

builder.Services.AddDbContext<AikerDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DBServer")));

builder.Services.AddDataProtection();

builder.Services.AddAuthentication("AikerAuth")
    .AddCookie("AikerAuth", options =>
    {
        options.LoginPath = "/Account/Login";
        options.Cookie.Name = "AikerAuth";
        options.Cookie.HttpOnly = true;
        options.Cookie.SameSite = SameSiteMode.Strict;
        options.SlidingExpiration = true;
        options.ExpireTimeSpan = TimeSpan.FromHours(8);
    });

builder.Services.AddScoped<GetRecentTestsQueryHandler>();
builder.Services.AddScoped<LoginCommandHandler>();
builder.Services.AddScoped<RequestPasswordResetCommandHandler>();
builder.Services.AddScoped<IEmailService, SmtpEmailService>();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
app.MapStaticAssets();
app.MapRazorPages().WithStaticAssets();

app.Run();
