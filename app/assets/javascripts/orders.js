(function() {
  var app = angular.module('ordersApp', []);

  app.controller('PendingController', ['$http','$scope', '$interval', function($http, $scope, $interval){
    var store = this;
    store.pending = [];
    
    this.getPendingOrders = function() {
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

    $scope.cancel = function(line_id) {
      $http.get('/order_lines/'+line_id+'/cancel.json')
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
    $interval(this.getPendingOrders, 5000);      

	//initial load
	this.getPendingOrders();
	
  }]);

  app.controller('WaiterController', ['$http','$scope', '$interval', function($http, $scope, $interval){
    var store = this;
    store.waiting_waiter = [];
    store.waiting_payment = [];
    
    this.getOrdersWaitingPayment = function() {
      $http.get('/orders_waiting_payment.json')
		.success(function(data){
			store.waiting_payment = data;
		});
    };
        
    this.getOrdersWaitingWaiter = function() {
      $http.get('/orders_waiting_waiter.json')
		.success(function(data){
			store.waiting_waiter = data;
		});
    };
	
	this.load = function(){
		this.getOrdersWaitingWaiter();
		this.getOrdersWaitingPayment();
	};
	
    $scope.pay = function(order_id) {
      $http.get('/orders/'+order_id+'/pay.json')
		.success(function(data){
		  store.waiting_payment = data;
		});
    };
    
    $scope.processing = function(order_id) {
      $http.get('/orders/'+order_id+'/processing.json')
		.success(function(data){
		  store.waiting_waiter = data;
		});
    };
    
    $scope.cancel = function(order_id) {
      $http.get('/orders/'+order_id+'/cancel.json')
		.success(function(data){
		  this.load();
		});
    };
	       	
 	//Put in interval, first trigger after 5 seconds 
    $interval(this.load(), 5000);      

	//initial load
	this.load();
	
  }]);

  app.controller('CurrentOrderController', ['$http','$scope', '$interval', function($http, $scope, $interval){
    var store = this;
    store.order = {};

    this.getCurrentOrder = function() {
      $http.get('/current_order.json')
		.success(function(data){
			store.order = data;
		});
    };

    $scope.requestWaiter = function(order_id) {
      $http.get('/orders/'+order_id+'/request_waiter.json')
		.success(function(data){
			store.order = data;
		});
    };

    $scope.requestPayment = function(order_id) {
      $http.get('/orders/'+order_id+'/request_payment.json')
		.success(function(data){
			store.order = data;
		});
    };
    
	$scope.isCanceled = function(status) {
	  if(status === 'Canceled'){
	  	return true;
	  }
	};

	$scope.waiterRequested = function(status) {
	  if(status === 'Waiter Requested'){
	  	return true;
	  } 
	};

	$scope.paymentRequested = function(status) {
	  if(status === 'Payment Requested'){
	  	return true;
	  } 
	};
		       	
 	//Put in interval, first trigger after 5 seconds 
    $interval(this.getCurrentOrder, 5000);      

	//initial load
	this.getCurrentOrder();
	
  }]);
  
  app.config(['$httpProvider', function($httpProvider){
	authToken = $("meta[name=\"csrf-token\"]").attr("content");
	$httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
  }]);  
  
  app.directive('confirmationNeeded', function () {
	  return {
	    priority: 1,
	    link: function (scope, element, attr) {
	      var msg = attr.confirmationNeeded || "Are you sure?";
	      element.bind('click',function (event) {
	        if ( !window.confirm(msg) ) {
	          event.stopImmediatePropagation();
	        }
	        
	      });
	    }
	  };
  });
})();
