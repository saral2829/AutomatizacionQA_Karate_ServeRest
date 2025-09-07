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
  <span class="chip">@negativo</span>
</div>
<p class="note">La etiqueta <code>@smoke</code> marca solo los escenarios felices.</p>
<p class="note">La etiqueta <code>@negativo</code> marca solo los escenarios con error</p>

<h2>▶️ Ejecución</h2>

<h3>Opción 1 — Todo el suite (paralelo)</h3>
<p>Ejecuta todos los <code>.feature</code> bajo <code>resources/feature/users</code> vía el runner JUnit:</p>
<pre><code>mvn --% -Dtest=runner.RunnerTest test
</code></pre>
<img width="1913" height="424" alt="image" src="https://github.com/user-attachments/assets/7e42dc67-96c9-43a8-8774-3673132d54cb" />

<h3>Opción 2 — Por etiqueta</h3>
<pre><code># Solo escenarios felices @smoke
mvn --% -Dtest=runner.RunnerTest -Dkarate.options="--tags @smoke" test</code></pre>
<img width="1913" height="424" alt="image" src="./img/smokeScenario.jpeg" />
<img width="1913" height="424" alt="image" src="./img/smokeRegisterUser.jpeg" />
# Un endpoint específico
mvn --% -Dtest=runner.RunnerTest -Dkarate.options="--tags @UpdateUser" test
</code></pre>
<img width="1913" height="424" alt="image" src="./img/featureUpdateUser.jpeg" />
<img width="1913" height="424" alt="image" src="./img/UpdateUser.jpeg" />
<h3>Opción 3 — Un feature específico</h3>
<pre><code>mvn --% -Dtest=runner.RunnerTest -Dkarate.options="classpath:resources/feature/users/SearchUserId.feature" test
</code></pre>

<img width="1913" height="424" alt="image" src="./img/FeatureSpecific.jpeg" />
<img width="1913" height="424" alt="image" src="./img/SearchId.jpeg" />




