// document.addEventListener("turbolinks:load", function () {
//   document.querySelectorAll(".delete").forEach(function (a) {
//     a.addEventListener("ajax:success", function () {
//       var span = a.parentNode;
//       var li = span.parentNode;
//       li.style.display = "none";
//     });
//   });
// });

document.addEventListener("turbolinks:load", function () {
  document.querySelectorAll(".delete").forEach(function (a) {
    a.addEventListener("ajax:success", function () {
      var li = this.closest('li');
      if (li) li.style.display = "none";
    });
  });
});
