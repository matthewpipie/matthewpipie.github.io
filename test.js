function clickA(elm) {
	var evObj = document.createEvent('Events');
    evObj.initEvent('click', true, false);
    elm.dispatchEvent(evObj);
}

var selectDrew = function() {$("#PDI_answer45218547").click();};
var selectSam = function() {$("#PDI_answer45218549").click();};
var clickVote = function() {clickA(document.getElementById("pd-vote-button9875296"));};
var goBack = function() {PDV_go9875296();};

var good = true;
var stepOne = function() {selectDrew(); if (!good) {selectSam();}; setTimeout(stepTwo, 500);};
var stepTwo = function() {clickVote(); setTimeout(stepThree, 1500);};
var stepThree = function() {good = $(".pds-question-top").text().indexOf("voting") == 15; goBack(); setTimeout(stepOne, 500);};

stepOne();

// <div class="pds-question-top"> Thank you, we have already counted your vote. </div>
// <div class="pds-question-top"> Thank you for voting! </div>
