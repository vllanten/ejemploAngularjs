app = angular.module("appExemplo", [ 'ngResource' ] )

_configuraciones = ()->
    {
        urlApi : "http://104.131.187.65:1880"
    }

_resources = (configuraciones, $resource)->
    $resource "", {},
        elementos:
            url: configuraciones.urlApi + "/elementos"
            method: 'GET'
            isArray: false
        afp:
            url: configuraciones.urlApi + "/afp"
            method: 'GET'
            isArray: false


indexController = ($scope, recursos)->
    # obtengo desde el recurso, el listado de elementos

    console.log("mensaje por consola")
    
    $scope.sinUniverso = false
    $scope.sinBuscados = false

    recursos.elementos (el)->
        $scope.elementos = el
        if(el.universo.length == 0)
            $scope.sinUniverso = true
        if(el.buscados.length == 0)
            $scope.sinBuscados = true




app.factory "configuraciones", [ _configuraciones ]
app.factory "recursos", [ "configuraciones", "$resource",  _resources ]
app.controller "indexController", ["$scope", "recursos", indexController ]