function ready() {
  var text = ["a Minecraft PVP community", "a dedicated team of creators",
  "a reliable network of game servers", "crafted for your enjoyment"];
  var pointer = 1;
  var item = $(".hs-is");
  setInterval(function() {
    item.fadeOut(500, function() {
      item.text(text[pointer]);
      item.fadeIn(500);
      pointer++;
      if (pointer >= text.length) pointer = 0;
    });
  }, 5000);
}

$(document).ready(ready);
