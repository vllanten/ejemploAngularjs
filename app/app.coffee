app = angular.module("appExemplo", [ 'ngResource' ] )

_configuraciones = ()->
    {
        urlApi : "http://104.131.187.65:1880"
    }

_directivaListadoAFP = ($http, configuraciones)->
    {
        restrict: 'E'
        scope: {}
        template: "<ul>
            <li ng-repeat=' afp in afps'> {{afp}}</li>
        </ul>"
        link: ($scope)->
            $http.get(configuraciones.urlApi+"/afp").then (resp)->
               $scope.afps = resp.data
    }

_directivaSelectorAFP = (recursos)->
    {
        restrict: 'E'
        scope: {}
        templateUrl: "templates/directive.selector.afp.html"
        link: ($scope)->
            recursos.afp (resp)->
                $scope.afps = resp
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
            isArray: true

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

app.factory "configuraciones", [ _configuraciones ]
app.factory "recursos", [ "configuraciones", "$resource",  _resources ]
app.directive 'listadoAfp', [ "$http", "configuraciones",   _directivaListadoAFP ]
app.directive 'selectorAfp', [ "recursos",  _directivaSelectorAFP ]
app.controller "indexController", ["$scope", "recursos", indexController ]