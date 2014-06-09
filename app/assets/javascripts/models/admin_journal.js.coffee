a = DS.attr
ETahi.AdminJournal = DS.Model.extend
  logoUrl: a('string')
  name: a('string')
  paperTypes: a()
  taskTypes: a()
  manuscriptManagerTemplates: a('manuscriptManagerTemplate')
  roles: DS.hasMany('role')
  epubCoverUrl: a('string')
  epubCoverFileName: a('string')
  epubCss: a('string')
  pdfCss: a('string')
  manuscriptCss: a('string')