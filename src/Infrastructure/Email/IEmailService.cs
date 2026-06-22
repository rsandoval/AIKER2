namespace AIKER2.Infrastructure.Email;

public interface IEmailService
{
    Task SendAsync(string toAddress, string subject, string htmlBody);
}
