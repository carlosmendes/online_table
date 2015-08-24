(function() {
  var app = angular.module('pendingApp', []);

  app.controller('PendingController', ['$http','$scope', '$interval', function($http, $scope, $interval){
    var store = this;
    store.pending = [];

    this.search = function() {
      $http.get('/order_lines_pending.json')
		.success(function(data){
			store.pending = data;
		});
    };

    $scope.deliver = function(line_id) {
      $http.get('/order_lines/'+line_id+'/deliver.json')
		.success(function(data){
			store.pending = data;
		});
    };
    
    $scope.process = function(line_id) {
      $http.get('/order_lines/'+line_id+'/process_line.json')
		.success(function(data){
			store.pending = data;
		});
    };

    $scope.cancel = function(line) {
      $http.get('/order_lines/'+line.id+'/cancel.json')
		.success(function(data){
		  store.pending = data;
		});
    };

	$scope.processVisible = function(status) {
	  if(status !== 'Processing'){
	  	return true;
	  }
	  
	};
	       	
 	//Put in interval, first trigger after 5 seconds 
    $interval(this.search, 5000);      

	//initial load
	this.search();
	
  }]);
  
  app.config(['$httpProvider', function($httpProvider){
	authToken = $("meta[name=\"csrf-token\"]").attr("content");
	$httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
  }]);  
  
})();
