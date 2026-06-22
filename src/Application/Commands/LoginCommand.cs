namespace AIKER2.Application.Commands;

public record LoginCommand(string Email, string Password);

public record LoginResult(bool Success, int UserId = 0, string Fullname = "", string Email = "");
