	meantodo = angular.module 'meantodo', []

	mainController = ($scope, $http) ->
		$scope.formdata = {}

		$http.get '/api/todos'
			.success (data) ->
				$scope.todos = data
				console.log data

			.error (data) ->
				console.log 'Error #{data}'

		$scope.createTodo = () ->
			$http.post '/api/todos', $scope.formdata
				.success (data) ->
					$scope.formData = {}
					$scope.todos = data
					console.log data

				.error (data) ->
					console.log 'Error #{data}'

		$scope.deleteTodo = (id) ->
			$http.delete '/api/todos/#{id}'
				.success (data) ->
					$scope.todos = data
					console.log data

				.error (data) ->
					console.log 'Error #{data}'
					

