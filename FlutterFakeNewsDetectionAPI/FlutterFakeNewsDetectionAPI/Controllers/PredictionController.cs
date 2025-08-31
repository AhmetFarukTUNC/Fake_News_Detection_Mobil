using Microsoft.AspNetCore.Mvc;

namespace FlutterFakeNewsDetectionAPI.Controllers
{
    using FlutterFakeNewsDetectionAPI.Data;
    using FlutterFakeNewsDetectionAPI.DTOs;
    using FlutterFakeNewsDetectionAPI.Models;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    using Newtonsoft.Json;

    [ApiController]
    [Route("api/[controller]")]
    public class PredictionController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly HttpClient _httpClient;

        public PredictionController(AppDbContext context, IHttpClientFactory httpClientFactory)
        {
            _context = context;
            _httpClient = httpClientFactory.CreateClient();
        }

        [HttpPost]
        public async Task<IActionResult> Predict([FromBody] PredictionRequest request)
        {
            if (string.IsNullOrWhiteSpace(request.Text))
                return BadRequest("Text is empty");

            // Flask API'ye istek at
            var response = await _httpClient.PostAsJsonAsync(
                "http://localhost:5000/predict",
                new { text = request.Text }
            );
            if (!response.IsSuccessStatusCode)
                return StatusCode((int)response.StatusCode, "Flask API error");

            var flaskResult = await response.Content.ReadAsStringAsync();
            dynamic result = JsonConvert.DeserializeObject(flaskResult);

            string rawPrediction = result.prediction.ToString();
            string prediction = rawPrediction == "0" ? "Fake News" :
                                rawPrediction == "1" ? "Real News" :
                                "Unknown";

            double? confidence = result.confidence;

            // DB'ye kaydet
            var predictionEntity = new Prediction
            {
                Text = request.Text,
                PredictionResult = prediction,
                Confidence = confidence,
                UserId = request.UserId // <-- UserId burada set ediliyor
            };

            _context.Predictions.Add(predictionEntity);
            await _context.SaveChangesAsync();

            return Ok(predictionEntity);
        }

        [HttpGet("{userId}")]
        public async Task<ActionResult<IEnumerable<Prediction>>> GetPredictions(int userId)
        {
            // Veritabanından sadece bu userId'ye ait kayıtları getir
            var predictions = await _context.Predictions
                                            .Where(p => p.UserId == userId)
                                            .ToListAsync();

            if (predictions == null || !predictions.Any())
            {
                return NotFound("Bu kullanıcıya ait kayıt bulunamadı.");
            }

            return Ok(predictions);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePrediction(int id)
        {
            var prediction = await _context.Predictions.FindAsync(id);

            if (prediction == null)
            {
                return NotFound(new { message = "Tahmin bulunamadı." });
            }

            _context.Predictions.Remove(prediction);
            await _context.SaveChangesAsync();

            return NoContent(); // 204 döner, başarılı silme
        }


    }

}
