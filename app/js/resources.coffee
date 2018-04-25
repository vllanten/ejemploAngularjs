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

_resourcesREST = (configuraciones, $resource)->
    $resource configuraciones.urlRest + "/users/:id", {},


app.factory "recursos", [ "configuraciones", "$resource",  _resources ]
app.factory "recursosjsonplaceholder", [ "configuraciones", "$resource",  _resourcesREST ]        