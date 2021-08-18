// Capture Chevron click event
document.getElementById('mb-chevron-icon').onclick = function(e){
  alert('click');
}

// Add Class float-right to mb-plus-icon
let plusIconElement = document.getElementById('mb-plus-icon');
plusIconElement.classList.add('float-right');
plusIconElement.classList.add('text-gray-400');

console.log(mojoBrain.addClassToElement());