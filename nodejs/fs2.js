var fs = require('fs');

function check_amt(a) {
    
}

fs.readFile('./f1.dat', 'utf-8', function(err, data) {
    if (err) throw err;
    console.log(data);
    var array = data.trim().split("\n");
    //var array = data.split("|");
    // console.log(array);
    var i = 0;
    for( i = 0; i < array.length; i++) {
        // console.log(array);
        console.log(array[i].split("|"));
    }
});
