# For more information see: http://emberjs.com/guides/routing/
ETahi.Router.map ()->
  @route('flow_manager')
  @resource 'paper', { path: '/papers/:paper_id' }, ->
    @route('edit')
    @route('manage')
    @route('submit')
    @route('task', {path: '/tasks/:task_id'})

  @route('paper_new', { path: '/papers/new' })

  @route('task', {path: '/tasks/:task_id'})
  @route('signin', {path: '/users/sign_in'})

ETahi.Router.reopen({
  rootURL: '/'
  location: 'history'
})
