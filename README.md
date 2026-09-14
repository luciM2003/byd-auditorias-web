# Auditorías Yacopini BYD

Herramienta web para completar, firmar y editar las auditorías internas de
Ventas, Postventa, Administración e Imagen de Marca de Yacopini BYD.

Es una sola página estática (`index.html`, sin build ni dependencias de
Node) que guarda todo en una base de datos compartida en
[Supabase](https://supabase.com) para que cualquier auditor vea el mismo
historial, fotos y firmas.

## Puesta en marcha

1. Creá un proyecto gratuito en Supabase y corré el script SQL de
   `supabase/schema.sql` en el **SQL Editor** del proyecto (crea las tablas
   `auditorias`, `fotos` y `firmas`, y los permisos necesarios).
2. En **Project Settings → API** copiá el **Project URL** y la **anon
   public key**.
3. Abrí `index.html` y reemplazá, cerca del principio del `<script>`, estas
   dos líneas con esos valores:

   ```js
   var SUPABASE_URL = 'REEMPLAZAR_SUPABASE_URL';
   var SUPABASE_ANON_KEY = 'REEMPLAZAR_SUPABASE_ANON_KEY';
   ```

4. Publicá el sitio (Netlify, o cualquier hosting estático): no hay build
   step, el *publish directory* es la raíz del repo.

Si no se configuran las credenciales de Supabase, la app sigue funcionando
pero guarda los datos solo en el navegador de cada persona (sin compartir
entre auditores) — útil para probarla, no para uso real en el equipo.

## Funciones

- 4 auditorías (Ventas, Postventa, Administración, Imagen y Marca), 280
  ítems en total, cada uno con Cumple/No cumple, comentario y foto.
- Firma electrónica al finalizar; genera un PDF con los resultados,
  observaciones, fotos y la firma.
- Sección **Auditorías realizadas**: historial agrupado por mes.
- Sección **Editar**: corrige cualquier dato de una auditoría ya guardada,
  con guardado automático.
