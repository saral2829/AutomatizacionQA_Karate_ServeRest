<h1>Automatización ServeRest – API (Karate)</h1>
<p class="note">Suite de pruebas API sobre <code>https://serverest.dev</code> usando Karate + JUnit 5 + Maven.</p>

<h2>Requisitos</h2>
<ul>
  <li>Java 11+ (probado con <strong>JDK 21</strong>).</li>
  <li>Maven 3.8+.</li>
</ul>

<h2>Configuración</h2>
<ol>
  <li>Clona o descomprime el proyecto.</li>
  <li>(Opcional) Ajusta el endpoint en <code>karate-config.js</code>:
    <pre><code>// src/test/java/karate-config.js  (o src/test/resources/karate-config.js)
function fn() {
  var config = {};
  // Permite override desde CLI: -DbaseUrl=https://&lt;otro&gt;
  config.baseUrl = karate.properties['baseUrl'] || 'https://serverest.dev';
  return config;
}
</code></pre>
  </li>
</ol>

<h3>Etiquetas usadas</h3>
<div class="chips">
  <span class="chip">@RegisterUser</span>
  <span class="chip">@UpdateUser</span>
  <span class="chip">@SearchById</span>
  <span class="chip">@ListUsers</span>
  <span class="chip">@DeleteUser</span>
  <span class="chip">@smoke</span>
</div>
<p class="note">La etiqueta <code>@smoke</code> marca solo los escenarios felices.</p>

<h2>▶️ Ejecución</h2>

<h3>Opción 1 — Todo el suite (paralelo)</h3>
<p>Ejecuta todos los <code>.feature</code> bajo <code>resources/feature/users</code> vía el runner JUnit:</p>
<pre><code>mvn -Dtest=runner.RunnerTest test
</code></pre>

<h3>Opción 2 — Por etiqueta</h3>
<pre><code># Solo smoke (escenarios felices)
mvn -Dtest=runner.RunnerTest -Dkarate.options="--tags @smoke" test

# Un endpoint específico
mvn -Dtest=runner.RunnerTest -Dkarate.options="--tags @UpdateUser" test
</code></pre>

<h3>Opción 3 — Un feature específico</h3>
<pre><code>mvn -Dtest=runner.RunnerTest -Dkarate.options="classpath:resources/feature/users/SearchUserId.feature" test
</code></pre>

<h3>Perfiles / Entornos (opcional)</h3>
<pre><code>mvn -Dtest=runner.RunnerTest -Dkarate.env=qa -DbaseUrl=https://serverest.dev test
</code></pre>

<h3>Desde IntelliJ (opcional)</h3>
<ol>
  <li>Click derecho en <code>runner/RunnerTest.java</code> → <span class="kbd">Run 'RunnerTest'</span>.</li>
  <li>Para pasar opciones:
    <ul>
      <li><em>Run/Debug Configurations → JUnit (RunnerTest) → VM options</em>:
        <pre><code>-Dkarate.options="--tags @smoke"
</code></pre>
      </li>
      <li>O crea una config <strong>Maven</strong> con:
        <pre><code>test -Dtest=runner.RunnerTest -Dkarate.options="--tags @smoke"
</code></pre>
      </li>
    </ul>
  </li>
</ol>

