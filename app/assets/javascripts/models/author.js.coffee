a = DS.attr
ETahi.Author = DS.Model.extend
  authorGroup: DS.belongsTo('authorGroup')

  firstName: a('string')
  middleInitial: a('string')
  lastName: a('string')
  fullName: (->
     "#{@get('firstName')} #{@get('middleInitial') || ''} #{@get('lastName')}"
  ).property('firstName', 'middleInitial', 'lastName')

  email: a('string')

  title: a('string')
  department: a('string')
  affiliation: a('string')
  secondaryAffiliation: a('string')

  corresponding: a('boolean')
  deceased: a('boolean')
  position: a('number')