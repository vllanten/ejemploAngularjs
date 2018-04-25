indexController = ($scope, recursos)->

    console.log("mensaje por consola")
   
    $scope.sinUniverso = false
    $scope.sinBuscados = false

    # obtengo desde el recurso, el listado de elementos
    recursos.elementos (el)->
        $scope.elementos = el
        if(el.universo.length == 0)
            $scope.sinUniverso = true
        if(el.buscados.length == 0)
            $scope.sinBuscados = true

restController = ($scope, recursosjsonplaceholder)->
    newUser = {}
    $scope.enejecucion = false
    $scope.disableEliminar = []
    recursosjsonplaceholder.query (resp)->
        $scope.usuarios = resp

    $scope.searchFilter =  (obj) ->
        re = new RegExp($scope.searchText, 'i')
        return !$scope.searchText || 
            re.test(obj.name.toString()) || 
            re.test(obj.username.toString()) || 
            re.test(obj.email.toString()) || 
            re.test(obj.phone.toString())

    $scope.agregar = ()->
        $scope.enejecucion = true
        recursosjsonplaceholder.save newUser, (resp)->
            $scope.enejecucion = false
            $scope.newUser.id = resp.id
            $scope.usuarios.push($scope.newUser)
            $scope.newUser = {}

    $scope.eliminar = (usuario, index)->
        recursosjsonplaceholder.delete {id: usuario.id}, (resp)->
        $scope.usuarios.splice(index, 1)

app.controller "indexController", ["$scope", "recursos", indexController ]
app.controller "restController", ["$scope", "recursosjsonplaceholder", restController ]