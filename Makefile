check_jq:
	@{ for f in `find config/*.json`; do    		\
		RESULT=`jq . $$f > /dev/null 2>&1; echo $$?`;	\
                if [ "$${RESULT}" != 0 ]; then			\
			echo "Error: jq parsing error in $$f"; 	\
			exit 1; 				\
                fi;                                           	\
	    done; 						\
	};

check_url:
	@{ for f in `find config/*.json`; do    					\
		HEAD=`head -1 $$f`; 							\
		if [ "$$HEAD" == "{" ]; then 						\
			URL=`jq -r '.url' $$f`;                  			\
			if [ -z "$$URL" ] ; then                  			\
				echo "No URL (mandatory) for $$f";   			\
			else 								\
				URL_EXISTS=`wget --spider $$URL 2>/dev/null; echo $$?`; \
				if [ "$${URL_EXISTS}" != 0 ]; then 			\
					echo "Error: URL $$URL does not exist"; 	\
				fi; 							\
			fi;                                       			\
		else 									\
			URLS=`jq -r .[].url $$f`; 					\
			for u in "$$URLS"; do 						\
				URL_EXISTS=`wget --spider $$u 2>/dev/null; echo $$?`; 	\
				if [ "$${URL_EXISTS}" != 0 ]; then 			\
					echo "Error: URL $$u does not exist"; 		\
				fi; 							\
			done; 								\
		fi; 									\
	    done;                                        				\
	};
