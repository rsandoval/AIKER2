using AIKER2.Infrastructure.Persistence;
using AIKER2.Infrastructure.Security;
using Microsoft.EntityFrameworkCore;

namespace AIKER2.Application.Commands;

public class LoginCommandHandler(AikerDbContext db)
{
    public async Task<LoginResult> HandleAsync(LoginCommand command)
    {
        var email = command.Email.Trim();
        var user = await db.AppUsers
            .FirstOrDefaultAsync(u =>
                u.Email == email &&
                u.IsActive &&
                u.IsConfirmed);

        if (user is null || !PasswordService.Verify(command.Password, user.Password))
            return new LoginResult(false);

        return new LoginResult(true, user.Id, user.Fullname, user.Email);
    }
}
