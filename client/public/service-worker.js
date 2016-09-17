/* your-web-expert : 2.0.0 : Sat Sep 17 2016 17:43:19 GMT+0800 (CST) */

(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var clearOldCaches, imagesCacheName, pagesCacheName, stashInCache, staticCacheName, trimCache, updateStaticCache, version;

version = "v1.03::";

staticCacheName = version + "static";

pagesCacheName = version + "pages";

imagesCacheName = version + "images";

updateStaticCache = function() {
  return caches.open(staticCacheName).then(function(cache) {
    return cache.addAll(["/scripts/main.min.js", "/styles/main.min.css", "/images/darryl-snow.jpg", "/images/clean-code.png", "/images/family.jpg", "/images/icon.png", "/images/icons/favicon.ico", "/images/twitter-bg.png", "/images/fullweb-logo.svg", "/", "/about/me", "/contract", "/contract.pdf", "/darryl-snow-cv.pdf", "/offline"]);
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
    }).map(function(key) {
      return caches["delete"](key);
    }));
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
      if (request.headers.get("Accept").indexOf("image") !== -1) {
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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvZGFycnlsc25vdy9Eb2N1bWVudHMvcGVyc29uYWwvZ2l0L3lvdXJ3ZWIuZXhwZXJ0L2NsaWVudC9zcmMvY29mZmVlc2NyaXB0L3NlcnZpY2Utd29ya2VyLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtBQ0FBLElBQUE7O0FBQUEsT0FBQSxHQUFVOztBQUNWLGVBQUEsR0FBa0IsT0FBQSxHQUFVOztBQUM1QixjQUFBLEdBQWlCLE9BQUEsR0FBVTs7QUFDM0IsZUFBQSxHQUFrQixPQUFBLEdBQVU7O0FBRTVCLGlCQUFBLEdBQW9CLFNBQUE7U0FFbkIsTUFBTSxDQUFDLElBQVAsQ0FBWSxlQUFaLENBQ0EsQ0FBQyxJQURELENBQ00sU0FBQyxLQUFEO1dBRUwsS0FBSyxDQUFDLE1BQU4sQ0FBYSxDQUNaLHNCQURZLEVBRVosc0JBRlksRUFHWix5QkFIWSxFQUlaLHdCQUpZLEVBS1osb0JBTFksRUFNWixrQkFOWSxFQU9aLDJCQVBZLEVBUVosd0JBUlksRUFTWiwwQkFUWSxFQVVaLEdBVlksRUFXWixXQVhZLEVBWVosV0FaWSxFQWFaLGVBYlksRUFjWixxQkFkWSxFQWVaLFVBZlksQ0FBYjtFQUZLLENBRE47QUFGbUI7O0FBdUJwQixZQUFBLEdBQWUsU0FBQyxTQUFELEVBQVksT0FBWixFQUFxQixRQUFyQjtTQUVkLE1BQU0sQ0FBQyxJQUFQLENBQVksU0FBWixDQUFzQixDQUFDLElBQXZCLENBQTRCLFNBQUMsS0FBRDtXQUUzQixLQUFLLENBQUMsR0FBTixDQUFVLE9BQVYsRUFBbUIsUUFBbkI7RUFGMkIsQ0FBNUI7QUFGYzs7QUFPZixTQUFBLEdBQVksU0FBQyxTQUFELEVBQVksUUFBWjtTQUVYLE1BQU0sQ0FBQyxJQUFQLENBQVksU0FBWixDQUFzQixDQUFDLElBQXZCLENBQTRCLFNBQUMsS0FBRDtXQUUzQixLQUFLLENBQUMsSUFBTixDQUFBLENBQVksQ0FBQyxJQUFiLENBQWtCLFNBQUMsSUFBRDtNQUVqQixJQUFHLElBQUksQ0FBQyxNQUFMLEdBQWMsUUFBakI7ZUFFQyxLQUFLLENBQUMsUUFBRCxDQUFMLENBQWEsSUFBSyxDQUFBLENBQUEsQ0FBbEIsQ0FBcUIsQ0FBQyxJQUF0QixDQUEyQixTQUFBLENBQVUsU0FBVixFQUFxQixRQUFyQixDQUEzQixFQUZEOztJQUZpQixDQUFsQjtFQUYyQixDQUE1QjtBQUZXOztBQVdaLGNBQUEsR0FBaUIsU0FBQTtTQUVoQixNQUFNLENBQUMsSUFBUCxDQUFBLENBQWEsQ0FBQyxJQUFkLENBQW1CLFNBQUMsSUFBRDtBQUVsQixXQUFPLE9BQU8sQ0FBQyxHQUFSLENBQVksSUFDbEIsQ0FBQyxNQURpQixDQUNWLFNBQUMsR0FBRDthQUFTLEdBQUcsQ0FBQyxPQUFKLENBQVksT0FBWixDQUFBLEtBQTBCO0lBQW5DLENBRFUsQ0FFbEIsQ0FBQyxHQUZpQixDQUViLFNBQUMsR0FBRDthQUFTLE1BQU0sQ0FBQyxRQUFELENBQU4sQ0FBYyxHQUFkO0lBQVQsQ0FGYSxDQUFaO0VBRlcsQ0FBbkI7QUFGZ0I7O0FBU2pCLElBQUksQ0FBQyxnQkFBTCxDQUFzQixTQUF0QixFQUFpQyxTQUFDLEtBQUQ7U0FFaEMsS0FBSyxDQUFDLFNBQU4sQ0FBZ0IsaUJBQUEsQ0FBQSxDQUFtQixDQUFDLElBQXBCLENBQXlCLFNBQUE7V0FFeEMsSUFBSSxDQUFDLFdBQUwsQ0FBQTtFQUZ3QyxDQUF6QixDQUFoQjtBQUZnQyxDQUFqQzs7QUFNQSxJQUFJLENBQUMsZ0JBQUwsQ0FBc0IsVUFBdEIsRUFBa0MsU0FBQyxLQUFEO1NBRWpDLEtBQUssQ0FBQyxTQUFOLENBQWdCLGNBQUEsQ0FBQSxDQUFnQixDQUFDLElBQWpCLENBQXNCLFNBQUE7V0FFckMsSUFBSSxDQUFDLE9BQU8sQ0FBQyxLQUFiLENBQUE7RUFGcUMsQ0FBdEIsQ0FBaEI7QUFGaUMsQ0FBbEM7O0FBTUEsSUFBSSxDQUFDLGdCQUFMLENBQXNCLFNBQXRCLEVBQWlDLFNBQUMsS0FBRDtFQUVoQyxJQUFHLEtBQUssQ0FBQyxJQUFJLENBQUMsT0FBWCxLQUFzQixZQUF6QjtJQUNDLFNBQUEsQ0FBVSxjQUFWLEVBQTBCLEVBQTFCO1dBQ0EsU0FBQSxDQUFVLGVBQVYsRUFBMkIsRUFBM0IsRUFGRDs7QUFGZ0MsQ0FBakM7O0FBTUEsSUFBSSxDQUFDLGdCQUFMLENBQXNCLE9BQXRCLEVBQStCLFNBQUMsS0FBRDtBQUU5QixNQUFBO0VBQUEsT0FBQSxHQUFVLEtBQUssQ0FBQztFQUNoQixHQUFBLEdBQVUsSUFBQSxHQUFBLENBQUksT0FBTyxDQUFDLEdBQVo7RUFHVixJQUFHLEdBQUcsQ0FBQyxNQUFKLEtBQWMsUUFBUSxDQUFDLE1BQTFCO0FBQ0MsV0FERDs7RUFJQSxJQUFHLE9BQU8sQ0FBQyxNQUFSLEtBQWtCLEtBQXJCO0lBQ0MsS0FBSyxDQUFDLFdBQU4sQ0FBa0IsS0FBQSxDQUFNLE9BQU4sQ0FBYyxDQUFDLE9BQUQsQ0FBZCxDQUFxQixTQUFBO2FBQ3RDLE1BQU0sQ0FBQyxLQUFQLENBQWEsVUFBYjtJQURzQyxDQUFyQixDQUFsQixFQUREOztFQUtBLElBQUcsT0FBTyxDQUFDLE9BQU8sQ0FBQyxHQUFoQixDQUFvQixRQUFwQixDQUE2QixDQUFDLE9BQTlCLENBQXNDLFdBQXRDLENBQUEsS0FBc0QsQ0FBQyxDQUExRDtJQUdDLElBQUcsT0FBTyxDQUFDLElBQVIsS0FBZ0IsVUFBbkI7TUFDQyxPQUFBLEdBQWMsSUFBQSxPQUFBLENBQVEsR0FBUixFQUNiO1FBQUEsTUFBQSxFQUFRLEtBQVI7UUFDQSxPQUFBLEVBQVMsT0FBTyxDQUFDLE9BRGpCO1FBRUEsSUFBQSxFQUFNLE9BQU8sQ0FBQyxJQUZkO1FBR0EsV0FBQSxFQUFhLE9BQU8sQ0FBQyxXQUhyQjtRQUlBLFFBQUEsRUFBVSxPQUFPLENBQUMsUUFKbEI7T0FEYSxFQURmOztJQVFBLEtBQUssQ0FBQyxXQUFOLENBQWtCLEtBQUEsQ0FBTSxPQUFOLENBQWMsQ0FBQyxJQUFmLENBQW9CLFNBQUMsUUFBRDtBQUdyQyxVQUFBO01BQUEsSUFBQSxHQUFPLFFBQVEsQ0FBQyxLQUFULENBQUE7TUFDUCxZQUFBLENBQWEsY0FBYixFQUE2QixPQUE3QixFQUFzQyxJQUF0QzthQUNBO0lBTHFDLENBQXBCLENBQWxCLENBTUEsQ0FBQyxPQUFELENBTkEsQ0FNTyxTQUFBO2FBRU4sTUFBTSxDQUFDLEtBQVAsQ0FBYSxPQUFiLENBQXFCLENBQUMsSUFBdEIsQ0FBMkIsU0FBQyxRQUFEO2VBQzFCLFFBQUEsSUFBWSxNQUFNLENBQUMsS0FBUCxDQUFhLFVBQWI7TUFEYyxDQUEzQjtJQUZNLENBTlAsRUFYRDs7U0F1QkEsS0FBSyxDQUFDLFdBQU4sQ0FBa0IsTUFBTSxDQUFDLEtBQVAsQ0FBYSxPQUFiLENBQXFCLENBQUMsSUFBdEIsQ0FBMkIsU0FBQyxRQUFEO1dBRTVDLFFBQUEsSUFBWSxLQUFBLENBQU0sT0FBTixDQUFjLENBQUMsSUFBZixDQUFvQixTQUFDLFFBQUQ7QUFHL0IsVUFBQTtNQUFBLElBQUcsT0FBTyxDQUFDLE9BQU8sQ0FBQyxHQUFoQixDQUFvQixRQUFwQixDQUE2QixDQUFDLE9BQTlCLENBQXNDLE9BQXRDLENBQUEsS0FBa0QsQ0FBQyxDQUF0RDtRQUNDLElBQUEsR0FBTyxRQUFRLENBQUMsS0FBVCxDQUFBO1FBQ1AsWUFBQSxDQUFhLGVBQWIsRUFBOEIsT0FBOUIsRUFBdUMsSUFBdkMsRUFGRDs7YUFHQTtJQU4rQixDQUFwQixDQU9aLENBQUMsT0FBRCxDQVBZLENBT0wsU0FBQTtNQUdOLElBQUcsT0FBTyxDQUFDLE9BQU8sQ0FBQyxHQUFoQixDQUFvQixRQUFwQixDQUE2QixDQUFDLE9BQTlCLENBQXNDLE9BQXRDLENBQUEsS0FBa0QsQ0FBQyxDQUF0RDtBQUNDLGVBQVcsSUFBQSxRQUFBLENBQVMsc1lBQVQsRUFBaVo7VUFBQSxPQUFBLEVBQVM7WUFBQSxjQUFBLEVBQWdCLGVBQWhCO1dBQVQ7U0FBalosRUFEWjs7SUFITSxDQVBLO0VBRmdDLENBQTNCLENBQWxCO0FBdEM4QixDQUEvQiIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJ2ZXJzaW9uID0gXCJ2MS4wMzo6XCJcbnN0YXRpY0NhY2hlTmFtZSA9IHZlcnNpb24gKyBcInN0YXRpY1wiXG5wYWdlc0NhY2hlTmFtZSA9IHZlcnNpb24gKyBcInBhZ2VzXCJcbmltYWdlc0NhY2hlTmFtZSA9IHZlcnNpb24gKyBcImltYWdlc1wiXG5cbnVwZGF0ZVN0YXRpY0NhY2hlID0gLT5cblxuXHRjYWNoZXMub3BlbihzdGF0aWNDYWNoZU5hbWUpXG5cdC50aGVuIChjYWNoZSkgLT5cblx0XHQjIFRoZXNlIGl0ZW1zIG11c3QgYmUgY2FjaGVkIGZvciB0aGUgU2VydmljZSBXb3JrZXIgdG8gY29tcGxldGUgaW5zdGFsbGF0aW9uXG5cdFx0Y2FjaGUuYWRkQWxsIFtcblx0XHRcdFwiL3NjcmlwdHMvbWFpbi5taW4uanNcIlxuXHRcdFx0XCIvc3R5bGVzL21haW4ubWluLmNzc1wiXG5cdFx0XHRcIi9pbWFnZXMvZGFycnlsLXNub3cuanBnXCJcblx0XHRcdFwiL2ltYWdlcy9jbGVhbi1jb2RlLnBuZ1wiXG5cdFx0XHRcIi9pbWFnZXMvZmFtaWx5LmpwZ1wiXG5cdFx0XHRcIi9pbWFnZXMvaWNvbi5wbmdcIlxuXHRcdFx0XCIvaW1hZ2VzL2ljb25zL2Zhdmljb24uaWNvXCJcblx0XHRcdFwiL2ltYWdlcy90d2l0dGVyLWJnLnBuZ1wiXG5cdFx0XHRcIi9pbWFnZXMvZnVsbHdlYi1sb2dvLnN2Z1wiXG5cdFx0XHRcIi9cIlxuXHRcdFx0XCIvYWJvdXQvbWVcIlxuXHRcdFx0XCIvY29udHJhY3RcIlxuXHRcdFx0XCIvY29udHJhY3QucGRmXCJcblx0XHRcdFwiL2RhcnJ5bC1zbm93LWN2LnBkZlwiXG5cdFx0XHRcIi9vZmZsaW5lXCJcblx0XHRdXG5cbnN0YXNoSW5DYWNoZSA9IChjYWNoZU5hbWUsIHJlcXVlc3QsIHJlc3BvbnNlKSAtPlxuXG5cdGNhY2hlcy5vcGVuKGNhY2hlTmFtZSkudGhlbiAoY2FjaGUpIC0+XG5cblx0XHRjYWNoZS5wdXQgcmVxdWVzdCwgcmVzcG9uc2VcblxuIyBMaW1pdCB0aGUgbnVtYmVyIG9mIGl0ZW1zIGluIGEgc3BlY2lmaWVkIGNhY2hlLlxudHJpbUNhY2hlID0gKGNhY2hlTmFtZSwgbWF4SXRlbXMpIC0+XG5cblx0Y2FjaGVzLm9wZW4oY2FjaGVOYW1lKS50aGVuIChjYWNoZSkgLT5cblxuXHRcdGNhY2hlLmtleXMoKS50aGVuIChrZXlzKSAtPlxuXG5cdFx0XHRpZiBrZXlzLmxlbmd0aCA+IG1heEl0ZW1zXG5cblx0XHRcdFx0Y2FjaGUuZGVsZXRlKGtleXNbMF0pLnRoZW4gdHJpbUNhY2hlKGNhY2hlTmFtZSwgbWF4SXRlbXMpXG5cbiMgUmVtb3ZlIGNhY2hlcyB3aG9zZSBuYW1lIGlzIG5vIGxvbmdlciB2YWxpZFxuY2xlYXJPbGRDYWNoZXMgPSAtPlxuXG5cdGNhY2hlcy5rZXlzKCkudGhlbiAoa2V5cykgLT5cblxuXHRcdHJldHVybiBQcm9taXNlLmFsbChrZXlzXG5cdFx0XHQuZmlsdGVyKChrZXkpIC0+IGtleS5pbmRleE9mKHZlcnNpb24pIGlzbnQgMClcblx0XHRcdC5tYXAoKGtleSkgLT4gY2FjaGVzLmRlbGV0ZShrZXkpKVxuXHRcdClcblxuc2VsZi5hZGRFdmVudExpc3RlbmVyIFwiaW5zdGFsbFwiLCAoZXZlbnQpIC0+XG5cblx0ZXZlbnQud2FpdFVudGlsIHVwZGF0ZVN0YXRpY0NhY2hlKCkudGhlbiAtPlxuXG5cdFx0c2VsZi5za2lwV2FpdGluZygpXG5cbnNlbGYuYWRkRXZlbnRMaXN0ZW5lciBcImFjdGl2YXRlXCIsIChldmVudCkgLT5cblxuXHRldmVudC53YWl0VW50aWwgY2xlYXJPbGRDYWNoZXMoKS50aGVuIC0+XG5cblx0XHRzZWxmLmNsaWVudHMuY2xhaW0oKVxuXG5zZWxmLmFkZEV2ZW50TGlzdGVuZXIgXCJtZXNzYWdlXCIsIChldmVudCkgLT5cblxuXHRpZiBldmVudC5kYXRhLmNvbW1hbmQgPT0gXCJ0cmltQ2FjaGVzXCJcblx0XHR0cmltQ2FjaGUgcGFnZXNDYWNoZU5hbWUsIDM1XG5cdFx0dHJpbUNhY2hlIGltYWdlc0NhY2hlTmFtZSwgMjBcblxuc2VsZi5hZGRFdmVudExpc3RlbmVyIFwiZmV0Y2hcIiwgKGV2ZW50KSAtPlxuXG5cdHJlcXVlc3QgPSBldmVudC5yZXF1ZXN0XG5cdHVybCA9IG5ldyBVUkwgcmVxdWVzdC51cmxcblxuXHQjIE9ubHkgZGVhbCB3aXRoIHJlcXVlc3RzIHRvIG15IG93biBzZXJ2ZXJcblx0aWYgdXJsLm9yaWdpbiAhPSBsb2NhdGlvbi5vcmlnaW5cblx0XHRyZXR1cm5cblxuXHQjIEZvciBub24tR0VUIHJlcXVlc3RzLCB0cnkgdGhlIG5ldHdvcmsgZmlyc3QsIGZhbGwgYmFjayB0byB0aGUgb2ZmbGluZSBwYWdlXG5cdGlmIHJlcXVlc3QubWV0aG9kICE9IFwiR0VUXCJcblx0XHRldmVudC5yZXNwb25kV2l0aCBmZXRjaChyZXF1ZXN0KS5jYXRjaCAtPlxuXHRcdFx0Y2FjaGVzLm1hdGNoIFwiL29mZmxpbmVcIlxuXG5cdCMgRm9yIEhUTUwgcmVxdWVzdHMsIHRyeSB0aGUgbmV0d29yayBmaXJzdCwgZmFsbCBiYWNrIHRvIHRoZSBjYWNoZSwgZmluYWxseSB0aGUgb2ZmbGluZSBwYWdlXG5cdGlmIHJlcXVlc3QuaGVhZGVycy5nZXQoXCJBY2NlcHRcIikuaW5kZXhPZihcInRleHQvaHRtbFwiKSAhPSAtMVxuXG5cdFx0IyBGaXggZm9yIENocm9tZSBidWc6IGh0dHBzOi8vY29kZS5nb29nbGUuY29tL3AvY2hyb21pdW0vaXNzdWVzL2RldGFpbD9pZD01NzM5Mzdcblx0XHRpZiByZXF1ZXN0Lm1vZGUgIT0gXCJuYXZpZ2F0ZVwiXG5cdFx0XHRyZXF1ZXN0ID0gbmV3IFJlcXVlc3QodXJsLFxuXHRcdFx0XHRtZXRob2Q6IFwiR0VUXCJcblx0XHRcdFx0aGVhZGVyczogcmVxdWVzdC5oZWFkZXJzXG5cdFx0XHRcdG1vZGU6IHJlcXVlc3QubW9kZVxuXHRcdFx0XHRjcmVkZW50aWFsczogcmVxdWVzdC5jcmVkZW50aWFsc1xuXHRcdFx0XHRyZWRpcmVjdDogcmVxdWVzdC5yZWRpcmVjdClcblxuXHRcdGV2ZW50LnJlc3BvbmRXaXRoIGZldGNoKHJlcXVlc3QpLnRoZW4gKHJlc3BvbnNlKSAtPlxuXHRcdFx0IyBORVRXT1JLXG5cdFx0XHQjIFN0YXNoIGEgY29weSBvZiB0aGlzIHBhZ2UgaW4gdGhlIHBhZ2VzIGNhY2hlXG5cdFx0XHRjb3B5ID0gcmVzcG9uc2UuY2xvbmUoKVxuXHRcdFx0c3Rhc2hJbkNhY2hlIHBhZ2VzQ2FjaGVOYW1lLCByZXF1ZXN0LCBjb3B5XG5cdFx0XHRyZXNwb25zZVxuXHRcdC5jYXRjaCAtPlxuXHRcdFx0IyBDQUNIRSBvciBGQUxMQkFDS1xuXHRcdFx0Y2FjaGVzLm1hdGNoKHJlcXVlc3QpLnRoZW4gKHJlc3BvbnNlKSAtPlxuXHRcdFx0XHRyZXNwb25zZSBvciBjYWNoZXMubWF0Y2ggXCIvb2ZmbGluZVwiXG5cblx0IyBGb3Igbm9uLUhUTUwgcmVxdWVzdHMsIGxvb2sgaW4gdGhlIGNhY2hlIGZpcnN0LCBmYWxsIGJhY2sgdG8gdGhlIG5ldHdvcmtcblx0ZXZlbnQucmVzcG9uZFdpdGggY2FjaGVzLm1hdGNoKHJlcXVlc3QpLnRoZW4gKHJlc3BvbnNlKSAtPlxuXHRcdCMgQ0FDSEVcblx0XHRyZXNwb25zZSBvciBmZXRjaChyZXF1ZXN0KS50aGVuIChyZXNwb25zZSkgLT5cblx0XHRcdCMgTkVUV09SS1xuXHRcdFx0IyBJZiB0aGUgcmVxdWVzdCBpcyBmb3IgYW4gaW1hZ2UsIHN0YXNoIGEgY29weSBvZiB0aGlzIGltYWdlIGluIHRoZSBpbWFnZXMgY2FjaGVcblx0XHRcdGlmIHJlcXVlc3QuaGVhZGVycy5nZXQoXCJBY2NlcHRcIikuaW5kZXhPZihcImltYWdlXCIpICE9IC0xXG5cdFx0XHRcdGNvcHkgPSByZXNwb25zZS5jbG9uZSgpXG5cdFx0XHRcdHN0YXNoSW5DYWNoZSBpbWFnZXNDYWNoZU5hbWUsIHJlcXVlc3QsIGNvcHlcblx0XHRcdHJlc3BvbnNlXG5cdFx0LmNhdGNoIC0+XG5cdFx0XHQjIE9GRkxJTkVcblx0XHRcdCMgSWYgdGhlIHJlcXVlc3QgaXMgZm9yIGFuIGltYWdlLCBzaG93IGFuIG9mZmxpbmUgcGxhY2Vob2xkZXJcblx0XHRcdGlmIHJlcXVlc3QuaGVhZGVycy5nZXQoXCJBY2NlcHRcIikuaW5kZXhPZihcImltYWdlXCIpICE9IC0xXG5cdFx0XHRcdHJldHVybiBuZXcgUmVzcG9uc2UgXCI8c3ZnIHJvbGU9J2ltZycgYXJpYS1sYWJlbGxlZGJ5PSdvZmZsaW5lLXRpdGxlJyB2aWV3Qm94PScwIDAgNDAwIDMwMCcgeG1sbnM9J2h0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnJz48dGl0bGUgaWQ9J29mZmxpbmUtdGl0bGUnPk9mZmxpbmU8L3RpdGxlPjxnIGZpbGw9J25vbmUnIGZpbGwtcnVsZT0nZXZlbm9kZCc+PHBhdGggZmlsbD0nI0Q4RDhEOCcgZD0nTTAgMGg0MDB2MzAwSDB6Jy8+PHRleHQgZmlsbD0nIzlCOUI5QicgZm9udC1mYW1pbHk9J0hlbHZldGljYSBOZXVlLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmJyBmb250LXNpemU9JzcyJyBmb250LXdlaWdodD0nYm9sZCc+PHRzcGFuIHg9JzkzJyB5PScxNzInPm9mZmxpbmU8L3RzcGFuPjwvdGV4dD48L2c+PC9zdmc+XCIsIGhlYWRlcnM6IFwiQ29udGVudC1UeXBlXCI6IFwiaW1hZ2Uvc3ZnK3htbFwiIl19

//# sourceMappingURL=service-worker.js.map
