using AIKER2.Application.Commands;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace AIKER2.Pages.Account;

public class RecoverPasswordModel(RequestPasswordResetCommandHandler handler) : PageModel
{
    [BindProperty]
    public string Email { get; set; } = string.Empty;

    public bool Sent { get; private set; }

    public string? ErrorMessage { get; private set; }

    public void OnGet() { }

    public async Task<IActionResult> OnPostAsync()
    {
        if (string.IsNullOrWhiteSpace(Email))
        {
            ErrorMessage = "Por favor ingresa tu e-mail.";
            return Page();
        }

        var baseUrl = $"{Request.Scheme}://{Request.Host}";

        try
        {
            await handler.HandleAsync(new RequestPasswordResetCommand(Email, baseUrl));
        }
        catch
        {
            // Swallow errors — never reveal whether email exists or SMTP failed
        }

        Sent = true;
        return Page();
    }
}
