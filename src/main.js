// Import Bootstrap JavaScript
import 'bootstrap/dist/js/bootstrap.bundle.js'

// Custom JavaScript can be added here
console.log('Bootstrap loaded successfully!')

// 平滑滚动功能
document.addEventListener('DOMContentLoaded', function() {
  const links = document.querySelectorAll('a[href^="#"]');
  links.forEach(link => {
    link.addEventListener('click', function(e) {
      const href = this.getAttribute('href');
      if (href !== '#') {
        const target = document.querySelector(href);
        if (target) {
          e.preventDefault();
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      }
    });
  });
});

// 导航栏激活状态
window.addEventListener('scroll', function() {
  const sections = document.querySelectorAll('section[id], div[id]');
  const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
  
  let current = '';
  sections.forEach(section => {
    const sectionTop = section.offsetTop;
    const sectionHeight = section.clientHeight;
    if (pageYOffset >= sectionTop - 200) {
      current = section.getAttribute('id');
    }
  });
  
  navLinks.forEach(link => {
    link.classList.remove('active');
    if (link.getAttribute('href') === '#' + current) {
      link.classList.add('active');
    }
  });
});

// 页面加载动画
document.addEventListener('DOMContentLoaded', function() {
  const elements = document.querySelectorAll('.service-card, .section-content');
  elements.forEach((element, index) => {
    setTimeout(() => {
      element.classList.add('loaded');
    }, index * 100);
  });
});
