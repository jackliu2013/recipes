Ext.define('AM.view.user.List' ,{
    extend: 'Ext.grid.Panel',	/* 继承Ext.grid.Panel 类*/
    alias: 'widget.userlist',	/* 别名widget.userlist 	*/

    title: 'All Users',

    // we no longer define the Users store in the `initComponent` method
    store: 'Users',	/* 指定view 的store */

    initComponent: function() {
        this.store = {
            fields: ['name', 'email'],
            data  : [
                {name: 'Ed',    email: 'ed@sencha.com'},
                {name: 'Tommy', email: 'tommy@sencha.com'}
            ]
        };

        this.columns = [
            {header: 'Name',  dataIndex: 'name',  flex: 1},
            {header: 'Email', dataIndex: 'email', flex: 1}
        ];

        this.callParent(arguments);
    }
});
