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
					"lib/base.js": "lib/base.coffee"
					"lib/charge.js": "lib/charge.coffee"
					"lib/customer.js": "lib/customer.coffee"
					"lib/token.js": "lib/token.coffee"
					"lib/event.js": "lib/event.coffee"
					"lib/account.js": "lib/account.coffee"
				options:
					bare: true
			util:
				files:
					"util/request.js": "util/request.coffee"
					"util/retrieve.js": "util/retrieve.coffee"
					"util/all.js": "util/all.coffee"
				options:
					bare: true
			test:
				files:
					"tests/index.js": "tests/index.coffee"
				options:
					bare: true
		mochacov:
			coverage:
				options:
					coveralls:
						serviceName: "travis-ci"
			test:
				options:
					reporter: "spec"
			options:
				files: "tests/*.js"

		
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-mocha-cov"

	grunt.registerTask "c", ["coffee"]
	grunt.registerTask "test", ["coffee", "mochacov:test"]
