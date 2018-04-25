@app = angular.module("appExemplo", [ 'ngResource' ] )
_configuraciones = ()->
    {
        urlApi : "http://104.131.187.65:1880",
        urlRest: "https://jsonplaceholder.typicode.com"
    }
app.factory "configuraciones", [ _configuraciones ]