'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "edc86d07c503992fb8bde96cef0911bc",
"icon.png": "299b3061eca165c9ffda86008af9f581",
"index.html": "62c7a3da7e229228a5d39cf930804321",
"/": "62c7a3da7e229228a5d39cf930804321",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "869e70df94f10bd6dc79dfbcc1ff6cc4",
"assets/assets/images/6.jpeg": "1d046e022e72aff90504d1e6fda3e865",
"assets/assets/images/pixelinsciences.jfif": "aad95dc6f92054c715186e83d0ac6704",
"assets/assets/images/mvr_constructions.jfif": "fb54d0e56def370a9610814692f6ffca",
"assets/assets/images/mallareddy.png": "150b01d99c3d47576bc5a58d1a50300d",
"assets/assets/images/Claim-management.png": "a006a17ac420858a5c948614718294c1",
"assets/assets/images/Attendance-management.png": "270bcb9074ab0f6455e050a891b96de3",
"assets/assets/images/1.jpeg": "1333c6aa0ec9f1d42d3fbff048405e2b",
"assets/assets/images/varahi.webp": "5504868f8b4af38fb99c8f0c41711214",
"assets/assets/images/Payroll-management.png": "36de2c13adf9fa33f35be492674af4cf",
"assets/assets/images/pms_card_bg.png": "1eecdfa39569e9bcd4af45fa33637c6b",
"assets/assets/images/4.jpeg": "b04fe3ffc31398b0f1b66dad170beaf4",
"assets/assets/images/accounting_card_bg.png": "c06c28abc194f65878751cc5ab5c6035",
"assets/assets/images/crm_card_bg.png": "5ccb393db996c8d607c18a59039c1f30",
"assets/assets/images/hrms_card_bg.png": "83c75dc7eaafdf12e9c4083e4c8e26d4",
"assets/assets/images/sribalajitechno.png": "e117cecaf5bb84e0a309938617513fde",
"assets/assets/images/elite_bridge.png": "46b756e821894fc8f1dd7509dd179dbc",
"assets/assets/images/Employee-Management.png": "11423a01cb774930329598ae8c8d13a1",
"assets/assets/images/2.jpeg": "c39f6251bcc1f9f73d7dcb834080f3c1",
"assets/assets/images/lakshmi_toyata.png": "fbd09718cf43ebb7899bbfdc7f1be6c4",
"assets/assets/images/inventory_card_bg.png": "26aea3e96130baa4450184fcb004a85f",
"assets/assets/images/Leave-Mangement.png": "a3b987056e82f8b23ba88074f80b5748",
"assets/assets/images/3.jpeg": "2e6c603f3b23c910278cf9679599c19d",
"assets/assets/images/santhosh_maruthi.jfif": "8eb3ce09681c4def283fe2a61d7c9582",
"assets/assets/images/5.jpeg": "40d766d1bcb2b082fe726c702ff8c9e8",
"assets/assets/images/3tinfotech.png": "2a349169b1bf1efbc9b498af45c9597b",
"assets/assets/images/srividya.jfif": "f4d8e96d7d9e08d094d97a1a43b0f59f",
"assets/assets/images/prutvi_toyata.jfif": "92aa8094629d4aaa903ccbaf9e216055",
"assets/assets/fonts/Poppins-Light.ttf": "3352653dedd571bbc490c8be132b38cd",
"assets/assets/fonts/Poppins-Medium.ttf": "a4e11dda40531debd374e4c8b1dcc7f4",
"assets/assets/fonts/Poppins-SemiBold.ttf": "e63b93dfac2600782654e2b87910d681",
"assets/assets/fonts/Poppins-Regular.ttf": "731a28a413d642522667a2de8681ff35",
"assets/assets/fonts/Poppins-Bold.ttf": "7940efc40d8e3b477e16cc41b0287139",
"assets/fonts/MaterialIcons-Regular.otf": "2cfb77d6a5f4eb3404d064d72eb99353",
"assets/NOTICES": "2da34721587d6e6ecbe68dd7ca45da77",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "f31db6d43fda750db83e476da7fb1d55",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "c0f60d9f9c735538ba357081d81d2376",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "b2703f18eee8303425a5342dba6958db",
"assets/FontManifest.json": "9525295745f0e2565f1f7608ec5669ca",
"assets/AssetManifest.bin": "b02fc65ec18528e19b4296751aa23564",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "378a6164d6e32562d81a03f3c0a7076e",
"version.json": "30194d7d2daf9ae92dccd3f3861c3cf7",
"main.dart.js": "090d1458a947857149f9f508670a5708"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
