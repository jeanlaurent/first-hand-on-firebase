angular.module 'reg', []

.controller 'RegisterController', class
  constructor: ->
    @dataLoaded = false
    @firebaseUrl = "https://flickering-inferno-3950.firebaseIO.com"
    @firebase = new Firebase(@firebaseUrl);
    @listenToNewSubscriber()

  reg: ->
    return unless @name? and @age?
    person =
      name: @name
      age: @age
      timestamp: new Date().toISOString()

    @firebase.child('persons').push person, (error) ->
          unless error
            console.log 'Successfull write'
          else
            console.log error


  listenToNewSubscriber: ->
    persons = new Firebase("#{@firebaseUrl}/persons")
    persons.once "value", () -> @dataLoaded = true
    persons.on "child_added", (snapshot) ->
      return unless @dataLoaded
      console.log "oh yeah new subscriber"
      console.log snapshot.val()