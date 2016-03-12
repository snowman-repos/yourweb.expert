/* your-web-expert : 2.0.0 : Sat Mar 12 2016 15:28:35 GMT+0800 (CST) */

(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
"use strict";
var clearOldCaches, imagesCacheName, pagesCacheName, stashInCache, staticCacheName, trimCache, updateStaticCache, version;

version = "v1.01::";

staticCacheName = version + "static";

pagesCacheName = version + "pages";

imagesCacheName = version + "images";

updateStaticCache = function() {
  return caches.open(staticCacheName).then(function(cache) {
    return cache.addAll(["/scripts/main.min.js", "/styles/main.min.css", "/images/darryl-snow.jpg", "/images/clean-code.png", "/images/family.jpg", "/images/icon.png", "/images/twitter-bg.png", "/images/twitter-bg.png", "/images/fullweb-logo.svg"]);
  });
};

stashInCache = function(cacheName, request, response) {
  return caches.open(cacheName).then(function(cache) {
    return cache.put(request, response);
  });
};

trimCache = function(cacheName, maxItems) {
  return caches.open(cacheName).then(function(cache) {
    return cache.keys().then(function(keys) {
      if (keys.length > maxItems) {
        return cache["delete"](keys[0]).then(trimCache(cacheName, maxItems));
      }
    });
  });
};

clearOldCaches = function() {
  return caches.keys().then(function(keys) {
    return Promise.all(keys.filter(function(key) {
      return key.indexOf(version) !== 0;
    })).map(function(key) {
      return caches["delete"](key);
    });
  });
};

self.addEventListener("install", function(event) {
  return event.waitUntil(updateStaticCache().then(function() {
    return self.skipWaiting();
  }));
});

self.addEventListener("activate", function(event) {
  return event.waitUntil(clearOldCaches().then(function() {
    return self.clients.claim();
  }));
});

self.addEventListener("message", function(event) {
  if (event.data.command === "trimCaches") {
    trimCache(pagesCacheName, 35);
    return trimCache(imagesCacheName, 20);
  }
});

self.addEventListener("fetch", function(event) {
  var request, url;
  request = event.request;
  url = new URL(request.url);
  if (url.origin !== location.origin) {
    return;
  }
  if (request.method !== "GET") {
    event.respondWith(fetch(request)["catch"](function() {
      return caches.match("/offline");
    }));
  }
  if (request.headers.get("Accept").indexOf("text/html") !== -1) {
    if (request.mode !== "navigate") {
      request = new Request(url, {
        method: "GET",
        headers: request.headers,
        mode: request.mode,
        credentials: request.credentials,
        redirect: request.redirect
      });
    }
    event.respondWith(fetch(request).then(function(response) {
      var copy;
      copy = response.clone();
      stashInCache(pagesCacheName, request, copy);
      return response;
    }))["catch"](function() {
      return caches.match(request).then(function(response) {
        return response || caches.match("/offline");
      });
    });
  }
  return event.respondWith(caches.match(request).then(function(response) {
    return response || fetch(request).then(function(response) {
      var copy;
      if (request.headers.get("Accept").indexOf("image") !== -1) {
        copy = response.clone();
        stashInCache(imagesCacheName, request, copy);
      }
      return response;
    })["catch"](function() {
      if (request.headers.get('Accept').indexOf('image') !== -1) {
        return new Response("<svg role='img' aria-labelledby='offline-title' viewBox='0 0 400 300' xmlns='http://www.w3.org/2000/svg'><title id='offline-title'>Offline</title><g fill='none' fill-rule='evenodd'><path fill='#D8D8D8' d='M0 0h400v300H0z'/><text fill='#9B9B9B' font-family='Helvetica Neue,Arial,Helvetica,sans-serif' font-size='72' font-weight='bold'><tspan x='93' y='172'>offline</tspan></text></g></svg>", {
          headers: {
            "Content-Type": "image/svg+xml"
          }
        });
      }
    });
  }));
});


},{}]},{},[1])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvZGFycnlsL0RvY3VtZW50cy9naXQveW91cndlYi5leHBlcnQvY2xpZW50L3NyYy9jb2ZmZWVzY3JpcHQvc2VydmljZS13b3JrZXIuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUE7QUFBQSxJQUFBOztBQUNBLE9BQUEsR0FBVTs7QUFDVixlQUFBLEdBQWtCLE9BQUEsR0FBVTs7QUFDNUIsY0FBQSxHQUFpQixPQUFBLEdBQVU7O0FBQzNCLGVBQUEsR0FBa0IsT0FBQSxHQUFVOztBQUU1QixpQkFBQSxHQUFvQixTQUFBO1NBRW5CLE1BQU0sQ0FBQyxJQUFQLENBQVksZUFBWixDQUNBLENBQUMsSUFERCxDQUNNLFNBQUMsS0FBRDtXQUVMLEtBQUssQ0FBQyxNQUFOLENBQWEsQ0FDWixzQkFEWSxFQUVaLHNCQUZZLEVBR1oseUJBSFksRUFJWix3QkFKWSxFQUtaLG9CQUxZLEVBTVosa0JBTlksRUFPWix3QkFQWSxFQVFaLHdCQVJZLEVBU1osMEJBVFksQ0FBYjtFQUZLLENBRE47QUFGbUI7O0FBaUJwQixZQUFBLEdBQWUsU0FBQyxTQUFELEVBQVksT0FBWixFQUFxQixRQUFyQjtTQUVkLE1BQU0sQ0FBQyxJQUFQLENBQVksU0FBWixDQUFzQixDQUFDLElBQXZCLENBQTRCLFNBQUMsS0FBRDtXQUUzQixLQUFLLENBQUMsR0FBTixDQUFVLE9BQVYsRUFBbUIsUUFBbkI7RUFGMkIsQ0FBNUI7QUFGYzs7QUFPZixTQUFBLEdBQVksU0FBQyxTQUFELEVBQVksUUFBWjtTQUVYLE1BQU0sQ0FBQyxJQUFQLENBQVksU0FBWixDQUFzQixDQUFDLElBQXZCLENBQTRCLFNBQUMsS0FBRDtXQUUzQixLQUFLLENBQUMsSUFBTixDQUFBLENBQVksQ0FBQyxJQUFiLENBQWtCLFNBQUMsSUFBRDtNQUVqQixJQUFHLElBQUksQ0FBQyxNQUFMLEdBQWMsUUFBakI7ZUFFQyxL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YUFDQTtJQUxxQyxDQUFwQixDQUFsQixDQU1BLENBQUMsT0FBRCxDQU5BLENBTU8sU0FBQTthQUVOLE1BQU0sQ0FBQyxLQUFQLENBQWEsT0FBYixDQUFxQixDQUFDLElBQXRCLENBQTJCLFNBQUMsUUFBRDtlQUMxQixRQUFBLElBQVksTUFBTSxDQUFDLEtBQVAsQ0FBYSxVQUFiO01BRGMsQ0FBM0I7SUFGTSxDQU5QLEVBWEQ7O1NBdUJBLEtBQUssQ0FBQyxXQUFOLENBQWtCLE1BQU0sQ0FBQyxLQUFQLENBQWEsT0FBYixDQUFxQixDQUFDLElBQXRCLENBQTJCLFNBQUMsUUFBRDtXQUU1QyxRQUFBLElBQVksS0FBQSxDQUFNLE9BQU4sQ0FBYyxDQUFDLElBQWYsQ0FBb0IsU0FBQyxRQUFEO0FBRy9CLFVBQUE7TUFBQSxJQUFHLE9BQU8sQ0FBQyxPQUFPLENBQUMsR0FBaEIsQ0FBb0IsUUFBcEIsQ0FBNkIsQ0FBQyxPQUE5QixDQUFzQyxPQUF0QyxDQUFBLEtBQWtELENBQUMsQ0FBdEQ7UUFDQyxJQUFBLEdBQU8sUUFBUSxDQUFDLEtBQVQsQ0FBQTtRQUNQLFlBQUEsQ0FBYSxlQUFiLEVBQThCLE9BQTlCLEVBQXVDLElBQXZDLEVBRkQ7O2FBR0E7SUFOK0IsQ0FBcEIsQ0FPWixDQUFDLE9BQUQsQ0FQWSxDQU9MLFNBQUE7TUFHTixJQUFHLE9BQU8sQ0FBQyxPQUFPLENBQUMsR0FBaEIsQ0FBb0IsUUFBcEIsQ0FBNkIsQ0FBQyxPQUE5QixDQUFzQyxPQUF0QyxDQUFBLEtBQWtELENBQUMsQ0FBdEQ7QUFDQyxlQUFXLElBQUEsUUFBQSxDQUFTLHNZQUFULEVBQWlaO1VBQUEsT0FBQSxFQUFTO1lBQUEsY0FBQSxFQUFnQixlQUFoQjtXQUFUO1NBQWpaLEVBRFo7O0lBSE0sQ0FQSztFQUZnQyxDQUEzQixDQUFsQjtBQXRDOEIsQ0FBL0IiLCJmaWxlIjoiZ2VuZXJhdGVkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXNDb250ZW50IjpbIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIiwiXCJ1c2Ugc3RyaWN0XCJcbnZlcnNpb24gPSBcInYxLjAxOjpcIlxuc3RhdGljQ2FjaGVOYW1lID0gdmVyc2lvbiArIFwic3RhdGljXCJcbnBhZ2VzQ2FjaGVOYW1lID0gdmVyc2lvbiArIFwicGFnZXNcIlxuaW1hZ2VzQ2FjaGVOYW1lID0gdmVyc2lvbiArIFwiaW1hZ2VzXCJcblxudXBkYXRlU3RhdGljQ2FjaGUgPSAtPlxuXG5cdGNhY2hlcy5vcGVuKHN0YXRpY0NhY2hlTmFtZSlcblx0LnRoZW4gKGNhY2hlKSAtPlxuXHRcdCMgVGhlc2UgaXRlbXMgbXVzdCBiZSBjYWNoZWQgZm9yIHRoZSBTZXJ2aWNlIFdvcmtlciB0byBjb21wbGV0ZSBpbnN0YWxsYXRpb25cblx0XHRjYWNoZS5hZGRBbGwgW1xuXHRcdFx0XCIvc2NyaXB0cy9tYWluLm1pbi5qc1wiXG5cdFx0XHRcIi9zdHlsZXMvbWFpbi5taW4uY3NzXCJcblx0XHRcdFwiL2ltYWdlcy9kYXJyeWwtc25vdy5qcGdcIlxuXHRcdFx0XCIvaW1hZ2VzL2NsZWFuLWNvZGUucG5nXCJcblx0XHRcdFwiL2ltYWdlcy9mYW1pbHkuanBnXCJcblx0XHRcdFwiL2ltYWdlcy9pY29uLnBuZ1wiXG5cdFx0XHRcIi9pbWFnZXMvdHdpdHRlci1iZy5wbmdcIlxuXHRcdFx0XCIvaW1hZ2VzL3R3aXR0ZXItYmcucG5nXCJcblx0XHRcdFwiL2ltYWdlcy9mdWxsd2ViLWxvZ28uc3ZnXCJcblx0XHRdXG5cbnN0YXNoSW5DYWNoZSA9IChjYWNoZU5hbWUsIHJlcXVlc3QsIHJlc3BvbnNlKSAtPlxuXG5cdGNhY2hlcy5vcGVuKGNhY2hlTmFtZSkudGhlbiAoY2FjaGUpIC0+XG5cblx0XHRjYWNoZS5wdXQgcmVxdWVzdCwgcmVzcG9uc2VcblxuIyBMaW1pdCB0aGUgbnVtYmVyIG9mIGl0ZW1zIGluIGEgc3BlY2lmaWVkIGNhY2hlLlxudHJpbUNhY2hlID0gKGNhY2hlTmFtZSwgbWF4SXRlbXMpIC0+XG5cblx0Y2FjaGVzLm9wZW4oY2FjaGVOYW1lKS50aGVuIChjYWNoZSkgLT5cblxuXHRcdGNhY2hlLmtleXMoKS50aGVuIChrZXlzKSAtPlxuXG5cdFx0XHRpZiBrZXlzLmxlbmd0aCA+IG1heEl0ZW1zXG5cblx0XHRcdFx0Y2FjaGUuZGVsZXRlKGtleXNbMF0pLnRoZW4gdHJpbUNhY2hlKGNhY2hlTmFtZSwgbWF4SXRlbXMpXG5cbiMgUmVtb3ZlIGNhY2hlcyB3aG9zZSBuYW1lIGlzIG5vIGxvbmdlciB2YWxpZFxuY2xlYXJPbGRDYWNoZXMgPSAtPlxuXG5cdGNhY2hlcy5rZXlzKCkudGhlbiAoa2V5cykgLT5cblxuXHRcdFByb21pc2UuYWxsIGtleXMuZmlsdGVyIChrZXkpIC0+XG5cblx0XHRcdGtleS5pbmRleE9mKHZlcnNpb24pICE9IDBcblxuXHRcdC5tYXAgKGtleSkgLT5cblxuXHRcdFx0Y2FjaGVzLmRlbGV0ZSBrZXlcblxuc2VsZi5hZGRFdmVudExpc3RlbmVyIFwiaW5zdGFsbFwiLCAoZXZlbnQpIC0+XG5cblx0ZXZlbnQud2FpdFVudGlsIHVwZGF0ZVN0YXRpY0NhY2hlKCkudGhlbiAtPlxuXG5cdFx0c2VsZi5za2lwV2FpdGluZygpXG5cbnNlbGYuYWRkRXZlbnRMaXN0ZW5lciBcImFjdGl2YXRlXCIsIChldmVudCkgLT5cblxuXHRldmVudC53YWl0VW50aWwgY2xlYXJPbGRDYWNoZXMoKS50aGVuIC0+XG5cblx0XHRzZWxmLmNsaWVudHMuY2xhaW0oKVxuXG5zZWxmLmFkZEV2ZW50TGlzdGVuZXIgXCJtZXNzYWdlXCIsIChldmVudCkgLT5cblxuXHRpZiBldmVudC5kYXRhLmNvbW1hbmQgPT0gXCJ0cmltQ2FjaGVzXCJcblx0XHR0cmltQ2FjaGUgcGFnZXNDYWNoZU5hbWUsIDM1XG5cdFx0dHJpbUNhY2hlIGltYWdlc0NhY2hlTmFtZSwgMjBcblxuc2VsZi5hZGRFdmVudExpc3RlbmVyIFwiZmV0Y2hcIiwgKGV2ZW50KSAtPlxuXG5cdHJlcXVlc3QgPSBldmVudC5yZXF1ZXN0XG5cdHVybCA9IG5ldyBVUkwgcmVxdWVzdC51cmxcblxuXHQjIE9ubHkgZGVhbCB3aXRoIHJlcXVlc3RzIHRvIG15IG93biBzZXJ2ZXJcblx0aWYgdXJsLm9yaWdpbiAhPSBsb2NhdGlvbi5vcmlnaW5cblx0XHRyZXR1cm5cblxuXHQjIEZvciBub24tR0VUIHJlcXVlc3RzLCB0cnkgdGhlIG5ldHdvcmsgZmlyc3QsIGZhbGwgYmFjayB0byB0aGUgb2ZmbGluZSBwYWdlXG5cdGlmIHJlcXVlc3QubWV0aG9kICE9IFwiR0VUXCJcblx0XHRldmVudC5yZXNwb25kV2l0aCBmZXRjaChyZXF1ZXN0KS5jYXRjaCAtPlxuXHRcdFx0Y2FjaGVzLm1hdGNoIFwiL29mZmxpbmVcIlxuXG5cdCMgRm9yIEhUTUwgcmVxdWVzdHMsIHRyeSB0aGUgbmV0d29yayBmaXJzdCwgZmFsbCBiYWNrIHRvIHRoZSBjYWNoZSwgZmluYWxseSB0aGUgb2ZmbGluZSBwYWdlXG5cdGlmIHJlcXVlc3QuaGVhZGVycy5nZXQoXCJBY2NlcHRcIikuaW5kZXhPZihcInRleHQvaHRtbFwiKSAhPSAtMVxuXG5cdFx0IyBGaXggZm9yIENocm9tZSBidWc6IGh0dHBzOi8vY29kZS5nb29nbGUuY29tL3AvY2hyb21pdW0vaXNzdWVzL2RldGFpbD9pZD01NzM5Mzdcblx0XHRpZiByZXF1ZXN0Lm1vZGUgIT0gXCJuYXZpZ2F0ZVwiXG5cdFx0XHRyZXF1ZXN0ID0gbmV3IFJlcXVlc3QodXJsLFxuXHRcdFx0XHRtZXRob2Q6IFwiR0VUXCJcblx0XHRcdFx0aGVhZGVyczogcmVxdWVzdC5oZWFkZXJzXG5cdFx0XHRcdG1vZGU6IHJlcXVlc3QubW9kZVxuXHRcdFx0XHRjcmVkZW50aWFsczogcmVxdWVzdC5jcmVkZW50aWFsc1xuXHRcdFx0XHRyZWRpcmVjdDogcmVxdWVzdC5yZWRpcmVjdClcblxuXHRcdGV2ZW50LnJlc3BvbmRXaXRoIGZldGNoKHJlcXVlc3QpLnRoZW4gKHJlc3BvbnNlKSAtPlxuXHRcdFx0IyBORVRXT1JLXG5cdFx0XHQjIFN0YXNoIGEgY29weSBvZiB0aGlzIHBhZ2UgaW4gdGhlIHBhZ2VzIGNhY2hlXG5cdFx0XHRjb3B5ID0gcmVzcG9uc2UuY2xvbmUoKVxuXHRcdFx0c3Rhc2hJbkNhY2hlIHBhZ2VzQ2FjaGVOYW1lLCByZXF1ZXN0LCBjb3B5XG5cdFx0XHRyZXNwb25zZVxuXHRcdC5jYXRjaCAtPlxuXHRcdFx0IyBDQUNIRSBvciBGQUxMQkFDS1xuXHRcdFx0Y2FjaGVzLm1hdGNoKHJlcXVlc3QpLnRoZW4gKHJlc3BvbnNlKSAtPlxuXHRcdFx0XHRyZXNwb25zZSBvciBjYWNoZXMubWF0Y2ggXCIvb2ZmbGluZVwiXG5cblx0IyBGb3Igbm9uLUhUTUwgcmVxdWVzdHMsIGxvb2sgaW4gdGhlIGNhY2hlIGZpcnN0LCBmYWxsIGJhY2sgdG8gdGhlIG5ldHdvcmtcblx0ZXZlbnQucmVzcG9uZFdpdGggY2FjaGVzLm1hdGNoKHJlcXVlc3QpLnRoZW4gKHJlc3BvbnNlKSAtPlxuXHRcdCMgQ0FDSEVcblx0XHRyZXNwb25zZSBvciBmZXRjaChyZXF1ZXN0KS50aGVuIChyZXNwb25zZSkgLT5cblx0XHRcdCMgTkVUV09SS1xuXHRcdFx0IyBJZiB0aGUgcmVxdWVzdCBpcyBmb3IgYW4gaW1hZ2UsIHN0YXNoIGEgY29weSBvZiB0aGlzIGltYWdlIGluIHRoZSBpbWFnZXMgY2FjaGVcblx0XHRcdGlmIHJlcXVlc3QuaGVhZGVycy5nZXQoXCJBY2NlcHRcIikuaW5kZXhPZihcImltYWdlXCIpICE9IC0xXG5cdFx0XHRcdGNvcHkgPSByZXNwb25zZS5jbG9uZSgpXG5cdFx0XHRcdHN0YXNoSW5DYWNoZSBpbWFnZXNDYWNoZU5hbWUsIHJlcXVlc3QsIGNvcHlcblx0XHRcdHJlc3BvbnNlXG5cdFx0LmNhdGNoIC0+XG5cdFx0XHQjIE9GRkxJTkVcblx0XHRcdCMgSWYgdGhlIHJlcXVlc3QgaXMgZm9yIGFuIGltYWdlLCBzaG93IGFuIG9mZmxpbmUgcGxhY2Vob2xkZXJcblx0XHRcdGlmIHJlcXVlc3QuaGVhZGVycy5nZXQoJ0FjY2VwdCcpLmluZGV4T2YoJ2ltYWdlJykgIT0gLTFcblx0XHRcdFx0cmV0dXJuIG5ldyBSZXNwb25zZSBcIjxzdmcgcm9sZT0naW1nJyBhcmlhLWxhYmVsbGVkYnk9J29mZmxpbmUtdGl0bGUnIHZpZXdCb3g9JzAgMCA0MDAgMzAwJyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnPjx0aXRsZSBpZD0nb2ZmbGluZS10aXRsZSc+T2ZmbGluZTwvdGl0bGU+PGcgZmlsbD0nbm9uZScgZmlsbC1ydWxlPSdldmVub2RkJz48cGF0aCBmaWxsPScjRDhEOEQ4JyBkPSdNMCAwaDQwMHYzMDBIMHonLz48dGV4dCBmaWxsPScjOUI5QjlCJyBmb250LWZhbWlseT0nSGVsdmV0aWNhIE5ldWUsQXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWYnIGZvbnQtc2l6ZT0nNzInIGZvbnQtd2VpZ2h0PSdib2xkJz48dHNwYW4geD0nOTMnIHk9JzE3Mic+b2ZmbGluZTwvdHNwYW4+PC90ZXh0PjwvZz48L3N2Zz5cIiwgaGVhZGVyczogXCJDb250ZW50LVR5cGVcIjogXCJpbWFnZS9zdmcreG1sXCIiXX0=

//# sourceMappingURL=service-worker.js.map
