(function() {
  var app = angular.module('pendingApp', []);

  app.controller('PendingController', ['$http','$scope', function($http, $scope){
    var store = this;
    store.pending = [];

	  $http.get('/order_lines_pending.json')
		.success(function(data){
			store.pending = data;
		});
	
    this.search = function() {
      $http.get('/order_lines_pending.json')
		.success(function(data){
			store.pending = data;
		})
    	.failure(function(data){
        	console.log("failed :(", data);
    	});
    };

    $scope.deliver = function(line_id) {
      $http.get('/order_lines/'+line_id+'/deliver.json')
		.success(function(data){
			store.pending = data;
		});
    };  
    
  }]);
  
  app.config(['$httpProvider', function($httpProvider){
	authToken = $("meta[name=\"csrf-token\"]").attr("content");
	$httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
  }]);  
  
})();
