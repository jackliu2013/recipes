Ext.define('AM.store.Users', {

/* 第一种方法
    extend: 'Ext.data.Store',
  //  fields: ['name', 'email'],
    model: 'AM.model.User',

    data: [
        {name: 'Ed',    email: 'ed@sencha.com'},
        {name: 'Tommy', email: 'tommy@sencha.com'}
    ]
*/

/* 第二种方法 */
    extend: 'Ext.data.Store',
    model: 'AM.model.User',
    autoLoad: true,

/*
    proxy: {
        type: 'ajax',
        url: 'data/users.json',
        reader: {
            type: 'json',
            root: 'users',
            successProperty: 'success'
        }
    }
*/
  proxy: {
    type: 'ajax',
    api: {
        read: 'data/users.json',
        update: 'data/updateUsers.json'
    },
    reader: {
        type: 'json',
        root: 'users',
        successProperty: 'success'
    }
}

});
