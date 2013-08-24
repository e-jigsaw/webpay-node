module.exports = (grunt)->
	grunt.initConfig
		pkg: "<json:package.json>"
		coffee:
			index:
				files:
					"index.js": "index.coffee"
				options:
					bare: true
			lib:
				files:
					"lib/request.js": "lib/request.coffee"
					"lib/charge.js": "lib/charge.coffee"
					"lib/customer.js": "lib/customer.coffee"
					"lib/token.js": "lib/token.coffee"
					"lib/event.js": "lib/event.coffee"
					"lib/account.js": "lib/account.coffee"
				options:
					bare: true
			test:
				files:
					"tests/index.js": "tests/index.coffee"
				options:
					bare: true
		mochaTest:
			index:
				src: 
					"tests/index.js"
				options:
					reporter: "spec"

		
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-mocha-test"

	grunt.registerTask "c", ["coffee"]
	grunt.registerTask "t", ["coffee", "mochaTest"]
