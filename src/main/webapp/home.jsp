<main>
    <!-- Hero Section -->
    <section class="hero">
        <h1>Mobile Phone Information Query System</h1>
        <p>Instantly search global phone models—brand, release date, dimensions, specs and more.</p>
        <button class="btn primary">Get Started</button>
    </section>

    <!-- Core Features Overview -->
    <section style="background-color: #FF6F61; color: #fff; padding: 200px 20px; text-align: center;">
        <h2>Core Features</h2>
</section>

    <!-- User Guide -->
    <section style="background-color: #6B5B95; padding: 150px 20px; color: #fff;">
    <h2 style="text-align: center;">User Guide</h2>
</section>

    <!-- Technical Architecture -->
    <section style="background-color: #88B04B; padding: 150px 20px; color: #fff; text-align: center;">
    <h2>Technical Architecture</h2>
</section>

    <!-- Code Example -->
    <section class="code-snippet">
<pre><code>
// PhoneDAO.java — multi-criteria search example
public List&lt;Phone&gt; findByCriteria(String brand, int year, String sizeRange) throws SQLException {
    String sql = "SELECT * FROM phones WHERE brand = ? AND release_year >= ? AND size BETWEEN ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, brand);
        ps.setInt(2, year);
        ps.setString(3, sizeRange);
        ResultSet rs = ps.executeQuery();
        // … map results …
    }
    return list;
}
</code></pre>
    </section>

    <!-- Footer -->
    <section class="footer">
        <p>© 2025 Mobile Phone Query System. Powered by Java &amp; MySQL — fast, reliable, and feature-rich.</p>
    </section>
</main>