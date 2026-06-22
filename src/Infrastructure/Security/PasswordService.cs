using System.Security.Cryptography;
using System.Text;

namespace AIKER2.Infrastructure.Security;

public static class PasswordService
{
    public static string Hash(string plainPassword)
    {
        var bytes = SHA1.HashData(Encoding.UTF8.GetBytes(plainPassword));
        return Convert.ToHexString(bytes); // uppercase hex, e.g. "DA39A3EE..."
    }

    public static bool Verify(string plainPassword, string storedHash)
        => Hash(plainPassword).Equals(storedHash, StringComparison.OrdinalIgnoreCase);
}
