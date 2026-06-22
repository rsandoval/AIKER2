using System.Net;
using System.Net.Mail;

namespace AIKER2.Infrastructure.Email;

public class SmtpEmailService(IConfiguration config) : IEmailService
{
    public async Task SendAsync(string toAddress, string subject, string htmlBody)
    {
        var host = config["NotificationServer"]!;
        var port = int.Parse(config["NotificationPort"]!);
        var sender = config["NotificationSender"]!;
        var user = config["NotificationUser"]!;
        var password = config["NotificationPassword"]!;
        var senderName = config["NotificationSenderName"]!;

        using var client = new SmtpClient(host, port)
        {
            Credentials = new NetworkCredential(user, password),
            EnableSsl = false
        };

        var message = new MailMessage
        {
            From = new MailAddress(sender, senderName),
            Subject = subject,
            Body = htmlBody,
            IsBodyHtml = true
        };
        message.To.Add(toAddress);

        await client.SendMailAsync(message);
    }
}
