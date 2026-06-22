# Spec: Login & Password Recovery Pages

**Status:** Approved — ready for implementation  
**Relates to:** `admin-home.md` (authenticated landing), `architecture.md`, `conventions.md`

---

## Intent

Provide a secure login entry point for AIKER administrators. Users authenticate with email + password. A companion page lets users request a password reset link by email.

---

## Pages

### 1. Login

| Attribute | Value |
|---|---|
| URL | `/Account/Login` |
| Razor Page | `src/Pages/Account/Login.cshtml` + `Login.cshtml.cs` |
| Layout | `src/Pages/Shared/_Layout_Login.cshtml` |

### 2. Password Recovery

| Attribute | Value |
|---|---|
| URL | `/Account/RecoverPassword` |
| Razor Page | `src/Pages/Account/RecoverPassword.cshtml` + `RecoverPassword.cshtml.cs` |
| Layout | `src/Pages/Shared/_Layout_Login.cshtml` (same) |

---

## Layout — `_Layout_Login.cshtml`

Modeled on `Login.Master` (HTML reference). Key structural elements to reproduce:

- Preloader overlay (white, fades out on window load after 300 ms).
- Cookie-consent modal (`#modal-cookies`, dark background, bottom-left).
- Navbar: white background, AIKER logo linking to `/`, single nav item "Qué hace" → `/#what`.
- `@RenderBody()` slot between navbar and footer.
- Footer: dark (`bg-dark`), logo (white variant), mission paragraph, social links (Twitter, LinkedIn, Facebook, Instagram), divider, copyright, legal links (Términos, Privacidad, Cookies).
- Static assets referenced from `~/assets/` (CSS `quick-website.css`, JS libs: jQuery, Bootstrap bundle, svg-injector, feather-icons, `quick-website.js`).
- `feather.replace()` called after scripts.
- `<html lang="es">`, title: `AIKER by R:Solver | Inicio sesión | Mejorando el conocimiento humano con inteligencia artificial`.

---

## UI — Login Form

Modeled on `Login.aspx` (HTML reference). Centered card, vertically filling the viewport:

```
┌────────────────────────────────────┐
│  Acceso Administración             │
│  [error message — hidden by default] │
│                                    │
│  E-mail                            │
│  [user icon] [email input]         │
│                                    │
│  Contraseña          Recuperar contraseña →
│  [key icon]  [password input]      │
│                                    │
│  [ Iniciar Sesión  (full-width) ]  │
└────────────────────────────────────┘
```

- Container: `col-md-6 col-lg-5 col-xl-5`, card with shadow, `zindex-100`.
- Error label: hidden until login fails; shows inline above the form.
- "Recuperar contraseña" link → `/Account/RecoverPassword`.
- Submit button: Bootstrap `btn-primary btn-block`.

---

## UI — Password Recovery Form

Same layout shell. Card content:

```
┌────────────────────────────────────┐
│  Recuperar contraseña              │
│  Ingresa tu e-mail y te enviaremos │
│  un enlace para restablecer tu     │
│  contraseña.                       │
│                                    │
│  E-mail                            │
│  [user icon] [email input]         │
│                                    │
│  [ Enviar enlace  (full-width) ]   │
│                                    │
│  ← Volver al inicio de sesión      │
└────────────────────────────────────┘
```

- Success state: replaces the form with a confirmation message ("Revisa tu bandeja de entrada. Si el correo existe en el sistema, recibirás el enlace en breve.").
- Error state: inline message above form.
- "Volver al inicio de sesión" link → `/Account/Login`.

---

## Data Source — `AppUser` Table

**Connection string key:** `"DBServer"` (same as `AikerDbContext`).

Columns (from `DB/AIKER.Model.txt`):

| Column | Type | Notes |
|---|---|---|
| `ID` | int | PK |
| `OrganizationID` | int | FK |
| `CourseID` | int | FK |
| `Fullname` | string | Plain text |
| `Email` | string | Plain text |
| `Password` | string | SHA1 hex hash |
| `PasswordNeedsChanging` | bool | |
| `IsAdmin` | bool | |
| `IsActive` | bool | |
| `CreationDate` | datetime | |
| `ConfirmationToken` | datetime | |
| `LoginToken` | datetime | |
| `IsConfirmed` | bool | |
| `PasswordFailures` | int | |

---

## Security

### Password

- Stored as **SHA1 hex** (uppercase), matching the existing production scheme.
- `PasswordService.Hash(plain)` → `SHA1(UTF8(plain))` as uppercase hex string.
- `PasswordService.Verify(plain, stored)` → compare hashes.
- Never stored or logged in plaintext.

### Email & Fullname

- Plain text in the DB — no encryption at rest (migration deferred).

### Password Reset Token

- No token column exists in `AppUser` → use **ASP.NET Core `IDataProtector`** for stateless, time-limited, tamper-proof tokens.
- Token encodes the user's email, expires in 1 hour.
- No DB write needed for token generation; reset consumption page validates via DataProtection.

### Session / Authentication

- Use **ASP.NET Core cookie authentication** (`AddAuthentication().AddCookie()`).
- On successful login: create a `ClaimsPrincipal` with `NameIdentifier` = `AppUser.ID`, `Name` = decrypted `AppUser.Name`, `Email` = decrypted `AppUser.Email`.
- Sign in via `HttpContext.SignInAsync(...)`.
- Cookie name: `"AikerAuth"`, sliding expiration 8 hours, `HttpOnly`, `SameSite=Strict`.
- Logout: not in this spec (placeholder for future).
- Redirect after login: `/Admin/Home`.
- Unauthenticated access to `/Admin/**` → redirects to `/Account/Login`.

### Password Reset Flow

1. User submits email on RecoverPassword page.
2. Handler looks up `AppUser` by email (case-insensitive plain-text compare).
3. If found: generate a DataProtection token encoding the user's email (1-hour expiry).
4. Send email via SMTP (`SmtpEmailService`) with link: `/Account/ResetPassword?token={token}`.
5. Response is always the same success message regardless of whether the email exists (prevents user enumeration).
6. SMTP config read from `appsettings.json` keys: `NotificationServer`, `NotificationPort`, `NotificationSender`, `NotificationUser`, `NotificationPassword`, `NotificationSenderName`.

---

## CQRS Implementation

### Commands & Queries

| Name | Type | Purpose |
|---|---|---|
| `LoginCommand` | Command | Validate credentials, return user or null |
| `LoginCommandHandler` | Handler | Decrypt email, verify BCrypt hash |
| `RequestPasswordResetCommand` | Command | Generate reset token, send email |
| `RequestPasswordResetCommandHandler` | Handler | Lookup, token generation, email dispatch |

### DTOs

```csharp
LoginCommand { string Email; string Password; }
LoginResult   { bool Success; int? UserId; string? Name; string? Email; }

RequestPasswordResetCommand { string Email; }
```

### Entity

```csharp
// src/Domain/Entities/AppUser.cs
AppUser
{
    int Id
    int OrganizationId
    int CourseId
    string Fullname
    string Email
    string Password           // SHA1 hex
    bool PasswordNeedsChanging
    bool IsAdmin
    bool IsActive
    DateTime CreationDate
    DateTime? ConfirmationToken
    DateTime? LoginToken
    bool IsConfirmed
    int PasswordFailures
}
```

### Configuration

`AppUserConfiguration` (Fluent API) maps to `dbo.AppUser`, table name exact-match.

### DbContext addition

`AikerDbContext` gets a new `DbSet<AppUser> AppUsers`.

---

## Authentication Middleware

Add to `Program.cs`:

```csharp
builder.Services.AddAuthentication("AikerAuth")
    .AddCookie("AikerAuth", options => {
        options.LoginPath = "/Account/Login";
        options.Cookie.Name = "AikerAuth";
        options.Cookie.HttpOnly = true;
        options.Cookie.SameSite = SameSiteMode.Strict;
        options.SlidingExpiration = true;
        options.ExpireTimeSpan = TimeSpan.FromHours(8);
    });

// After UseRouting:
app.UseAuthentication();
app.UseAuthorization();
```

Protect Admin pages by adding `[Authorize]` to their page models (or via convention).

---

## Files to Create

| File | Purpose |
|---|---|
| `src/Pages/Account/Login.cshtml` | Login Razor Page view |
| `src/Pages/Account/Login.cshtml.cs` | Login page model |
| `src/Pages/Account/RecoverPassword.cshtml` | Password recovery view |
| `src/Pages/Account/RecoverPassword.cshtml.cs` | Recovery page model |
| `src/Pages/Shared/_Layout_Login.cshtml` | Login layout (from Login.Master) |
| `src/Domain/Entities/AppUser.cs` | Domain entity |
| `src/Infrastructure/Persistence/Configurations/AppUserConfiguration.cs` | Fluent API mapping |
| `src/Infrastructure/Security/PasswordService.cs` | SHA1 hash + verify helper |
| `src/Infrastructure/Email/IEmailService.cs` | Email service interface |
| `src/Infrastructure/Email/SmtpEmailService.cs` | SMTP implementation |
| `src/Application/Commands/LoginCommand.cs` | Command + DTO |
| `src/Application/Commands/LoginCommandHandler.cs` | Handler |
| `src/Application/Commands/RequestPasswordResetCommand.cs` | Command |
| `src/Application/Commands/RequestPasswordResetCommandHandler.cs` | Handler |

---

## Out of Scope for This Spec

- ResetPassword page (consuming the token link)
- User registration / onboarding
- Logout page
- Role-based authorization beyond "authenticated"
- Remember-me / persistent login
- Rate limiting / brute-force protection

---

## Decisions Recorded

| # | Decision |
|---|---|
| 1 | SHA1 hex (uppercase) for passwords — matches existing production scheme |
| 2 | Email and Fullname are plain text — encryption migration deferred |
| 3 | No reset token column → ASP.NET Core DataProtection for stateless 1-hour tokens |
| 4 | Response to password-reset request is always identical (prevents user enumeration) |
| 5 | Cookie auth (not JWT) — consistent with server-rendered Razor Pages |
| 6 | `/Account/` prefix (not `/Admin/`) — login is pre-auth, outside the admin area |
| 7 | SMTP via `NotificationServer/Port/Sender/User/Password/SenderName` config keys |
