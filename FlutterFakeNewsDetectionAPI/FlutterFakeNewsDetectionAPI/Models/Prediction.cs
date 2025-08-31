namespace FlutterFakeNewsDetectionAPI.Models
{
    public class Prediction
    {
        public int Id { get; set; }
        public string Text { get; set; } = string.Empty;
        public string PredictionResult { get; set; } = string.Empty;
        public double? Confidence { get; set; }
        public int UserId { get; set; } // Yeni alan
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }


}
