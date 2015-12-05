// Hook is strictly to give us an easy way to demonstrate the rest of Porter
var Hook = function (elementId) {
  this.elementId = elementId;
  this.element = document.getElementById(elementId);
  if(!this.element) {
		console.error("Failed to hook to element " + elementId);
    return;
	}
};

Hook.prototype.render = function (data) {
  if(!this.element) {
    console.error("Missing element; possibly bad scope");
    return;
  }
	this.element.innerHTML = data;
};

