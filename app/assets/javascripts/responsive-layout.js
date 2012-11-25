jQuery(document).ready(function() {
   jQuery(".kubee-layout-row").each(function(){
        var row = jQuery(this);
        resizeCells(row, 360);
    });
});

window.onresize = function(event) {
    jQuery(".kubee-layout-row").each(function(){
        var row = jQuery(this);
        resizeCells(row, 360);
    });
};

window.onload = function(event) {
    jQuery(".kubee-layout-row").each(function(){
        var row = jQuery(this);
        resizeCells(row, 360);
    });
};

function resizeCells(row, minSize){
    var cells = row.children(".kubee-layout-cell");
    var numberOfCells = cells.length;
    cells.each(function(){
        var cell = jQuery(this);
        if(row.width() > minSize*4 && numberOfCells > 2){
            cell.addClass("kubee-layout-cell-25");
            cell.removeClass("kubee-layout-cell-33");
            cell.removeClass("kubee-layout-cell-50");
            cell.removeClass("kubee-layout-cell-100");
        }
        else if(row.width() > minSize*3 && row.width() < minSize*4 && numberOfCells > 2){
            cell.addClass("kubee-layout-cell-33");
            cell.removeClass("kubee-layout-cell-25");
            cell.removeClass("kubee-layout-cell-50");
            cell.removeClass("kubee-layout-cell-100");
        }
        else if(row.width() > minSize*2 && row.width() < minSize*3){
            cell.addClass("kubee-layout-cell-50");
            cell.removeClass("kubee-layout-cell-25");
            cell.removeClass("kubee-layout-cell-33");
            cell.removeClass("kubee-layout-cell-100");
        }
        else if(row.width() < minSize*2 ){
            cell.addClass("kubee-layout-cell-100");
            cell.removeClass("kubee-layout-cell-25");
            cell.removeClass("kubee-layout-cell-33");
            cell.removeClass("kubee-layout-cell-50");
        }
        resizeCells(cell, (minSize/2)-1);
    });
};