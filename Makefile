build_type?="Release"

.PHONY: clean cmake all

all: tandem_mapper

cmake:
	mkdir -p build
	cd build && cmake .. -DCMAKE_BUILD_TYPE="${build_type}"

tandem_mapper: cmake
	$(MAKE) -C build all
	mkdir -p build/bin && ln -s -f $(abspath build/src/projects/tandem_mapper/tandem_mapper) build/bin/tandem_mapper

test_launch: tandem_mapper
	build/bin/tandem_mapper \
		--target test_dataset/test_target.fasta \
		--queries test_dataset/test_query.fasta -o test_dataset/test_launch
	grep -q "Thank you for using TandemMapper2!" test_dataset/test_launch/tandem_mapper.log

clean:
	-rm -r build
	-rm -r test_dataset/test_launch
