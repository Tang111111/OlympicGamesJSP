// JavaScript Document
/* 点击按钮，下拉菜单在 显示/隐藏 之间切换 */
function myFunction1() {
    document.getElementById("myDropdown1").classList.toggle("show");
}

function myFunction2() {
    document.getElementById("myDropdown2").classList.toggle("show");
}


// 点击下拉菜单以外区域隐藏
window.onclick = function(e) {
  if (!e.target.matches('.dropbutton')) {
    var myDropdown1 = document.getElementById("myDropdown1");
    var myDropdown2 = document.getElementById("myDropdown2");
      if (myDropdown1.classList.contains('show')) {
        myDropdown1.classList.remove('show');
      }
	
	  if (myDropdown2.classList.contains('show')) {
        myDropdown2.classList.remove('show');
      }
  }
}