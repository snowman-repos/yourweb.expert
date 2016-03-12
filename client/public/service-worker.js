/* your-web-expert : 2.0.0 : Sat Mar 12 2016 17:30:52 GMT+0800 (CST) */

(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var clearOldCaches, imagesCacheName, pagesCacheName, stashInCache, staticCacheName, trimCache, updateStaticCache, version;

version = "v1.01::";

staticCacheName = version + "static";

pagesCacheName = version + "pages";

imagesCacheName = version + "images";

updateStaticCache = function() {
  return caches.open(staticCacheName).then(function(cache) {
    return cache.addAll(["/scripts/main.min.js", "/styles/main.min.css", "/images/darryl-snow.jpg", "/images/clean-code.png", "/images/family.jpg", "/images/icon.png", "/images/twitter-bg.png", "/images/fullweb-logo.svg"]);
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
      key.indexOf(version) !== 0;
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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvZGFycnlsL0RvY3VtZW50cy9naXQveW91cndlYi5leHBlcnQvY2xpZW50L3NyYy9jb2ZmZWVzY3JpcHQvc2VydmljZS13b3JrZXIuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUEsSUFBQTs7QUFBQSxPQUFBLEdBQVU7O0FBQ1YsZUFBQSxHQUFrQixPQUFBLEdBQVU7O0FBQzVCLGNBQUEsR0FBaUIsT0FBQSxHQUFVOztBQUMzQixlQUFBLEdBQWtCLE9BQUEsR0FBVTs7QUFFNUIsaUJBQUEsR0FBb0IsU0FBQTtTQUVuQixNQUFNLENBQUMsSUFBUCxDQUFZLGVBQVosQ0FDQSxDQUFDLElBREQsQ0FDTSxTQUFDLEtBQUQ7V0FFTCxLQUFLLENBQUMsTUFBTixDQUFhLENBQ1osc0JBRFksRUFFWixzQkFGWSxFQUdaLHlCQUhZLEVBSVosd0JBSlksRUFLWixvQkFMWSxFQU1aLGtCQU5ZLEVBT1osd0JBUFksRUFRWiwwQkFSWSxDQUFiO0VBRkssQ0FETjtBQUZtQjs7QUFnQnBCLFlBQUEsR0FBZSxTQUFDLFNBQUQsRUFBWSxPQUFaLEVBQXFCLFFBQXJCO1NBRWQsTUFBTSxDQUFDLElBQVAsQ0FBWSxTQUFaLENBQXNCLENBQUMsSUFBdkIsQ0FBNEIsU0FBQyxLQUFEO1dBRTNCLEtBQUssQ0FBQyxHQUFOLENBQVUsT0FBVixFQUFtQixRQUFuQjtFQUYyQixDQUE1QjtBQUZjOztBQU9mLFNBQUEsR0FBWSxTQUFDLFNBQUQsRUFBWSxRQUFaO1NBRVgsTUFBTSxDQUFDLElBQVAsQ0FBWSxTQUFaLENBQXNCLENBQUMsSUFBdkIsQ0FBNEIsU0FBQyxLQUFEO1dBRTNCLEtBQUssQ0FBQyxJQUFOLENBQUEsQ0FBWSxDQUFDLElBQWIsQ0FBa0IsU0FBQyxJQUFEO01BRWpCLElBQUcsSUFBSSxDQUFDLE1BQUwsR0FBYyxRQUFqQjtlQUVDLEtBQUssQ0FBQyxRQUFELENB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LENBQWxCLENBTUEsQ0FBQyxPQUFELENBTkEsQ0FNTyxTQUFBO2FBRU4sTUFBTSxDQUFDLEtBQVAsQ0FBYSxPQUFiLENBQXFCLENBQUMsSUFBdEIsQ0FBMkIsU0FBQyxRQUFEO2VBQzFCLFFBQUEsSUFBWSxNQUFNLENBQUMsS0FBUCxDQUFhLFVBQWI7TUFEYyxDQUEzQjtJQUZNLENBTlAsRUFYRDs7U0F1QkEsS0FBSyxDQUFDLFdBQU4sQ0FBa0IsTUFBTSxDQUFDLEtBQVAsQ0FBYSxPQUFiLENBQXFCLENBQUMsSUFBdEIsQ0FBMkIsU0FBQyxRQUFEO1dBRTVDLFFBQUEsSUFBWSxLQUFBLENBQU0sT0FBTixDQUFjLENBQUMsSUFBZixDQUFvQixTQUFDLFFBQUQ7QUFHL0IsVUFBQTtNQUFBLElBQUcsT0FBTyxDQUFDLE9BQU8sQ0FBQyxHQUFoQixDQUFvQixRQUFwQixDQUE2QixDQUFDLE9BQTlCLENBQXNDLE9BQXRDLENBQUEsS0FBa0QsQ0FBQyxDQUF0RDtRQUNDLElBQUEsR0FBTyxRQUFRLENBQUMsS0FBVCxDQUFBO1FBQ1AsWUFBQSxDQUFhLGVBQWIsRUFBOEIsT0FBOUIsRUFBdUMsSUFBdkMsRUFGRDs7YUFHQTtJQU4rQixDQUFwQixDQU9aLENBQUMsT0FBRCxDQVBZLENBT0wsU0FBQTtNQUdOLElBQUcsT0FBTyxDQUFDLE9BQU8sQ0FBQyxHQUFoQixDQUFvQixRQUFwQixDQUE2QixDQUFDLE9BQTlCLENBQXNDLE9BQXRDLENBQUEsS0FBa0QsQ0FBQyxDQUF0RDtBQUNDLGVBQVcsSUFBQSxRQUFBLENBQVMsc1lBQVQsRUFBaVo7VUFBQSxPQUFBLEVBQVM7WUFBQSxjQUFBLEVBQWdCLGVBQWhCO1dBQVQ7U0FBalosRUFEWjs7SUFITSxDQVBLO0VBRmdDLENBQTNCLENBQWxCO0FBdEM4QixDQUEvQiIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJ2ZXJzaW9uID0gXCJ2MS4wMTo6XCJcbnN0YXRpY0NhY2hlTmFtZSA9IHZlcnNpb24gKyBcInN0YXRpY1wiXG5wYWdlc0NhY2hlTmFtZSA9IHZlcnNpb24gKyBcInBhZ2VzXCJcbmltYWdlc0NhY2hlTmFtZSA9IHZlcnNpb24gKyBcImltYWdlc1wiXG5cbnVwZGF0ZVN0YXRpY0NhY2hlID0gLT5cblxuXHRjYWNoZXMub3BlbihzdGF0aWNDYWNoZU5hbWUpXG5cdC50aGVuIChjYWNoZSkgLT5cblx0XHQjIFRoZXNlIGl0ZW1zIG11c3QgYmUgY2FjaGVkIGZvciB0aGUgU2VydmljZSBXb3JrZXIgdG8gY29tcGxldGUgaW5zdGFsbGF0aW9uXG5cdFx0Y2FjaGUuYWRkQWxsIFtcblx0XHRcdFwiL3NjcmlwdHMvbWFpbi5taW4uanNcIlxuXHRcdFx0XCIvc3R5bGVzL21haW4ubWluLmNzc1wiXG5cdFx0XHRcIi9pbWFnZXMvZGFycnlsLXNub3cuanBnXCJcblx0XHRcdFwiL2ltYWdlcy9jbGVhbi1jb2RlLnBuZ1wiXG5cdFx0XHRcIi9pbWFnZXMvZmFtaWx5LmpwZ1wiXG5cdFx0XHRcIi9pbWFnZXMvaWNvbi5wbmdcIlxuXHRcdFx0XCIvaW1hZ2VzL3R3aXR0ZXItYmcucG5nXCJcblx0XHRcdFwiL2ltYWdlcy9mdWxsd2ViLWxvZ28uc3ZnXCJcblx0XHRdXG5cbnN0YXNoSW5DYWNoZSA9IChjYWNoZU5hbWUsIHJlcXVlc3QsIHJlc3BvbnNlKSAtPlxuXG5cdGNhY2hlcy5vcGVuKGNhY2hlTmFtZSkudGhlbiAoY2FjaGUpIC0+XG5cblx0XHRjYWNoZS5wdXQgcmVxdWVzdCwgcmVzcG9uc2VcblxuIyBMaW1pdCB0aGUgbnVtYmVyIG9mIGl0ZW1zIGluIGEgc3BlY2lmaWVkIGNhY2hlLlxudHJpbUNhY2hlID0gKGNhY2hlTmFtZSwgbWF4SXRlbXMpIC0+XG5cblx0Y2FjaGVzLm9wZW4oY2FjaGVOYW1lKS50aGVuIChjYWNoZSkgLT5cblxuXHRcdGNhY2hlLmtleXMoKS50aGVuIChrZXlzKSAtPlxuXG5cdFx0XHRpZiBrZXlzLmxlbmd0aCA+IG1heEl0ZW1zXG5cblx0XHRcdFx0Y2FjaGUuZGVsZXRlKGtleXNbMF0pLnRoZW4gdHJpbUNhY2hlKGNhY2hlTmFtZSwgbWF4SXRlbXMpXG5cbiMgUmVtb3ZlIGNhY2hlcyB3aG9zZSBuYW1lIGlzIG5vIGxvbmdlciB2YWxpZFxuY2xlYXJPbGRDYWNoZXMgPSAtPlxuXG5cdGNhY2hlcy5rZXlzKCkudGhlbiAoa2V5cykgLT5cblxuXHRcdFByb21pc2UuYWxsIGtleXMuZmlsdGVyIChrZXkpIC0+XG5cblx0XHRcdGtleS5pbmRleE9mKHZlcnNpb24pICE9IDBcblx0XHRcdHJldHVyblxuXG5cdFx0Lm1hcCAoa2V5KSAtPlxuXG5cdFx0XHRjYWNoZXMuZGVsZXRlIGtleVxuXG5zZWxmLmFkZEV2ZW50TGlzdGVuZXIgXCJpbnN0YWxsXCIsIChldmVudCkgLT5cblxuXHRldmVudC53YWl0VW50aWwgdXBkYXRlU3RhdGljQ2FjaGUoKS50aGVuIC0+XG5cblx0XHRzZWxmLnNraXBXYWl0aW5nKClcblxuc2VsZi5hZGRFdmVudExpc3RlbmVyIFwiYWN0aXZhdGVcIiwgKGV2ZW50KSAtPlxuXG5cdGV2ZW50LndhaXRVbnRpbCBjbGVhck9sZENhY2hlcygpLnRoZW4gLT5cblxuXHRcdHNlbGYuY2xpZW50cy5jbGFpbSgpXG5cbnNlbGYuYWRkRXZlbnRMaXN0ZW5lciBcIm1lc3NhZ2VcIiwgKGV2ZW50KSAtPlxuXG5cdGlmIGV2ZW50LmRhdGEuY29tbWFuZCA9PSBcInRyaW1DYWNoZXNcIlxuXHRcdHRyaW1DYWNoZSBwYWdlc0NhY2hlTmFtZSwgMzVcblx0XHR0cmltQ2FjaGUgaW1hZ2VzQ2FjaGVOYW1lLCAyMFxuXG5zZWxmLmFkZEV2ZW50TGlzdGVuZXIgXCJmZXRjaFwiLCAoZXZlbnQpIC0+XG5cblx0cmVxdWVzdCA9IGV2ZW50LnJlcXVlc3Rcblx0dXJsID0gbmV3IFVSTCByZXF1ZXN0LnVybFxuXG5cdCMgT25seSBkZWFsIHdpdGggcmVxdWVzdHMgdG8gbXkgb3duIHNlcnZlclxuXHRpZiB1cmwub3JpZ2luICE9IGxvY2F0aW9uLm9yaWdpblxuXHRcdHJldHVyblxuXG5cdCMgRm9yIG5vbi1HRVQgcmVxdWVzdHMsIHRyeSB0aGUgbmV0d29yayBmaXJzdCwgZmFsbCBiYWNrIHRvIHRoZSBvZmZsaW5lIHBhZ2Vcblx0aWYgcmVxdWVzdC5tZXRob2QgIT0gXCJHRVRcIlxuXHRcdGV2ZW50LnJlc3BvbmRXaXRoIGZldGNoKHJlcXVlc3QpLmNhdGNoIC0+XG5cdFx0XHRjYWNoZXMubWF0Y2ggXCIvb2ZmbGluZVwiXG5cblx0IyBGb3IgSFRNTCByZXF1ZXN0cywgdHJ5IHRoZSBuZXR3b3JrIGZpcnN0LCBmYWxsIGJhY2sgdG8gdGhlIGNhY2hlLCBmaW5hbGx5IHRoZSBvZmZsaW5lIHBhZ2Vcblx0aWYgcmVxdWVzdC5oZWFkZXJzLmdldChcIkFjY2VwdFwiKS5pbmRleE9mKFwidGV4dC9odG1sXCIpICE9IC0xXG5cblx0XHQjIEZpeCBmb3IgQ2hyb21lIGJ1ZzogaHR0cHM6Ly9jb2RlLmdvb2dsZS5jb20vcC9jaHJvbWl1bS9pc3N1ZXMvZGV0YWlsP2lkPTU3MzkzN1xuXHRcdGlmIHJlcXVlc3QubW9kZSAhPSBcIm5hdmlnYXRlXCJcblx0XHRcdHJlcXVlc3QgPSBuZXcgUmVxdWVzdCh1cmwsXG5cdFx0XHRcdG1ldGhvZDogXCJHRVRcIlxuXHRcdFx0XHRoZWFkZXJzOiByZXF1ZXN0LmhlYWRlcnNcblx0XHRcdFx0bW9kZTogcmVxdWVzdC5tb2RlXG5cdFx0XHRcdGNyZWRlbnRpYWxzOiByZXF1ZXN0LmNyZWRlbnRpYWxzXG5cdFx0XHRcdHJlZGlyZWN0OiByZXF1ZXN0LnJlZGlyZWN0KVxuXG5cdFx0ZXZlbnQucmVzcG9uZFdpdGggZmV0Y2gocmVxdWVzdCkudGhlbiAocmVzcG9uc2UpIC0+XG5cdFx0XHQjIE5FVFdPUktcblx0XHRcdCMgU3Rhc2ggYSBjb3B5IG9mIHRoaXMgcGFnZSBpbiB0aGUgcGFnZXMgY2FjaGVcblx0XHRcdGNvcHkgPSByZXNwb25zZS5jbG9uZSgpXG5cdFx0XHRzdGFzaEluQ2FjaGUgcGFnZXNDYWNoZU5hbWUsIHJlcXVlc3QsIGNvcHlcblx0XHRcdHJlc3BvbnNlXG5cdFx0LmNhdGNoIC0+XG5cdFx0XHQjIENBQ0hFIG9yIEZBTExCQUNLXG5cdFx0XHRjYWNoZXMubWF0Y2gocmVxdWVzdCkudGhlbiAocmVzcG9uc2UpIC0+XG5cdFx0XHRcdHJlc3BvbnNlIG9yIGNhY2hlcy5tYXRjaCBcIi9vZmZsaW5lXCJcblxuXHQjIEZvciBub24tSFRNTCByZXF1ZXN0cywgbG9vayBpbiB0aGUgY2FjaGUgZmlyc3QsIGZhbGwgYmFjayB0byB0aGUgbmV0d29ya1xuXHRldmVudC5yZXNwb25kV2l0aCBjYWNoZXMubWF0Y2gocmVxdWVzdCkudGhlbiAocmVzcG9uc2UpIC0+XG5cdFx0IyBDQUNIRVxuXHRcdHJlc3BvbnNlIG9yIGZldGNoKHJlcXVlc3QpLnRoZW4gKHJlc3BvbnNlKSAtPlxuXHRcdFx0IyBORVRXT1JLXG5cdFx0XHQjIElmIHRoZSByZXF1ZXN0IGlzIGZvciBhbiBpbWFnZSwgc3Rhc2ggYSBjb3B5IG9mIHRoaXMgaW1hZ2UgaW4gdGhlIGltYWdlcyBjYWNoZVxuXHRcdFx0aWYgcmVxdWVzdC5oZWFkZXJzLmdldChcIkFjY2VwdFwiKS5pbmRleE9mKFwiaW1hZ2VcIikgIT0gLTFcblx0XHRcdFx0Y29weSA9IHJlc3BvbnNlLmNsb25lKClcblx0XHRcdFx0c3Rhc2hJbkNhY2hlIGltYWdlc0NhY2hlTmFtZSwgcmVxdWVzdCwgY29weVxuXHRcdFx0cmVzcG9uc2Vcblx0XHQuY2F0Y2ggLT5cblx0XHRcdCMgT0ZGTElORVxuXHRcdFx0IyBJZiB0aGUgcmVxdWVzdCBpcyBmb3IgYW4gaW1hZ2UsIHNob3cgYW4gb2ZmbGluZSBwbGFjZWhvbGRlclxuXHRcdFx0aWYgcmVxdWVzdC5oZWFkZXJzLmdldCgnQWNjZXB0JykuaW5kZXhPZignaW1hZ2UnKSAhPSAtMVxuXHRcdFx0XHRyZXR1cm4gbmV3IFJlc3BvbnNlIFwiPHN2ZyByb2xlPSdpbWcnIGFyaWEtbGFiZWxsZWRieT0nb2ZmbGluZS10aXRsZScgdmlld0JveD0nMCAwIDQwMCAzMDAnIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2Zyc+PHRpdGxlIGlkPSdvZmZsaW5lLXRpdGxlJz5PZmZsaW5lPC90aXRsZT48ZyBmaWxsPSdub25lJyBmaWxsLXJ1bGU9J2V2ZW5vZGQnPjxwYXRoIGZpbGw9JyNEOEQ4RDgnIGQ9J00wIDBoNDAwdjMwMEgweicvPjx0ZXh0IGZpbGw9JyM5QjlCOUInIGZvbnQtZmFtaWx5PSdIZWx2ZXRpY2EgTmV1ZSxBcmlhbCxIZWx2ZXRpY2Esc2Fucy1zZXJpZicgZm9udC1zaXplPSc3MicgZm9udC13ZWlnaHQ9J2JvbGQnPjx0c3BhbiB4PSc5MycgeT0nMTcyJz5vZmZsaW5lPC90c3Bhbj48L3RleHQ+PC9nPjwvc3ZnPlwiLCBoZWFkZXJzOiBcIkNvbnRlbnQtVHlwZVwiOiBcImltYWdlL3N2Zyt4bWxcIiJdfQ==

//# sourceMappingURL=service-worker.js.map
