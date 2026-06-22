using System.Security.Claims;
using AIKER2.Application.Commands;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace AIKER2.Pages.Account;

public class LoginModel(LoginCommandHandler handler) : PageModel
{
    [BindProperty]
    public string Email { get; set; } = string.Empty;

    [BindProperty]
    public string Password { get; set; } = string.Empty;

    public string? ErrorMessage { get; private set; }

    public IActionResult OnGet()
    {
        if (User.Identity?.IsAuthenticated == true)
            return RedirectToPage("/Admin/Home");

        return Page();
    }

    public async Task<IActionResult> OnPostAsync()
    {
        if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
        {
            ErrorMessage = "Por favor ingresa tu e-mail y contraseña.";
            return Page();
        }

        var result = await handler.HandleAsync(new LoginCommand(Email, Password));

        if (!result.Success)
        {
            ErrorMessage = "E-mail o contraseña incorrectos.";
            return Page();
        }

        var claims = new List<Claim>
        {
            new(ClaimTypes.NameIdentifier, result.UserId.ToString()),
            new(ClaimTypes.Name, result.Fullname),
            new(ClaimTypes.Email, result.Email)
        };

        var identity = new ClaimsIdentity(claims, "AikerAuth");
        var principal = new ClaimsPrincipal(identity);

        await HttpContext.SignInAsync("AikerAuth", principal);

        return RedirectToPage("/Admin/Home");
    }
}
