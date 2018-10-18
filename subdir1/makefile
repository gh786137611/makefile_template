objs := $(wildcard *.cpp)
objs := $(patsubst %.cpp, %.o, $(objs))
objs := $(addprefix $(OUTPUT_DIR)/, $(objs))
obj_dir := $(OUTPUT_DIR)

$(objs): $(obj_dir)/%.o : %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

