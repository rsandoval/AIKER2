namespace AIKER2.Domain.Entities;

public class AppUser
{
    public int Id { get; set; }
    public int OrganizationId { get; set; }
    public int CourseId { get; set; }
    public string Fullname { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public bool PasswordNeedsChanging { get; set; }
    public bool IsAdmin { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreationDate { get; set; }
    public DateTime? ConfirmationToken { get; set; }
    public DateTime? LoginToken { get; set; }
    public bool IsConfirmed { get; set; }
    public int PasswordFailures { get; set; }
}
