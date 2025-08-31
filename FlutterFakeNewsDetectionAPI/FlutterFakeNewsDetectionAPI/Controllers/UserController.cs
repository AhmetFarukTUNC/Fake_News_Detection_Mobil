using Microsoft.AspNetCore.Mvc;
using FlutterFakeNewsDetectionAPI.Data;
using FlutterFakeNewsDetectionAPI.Models;

using System.Linq;
using FlutterFakeNewsDetectionAPI.Data;
using FlutterFakeNewsDetectionAPI.Models;
using FlutterFakeNewsDetectionAPI.DTOs;

namespace FlutterFakeNewsDetectionAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserController(AppDbContext context)
        {
            _context = context;
        }

        // Kayıt
        [HttpPost("register")]
        public IActionResult Register([FromBody] User user)
        {
            if (_context.Users.Any(u => u.Email == user.Email))
                return BadRequest("Email zaten kayıtlı!");

            user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(user.PasswordHash);
            _context.Users.Add(user);
            _context.SaveChanges();
            return Ok("Kayıt başarılı!");
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            var dbUser = _context.Users.SingleOrDefault(u => u.Email == request.Email);
            if (dbUser == null || !BCrypt.Net.BCrypt.Verify(request.PasswordHash, dbUser.PasswordHash))
                return Unauthorized("Email veya şifre hatalı!");

            return Ok(new
            {
                Message = "Giriş başarılı!",
                User = new
                {
                    dbUser.Id,          // <-- Buraya UserId ekledik
                    dbUser.FirstName,
                    dbUser.LastName,
                    dbUser.Email
                    // PasswordHash'ı dönmek güvenlik sebebiyle önerilmez, kaldırabiliriz
                }
            });
        }


    }
}
