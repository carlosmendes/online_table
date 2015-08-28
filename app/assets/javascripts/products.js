(function() {
  var app = angular.module('productsApp', ['ordersApp']);

  app.controller('MenuController', ['$http','$scope', '$interval', function($http, $scope, $interval){

    $scope.order = function(product_id) {
		$http.post('/order_lines/create', {quantity: 1, product_id: product_id}).
		  then(function(response) {
		    // this callback will be called asynchronously
		    // when the response is available
		  }, function(response) {
		    // called asynchronously if an error occurs
		    // or server returns response with an error status.
		  });
    };
    
	
  }]);
  
  app.config(['$httpProvider', function($httpProvider){
	authToken = $("meta[name=\"csrf-token\"]").attr("content");
	$httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
  }]);  
  
})();
