using AIKER2.Infrastructure.Email;
using AIKER2.Infrastructure.Persistence;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.EntityFrameworkCore;

namespace AIKER2.Application.Commands;

public class RequestPasswordResetCommandHandler(
    AikerDbContext db,
    IDataProtectionProvider dataProtection,
    IEmailService email)
{
    private static readonly TimeSpan TokenLifetime = TimeSpan.FromHours(1);

    public async Task HandleAsync(RequestPasswordResetCommand command)
    {
        var inputEmail = command.Email.Trim();
        var user = await db.AppUsers
            .FirstOrDefaultAsync(u =>
                u.Email == inputEmail &&
                u.IsActive &&
                u.IsConfirmed);

        // Always respond neutrally — don't reveal whether the email exists
        if (user is null)
            return;

        var protector = dataProtection
            .CreateProtector("AIKER2.PasswordReset")
            .ToTimeLimitedDataProtector();

        var token = protector.Protect(user.Email, lifetime: TokenLifetime);
        var encodedToken = Uri.EscapeDataString(token);
        var link = $"{command.BaseUrl}/Account/ResetPassword?token={encodedToken}";

        var subject = "Recuperar contraseña — AIKER";
        var body = $"""
            <p>Hola {user.Fullname},</p>
            <p>Recibimos una solicitud para restablecer tu contraseña en AIKER.</p>
            <p><a href="{link}">Haz clic aquí para restablecer tu contraseña</a></p>
            <p>Este enlace es válido por 1 hora. Si no solicitaste este cambio, ignora este correo.</p>
            <p>— AIKER by R:Solver</p>
            """;

        await email.SendAsync(user.Email, subject, body);
    }
}
