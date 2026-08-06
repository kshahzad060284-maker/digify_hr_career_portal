(function () {
  var FADE_MS = 200;
  var SAFETY_TIMEOUT_MS = 30000;

  var splash = document.getElementById("flutter-splash");
  if (!splash) return;

  var removed = false;

  function removeSplash() {
    if (!splash || !splash.parentNode) return;
    splash.parentNode.removeChild(splash);
  }

  function hideSplash() {
    if (removed) return;
    removed = true;

    splash.setAttribute("aria-busy", "false");
    splash.setAttribute("aria-hidden", "true");

    void splash.offsetWidth;
    splash.classList.add("fade-out");

    var cleaned = false;
    function finish() {
      if (cleaned) return;
      cleaned = true;
      removeSplash();
    }

    splash.addEventListener("transitionend", function onEnd(event) {
      if (event.target !== splash || event.propertyName !== "opacity") return;
      splash.removeEventListener("transitionend", onEnd);
      finish();
    });

    window.setTimeout(finish, FADE_MS + 80);
  }

  window.addEventListener("digify-app-ready", hideSplash, { once: true });
  window.setTimeout(hideSplash, SAFETY_TIMEOUT_MS);
})();
