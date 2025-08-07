const CACHE_NAME = 'sekolah-app-cache-v2';
const ASSETS = [
  '/',
  '/index.html',
  '/app.html',
  '/manifest.webmanifest',
  '/NavIcon.png',
  '/LogoTKJ3.png'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(ASSETS))
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) => Promise.all(
      keys.map((key) => key !== CACHE_NAME && caches.delete(key))
    ))
  );
});

self.addEventListener('fetch', (event) => {
  const { request } = event;
  if (request.mode === 'navigate') {
    event.respondWith(
      (async () => {
        try {
          return await fetch(request);
        } catch (_) {
          const url = new URL(request.url);
          if (url.pathname.endsWith('/app.html')) {
            const cachedApp = await caches.match('/app.html');
            if (cachedApp) return cachedApp;
          }
          return caches.match('/index.html');
        }
      })()
    );
    return;
  }
  event.respondWith(
    caches.match(request).then((cached) => cached || fetch(request))
  );
});