// 取得目前頁面的 URL
var currentURL = window.location.href;

// 取得導航項目的節點列表
var navItems = document.querySelectorAll('.navbar-nav .nav-item');

// 迭代導航項目列表
navItems.forEach(function(item) {
  // 取得導航項目的連結
  var link = item.querySelector('.nav-link');

  // 檢查連結的 href 屬性是否和目前頁面的 URL 相同
  if (link.getAttribute('href') === currentURL) {
    // 添加顯示效果（例如設置文字顏色為藍色）
    link.style.color = 'blue';
  }
});
