$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('sites', ['index'])) {
    return;
  };

  // Color field progress cells based on completeness
  // 9 fish transects
  var ftranCells = document.querySelectorAll('td:nth-child(3)');
	for(var i = 0 ; i < ftranCells.length ; i++) {
		// If the cell is 9 or more, color it
	  if(ftranCells[i].textContent.trim() >= '9') {
	    ftranCells[i].classList.add('complete');
	  }
	}

	// 3 fish rovers
	var froveCells = document.querySelectorAll('td:nth-child(4)');
	for(var i = 0 ; i < froveCells.length ; i++) {
		// If the cell is 3 or more, color it
	  if(froveCells[i].textContent.trim() >= '3') {
	    froveCells[i].classList.add('complete');
	  }
	}

	// 6 coral healths
	var chealthCells = document.querySelectorAll('td:nth-child(5)');
	for(var i = 0 ; i < chealthCells.length ; i++) {
		// If the cell is 6 or more, color it
	  if(chealthCells[i].textContent.trim() >= '6') {
	    chealthCells[i].classList.add('complete');
	  }
	}

	// 6 algae heights
	var aheightCells = document.querySelectorAll('td:nth-child(6)');
	for(var i = 0 ; i < aheightCells.length ; i++) {
		// If the cell is 6 or more, color it
	  if(aheightCells[i].textContent.trim() >= '6') {
	    aheightCells[i].classList.add('complete');
	  }
	}
	// Ginsburg starts complete
	var siteCells = document.querySelectorAll('td:nth-child(2)');
	for(var i = 0 ; i < siteCells.length ; i++) {
		// If the cell is Ginsburg, color it complete
	  if(siteCells[i].textContent.trim() == 'Ginsburg Fringe') {
	  	ftranCells[i].classList.add('complete');
	  	froveCells[i].classList.add('complete');
	  	chealthCells[i].classList.add('complete');
	  	aheightCells[i].classList.add('complete');
	  }
	}
});