namespace FlutterFakeNewsDetectionAPI.Models
{
    public class User
    {
        public int Id { get; set; }
        public string FirstName { get; set; }   // AD
        public string LastName { get; set; }    // SOYAD
        public string Email { get; set; }       // E-MAİL
         

        public string PasswordHash { get; set; } // Şifre Hashlenmiş
    }
}
