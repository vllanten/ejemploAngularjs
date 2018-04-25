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
    
app.directive 'listadoAfp', [ "$http", "configuraciones",   _directivaListadoAFP ]
app.directive 'selectorAfp', [ "recursos",  _directivaSelectorAFP ]