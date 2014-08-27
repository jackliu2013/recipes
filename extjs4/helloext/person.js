Ext.application({
    name: 'HelloExt',
    launch: function() {
	var aaron = Ext.create('My.sample.Person', 'Aaron');
    	aaron.eat("Salad"); // alert("Aaron is eating: Salad");

        }
});
